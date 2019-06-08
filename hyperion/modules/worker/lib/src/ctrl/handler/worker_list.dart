part of person.ctrl;

class CWorker extends base.Collection<App, Worker, int> {
  final String group = Group.Worker;

  final String scope = Scope.Worker;

  CWorker(req) : super(req, new App());

  Future<CollectionBuilder> doGet(Map filter, Map order, Map paginator) async {
    final cb = manager.app.worker.findAllByBuilder()
      ..filterRule = (new FilterRule()..eq = ['object_id'])
      ..filter = filter
      ..order(order['field'], order['way'])
      ..page = paginator['page']
      ..limit = paginator['limit'];

    return cb.process(true);
  }

  Future<Map> lister(Worker o) async {
    final data = o.toJson();

    data['name'] = o.name;
    data['work_days'] = 0;
    return data;
  }

  Future<bool> doDelete(List ids) =>
      Future.wait(ids.map(manager.app.worker.deleteById)).then((_) => true);

  Future<void> suggest() => run(group, scope, 'read', () async {
        manager = await new Database().init(new App());
        final params = await getData();
        if (params['suggestion'] != null) {
          final name = params['suggestion'];
          final col = await manager.app.worker.findAllByName(name);
          return response(col.pair());
        } else {
          final ent = await manager.app.worker.find(params['id']);
          return response([ent.pair()]);
        }
      });
}
