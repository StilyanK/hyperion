part of person.ctrl;

class IWorker extends base.Item<App, Worker, int> {
  final String group = Group.Worker;

  final String scope = Scope.Worker;

  IWorker(req) : super(req, new App());

  Future<Map> doGet(int id) async {
    final worker = await manager.app.worker.find(id);
    if (worker == null) throw new base.ResourceNotFoundException();
    return worker.toJson();
  }

  Future<int> doSave(int id, Map data) async {
    final worker = await manager.app.worker.prepare(id, data);

    await manager.commit();
    return worker.worker_id;
  }

  Future<bool> doDelete(int id) => manager.app.worker.deleteById(id);
}
