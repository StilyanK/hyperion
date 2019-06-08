part of person.ctrl;

class CCar extends base.Collection<App, Car, int> {
  final String group = Group.Worker;

  final String scope = Scope.Worker;

  CCar(req) : super(req, new App());

  Future<CollectionBuilder> doGet(Map filter, Map order, Map paginator) async {
    final cb = manager.app.car.findAllByBuilder()
      ..filterRule = (new FilterRule()..eq = ['car_id'])
      ..filter = filter
      ..order(order['field'], order['way'])
      ..page = paginator['page']
      ..limit = paginator['limit'];

    return cb.process(true);
  }

//  Future<Map> lister(Car o) async {
//    final data = o.toJson();
//
//
//    data['name'] = o.name;
//    data['work_days'] = 0;
//    return data;
//  }

  Future<bool> doDelete(List ids) =>
      Future.wait(ids.map(manager.app.car.deleteById)).then((_) => true);

  Future<void> suggest() => run(group, scope, 'read', () async {
        manager = await new Database().init(new App());
        final params = await getData();
        if (params['suggestion'] != null) {
          final name = params['suggestion'];
          final col = await manager.app.car.findAllByName(name);
          return response(col.pair());
        } else {
          final ent = await manager.app.car.find(params['id']);
          return response([ent.pair()]);
        }
      });
}
