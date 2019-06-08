part of person.ctrl;

class CBrigade extends base.Collection<App, Brigade, int> {
  final String group = Group.Worker;

  final String scope = Scope.Worker;

  CBrigade(req) : super(req, new App());

  Future<CollectionBuilder> doGet(Map filter, Map order, Map paginator) async {
    final cb = manager.app.brigade.findAllByBuilder()
      ..filter = filter
      ..order(order['field'], order['way'])
      ..page = paginator['page']
      ..limit = paginator['limit'];
    return cb.process(true);
  }

  Future<bool> doDelete(List ids) =>
      Future.wait(ids.map(manager.app.brigade.deleteById)).then((_) => true);

  Future<void> suggest() => run(group, scope, 'read', () async {
        manager = await new Database().init(new App());
        final params = await getData();
        if (params['suggestion'] != null) {
          final name = params['suggestion'];
          final col = await manager.app.brigade.findAllByName(name);
          return response(col.pair());
        } else {
          final ent = await manager.app.brigade.find(params['id']);
          return response([ent.pair()]);
        }
      });
}
