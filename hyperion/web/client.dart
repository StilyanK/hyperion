import 'dart:html';

import 'package:cl/app.dart' as cl_app;
import 'package:cl_base/client.dart' as base;
import 'package:communicator/client.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:worker/client.dart' as worker;

import 'intl/messages_all.dart';

main() async {
  var ap = new cl_app.Application(
      settings: new cl_app.AppSettings()..baseurl = '/centryl/')
    ..setAbout('/centryl/packages/cl_base/images/logo.svg', 'Menu');
  await initData(ap);
  await initLocale(ap);

  base.init(ap);
  worker.init(ap);
//  job.init(ap);

  // Setup Application Menu
  ap.setMenu([
    worker.MenuItem.Workers
      ..addChild(worker.MenuItem.WorkerNew)
      ..addChild(worker.MenuItem.WorkerList),
    worker.MenuItem.Brigade
      ..addChild(worker.MenuItem.BrigadeNew)
      ..addChild(worker.MenuItem.BrigadeList),
    worker.MenuItem.Car
      ..addChild(worker.MenuItem.CarNew)
      ..addChild(worker.MenuItem.CarList),
  worker.MenuItem.Dictionary


  ]);

  ap.done();
}

initLocale(cl_app.Application ap) async {
  var loc =
      (ap.client.settings == null) ? 'auto' : ap.client.settings['language'];
  var locale = (loc == 'auto') ? Intl.getCurrentLocale() : loc;
  if (locale != 'en_US') {
    await initializeMessages(locale.split('_').first);
    Intl.defaultLocale = locale;
    await initializeDateFormatting(locale, null);
  }
}

initData(cl_app.Application ap) async {
  var communicator = new Communicator(ap.baseurl);
  await communicator
      .upgrade('${window.location.protocol.endsWith('ps:') ? 'wss' : 'ws'}://'
          '${window.location.host}${ap.baseurl}ws');
  ap.on_server_call = communicator.onServerCall;
  ap.server_call = communicator.send;
  var data = await ap.serverCall('/init', null);
  ap.setClient(new cl_app.Client(data));
}
