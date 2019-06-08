part of person.ctrl;

class ICar extends base.Item<App, Car, int> {
  final String group = Group.Worker;

  final String scope = Scope.Worker;

  ICar(req) : super(req, new App());

  Future<Map> doGet(int id) async {
    final car = await manager.app.car.find(id);
    if (car == null) throw new base.ResourceNotFoundException();
    return car.toJson();
  }

  Future<int> doSave(int id, Map data) async {
    final car = await manager.app.car.prepare(id, data);
    await manager.commit();
    return car.car_id;
  }

  Future<bool> doDelete(int id) => manager.app.car.deleteById(id);
}
