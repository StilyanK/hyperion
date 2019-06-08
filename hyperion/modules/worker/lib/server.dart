import 'dart:async';

import 'package:cl_base/server.dart' as base;
import 'package:mapper/mapper.dart';
import 'package:task/task.dart' as task;

import 'src/ctrl.dart';
import 'src/mapper.dart';
import 'src/permission.dart';

export 'src/mapper.dart';

/// Bootstrap function - server part
void init() {
  // Register Person's routes to the application
  base.routes.add(routesWorker);
  base.routes.add(routesBrigade);
  base.routes.add(routesCar);
  base.routes.add(routesDictionary);

  notifierCar.onChange.listen((cont) {
    new task.ScheduleManager()
        .get('insurance')
        .removeEventsById('car${cont.entity.car_id}');
    _scheduleInsurance(cont.entity);
    _scheduleVignette(cont.entity);
    _scheduleYearCheck(cont.entity);
  });
  // List for person insert
  entityWorker.onCreate.listen((cont) {});

  // Test db query
//  base.dbWrap<void, App>(new App(), (manager) async {
//    var c = await manager.app.person.findAll();
//    print('From Person - Person - findAll: $c');
//  });

  _startUp();

  base.permissionRegister(Group.Worker, Scope.Worker, ['crud'], true);
}

void _startUp() {
  final schedule = new task.Schedule();
  new task.ScheduleManager().register('insurance', schedule);
  new task.ScheduleManager().register('vignette', schedule);
  new task.ScheduleManager().register('year_check', schedule);
  base.dbWrap<void, App>(new App(), (manager) async {
    final car = await manager.app.car.findAll();
    for (var c in car) {
      final dateNow = DateTime.now();

      final insuranceDateExpired =
          dateNow.difference(c.insurance_expires).inDays <= 7;
      print(insuranceDateExpired);
      final vignetteDateExpired =
          dateNow.difference(c.vignette_expires).inDays <= 7;
      final DateYearCheckExpired =
          dateNow.difference(c.year_check_expires).inDays <= 7;

      if (insuranceDateExpired) {
        _scheduleInsurance(c);
      }
      if (vignetteDateExpired) {
        _scheduleVignette(c);
      }
      if (DateYearCheckExpired) {
        _scheduleYearCheck(c);
      }
    }
  });
}

void _scheduleInsurance(Car car) {
  new task.ScheduleManager()
      .get('insurance')
      .addEvent(new task.ScheduleEvent('car${car.car_id}', () async {
        final wsClients = await base.getWSClients();

//        final now = DateTime.now();
//        final isAfter = car.insurance_expires.isAfter(now);
//        print(isAfter);
        print('heree insurance');
        for (var cl in wsClients) {
          cl.send('event insurance', {
            'event': 'insurance',
            'id': car.car_id,
            'text': 'Застраховката изтича ${car.car_id}!',
            'date': car.insurance_expires.toString()
          });
        }
      }, execute_at: car.insurance_expires));
}

void _scheduleVignette(Car car) {
  new task.ScheduleManager()
      .get('vignette')
      .addEvent(new task.ScheduleEvent('car${car.car_id}', () async {
        final wsClients = await base.getWSClients();

        print('here vignette');
        for (var cl in wsClients) {
          cl.send('event vignette', {
            'event': 'vignette',
            'id': car.car_id,
            'text': 'Винетката изтича ${car.car_id}!',
            'date': car.vignette_expires.toString()
          });
        }
      }, execute_at: car.vignette_expires));
}

void _scheduleYearCheck(Car car) {
  new task.ScheduleManager()
      .get('year_check')
      .addEvent(new task.ScheduleEvent('car${car.car_id}', () async {
        final wsClients = await base.getWSClients();

        print('heree year check');
        for (var cl in wsClients) {
          cl.send('event year_check', {
            'event': 'year_check',
            'id': car.car_id,
            'text': 'Годишен преглед изтича ${car.car_id}!',
            'date': car.year_check_expires.toString()
          });
        }
      }, execute_at: car.year_check_expires));
}

Future<void> testMapper(Manager<App> m) async {
  final c = await m.app.worker.findAll();
  print('Cross package manager - Person - findAll: $c');
}
