part of person.ctrl;

class IDictionary extends base.Item<App, Dictionary, int> {
  final String group = Group.Worker;

  final String scope = Scope.Worker;

  IDictionary(req) : super(req, new App());

  Future<Map> doGet(int id) async {
    final dictionary = await manager.app.dictionary.find(id);
    if (dictionary == null) throw new base.ResourceNotFoundException();
    return dictionary.toJson();
  }

  Future<int> doSave(int id, Map data) async {
    final dictionary = await manager.app.dictionary.prepare(id, data);
    await manager.commit();
    return dictionary.dictionary_id;
  }

  Future<bool> doDelete(int id) => manager.app.dictionary.deleteById(id);
}
