import 'package:cl/app.dart' as cl_app;

import 'src/gui.dart';
import 'src/permission.dart';

export 'src/gui.dart';

abstract class MenuItem {
  static final cl_app.MenuElement Workers = new cl_app.MenuElement()
    ..title = 'Работници'
    ..icon = Icon.Worker;

  static final cl_app.MenuElement WorkerNew = new cl_app.MenuElement()
    ..title = 'Нов работник'
    ..icon = Icon.Worker
    ..scope = '${Group.Worker}:${Scope.Worker}:read'
    ..action = (ap) => ap.run('worker/0');

  static final cl_app.MenuElement WorkerList = new cl_app.MenuElement()
    ..title = 'Работници'
    ..icon = Icon.WorkerList
    ..scope = '${Group.Worker}:${Scope.Worker}:read'
    ..action = (ap) => ap.run('worker/list');

  static final cl_app.MenuElement Brigade = new cl_app.MenuElement()
    ..title = 'Обекти/Заплати'
    ..icon = Icon.Brigade;

  static final cl_app.MenuElement BrigadeNew = new cl_app.MenuElement()
    ..title = 'Нов обект'
    ..icon = Icon.Brigade
    ..scope = '${Group.Worker}:${Scope.Worker}:read'
    ..action = (ap) => ap.run('brigade/0');

  static final cl_app.MenuElement BrigadeList = new cl_app.MenuElement()
    ..title = 'Списък обекти/Заплати'
    ..icon = Icon.WorkerList
    ..scope = '${Group.Worker}:${Scope.Worker}:read'
    ..action = (ap) => ap.run('brigade/list');

  static final cl_app.MenuElement SalaryWorker = new cl_app.MenuElement()
    ..title = 'Заплати/Работници'
    ..icon = Icon.Salary
    ..scope = '${Group.Worker}:${Scope.Worker}:read'
    ..action = (ap) => ap.run('salary_workers/0');

  static final cl_app.MenuElement Car = new cl_app.MenuElement()
    ..title = 'Превозни средства'
    ..icon = Icon.Car;

  static final cl_app.MenuElement CarNew = new cl_app.MenuElement()
    ..title = 'Създай превозно средство'
    ..icon = Icon.Car
    ..scope = '${Group.Worker}:${Scope.Worker}:read'
    ..action = (ap) => ap.run('car/0');

  static final cl_app.MenuElement CarList = new cl_app.MenuElement()
    ..title = 'Списък превозни средства'
    ..icon = Icon.Car
    ..scope = '${Group.Worker}:${Scope.Worker}:read'
    ..action = (ap) => ap.run('car/list');

  static final cl_app.MenuElement Dictionary = new cl_app.MenuElement()
    ..title = 'Дневник'
    ..icon = Icon.Dictionary
    ..scope = '${Group.Worker}:${Scope.Worker}:read'
    ..action = (ap) => ap.run('dictionary/0');


}

/// Bootstrap function - client part
void init(cl_app.Application ap) {
  ap
    ..addRoute(new cl_app.Route('worker/:int', (ap, p) => new Worker(ap, p[0])))
    ..addRoute(new cl_app.Route('worker/list', (ap, p) => new WorkerList(ap)))
    ..addRoute(
        new cl_app.Route('brigade/:int', (ap, p) => new Brigade(ap, p[0])))
    ..addRoute(new cl_app.Route('brigade/list', (ap, p) => new BrigadeList(ap)))
    ..addRoute(new cl_app.Route('car/:int', (ap, p) => new Car(ap, p[0])))
    ..addRoute(new cl_app.Route('car/list', (ap, p) => new CarList(ap)))
    ..addRoute(new cl_app.Route('dictionary/:int', (ap, p) => new Dictionary(ap, p[0])));

  ap.onServerCall.filter('event insurance').listen((res) {
    ap.notify.add(new cl_app.NotificationMessage.fromMap(res));
  });
}
