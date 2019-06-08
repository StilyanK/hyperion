import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cl_base/api.dart' as cl_base_api;
import 'package:cl_base/server.dart' as cl_base;
import 'package:intl/date_symbol_data_local.dart';
import 'package:logging/logging.dart';
import 'package:mapper/mapper.dart' show Database, Pool;
import 'package:task/task.dart' as task;
import 'package:worker/server.dart' as worker;
import 'package:yaml/yaml.dart';

import 'intl/messages_all.dart';

// Base server libraries
// API libraries
//, job.init
/// Registering init function for each package
final List init = <Function>[cl_base.init, worker.init];

/// Registering api init function for each package
final List api = <Function>[];

void main(List<String> args) {
  cl_base.path = args.length == 1
      ? args.first
      : Directory.current.path.endsWith('bin') ? '..' : '.';
  cl_base.logHandler();
  final log = new Logger('App');
  runZoned(() async {
// Initialize default server locale
    await Future.forEach(['bg'], (locale) async {
      await initializeMessages(locale);
      await initializeDateFormatting(locale, null);
    });

// Setup database and manager
    final Map config = loadYaml(
        await new File('${cl_base.path}/config/config.yaml')
            .readAsString(encoding: utf8));

// Normally we don't want this
    cl_base.anonymousLogin = true;

    if (config.containsKey('devmode') && config['devmode'] is bool)
      cl_base.devmode = config['devmode'];
    final pool = new Pool(
        config['db']['host'], config['db']['port'], config['db']['database'],
        user: config['db']['user'], password: config['db']['password']);
    await pool.start();
    new Database().registerPool(pool);

// Iterates over init functions and starts HTTP servers
    await Future.forEach(init, (f) => f());
    await Future.forEach(api, (f) => f());
    await Future.wait([
      cl_base.server(config['app']['centryl']['address'],
          config['app']['centryl']['port']),
      cl_base_api.server(
          config['app']['api']['address'], config['app']['api']['port'])
    ]);

// SIG processing
    void _serverDown(_) async {
      cl_base.onServerDown();
      await pool.destroy();
      new task.ScheduleManager().destroy();
      log.info('Hyperion stopped!');
      new Timer(new Duration(seconds: 1), () => exit(0));
    }

    ProcessSignal.sighup.watch().listen(_serverDown);
    ProcessSignal.sigterm.watch().listen(_serverDown);
    ProcessSignal.sigint.watch().listen(_serverDown);
    log.info('Hyperion started!');
  }, onError: (e, s) => log.shout('Error', e, s));
}
