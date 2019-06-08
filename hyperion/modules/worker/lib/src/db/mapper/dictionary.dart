part of person.mapper;

class DictionaryMapper extends Mapper<Dictionary, DictionaryCollection, App> {
  String table = 'dictionary';
  dynamic pkey = 'dictionary_id';

  DictionaryMapper(m) : super(m);

  //eq, llike, like, rlike, date, ts
  CollectionBuilder<Dictionary, DictionaryCollection, App> findAllByBuilder() =>
      collectionBuilder()
        ..filterRule = (new FilterRule()
          ..eq = [entity.$Dictionary.dictionary_id]
          ..llike = [
            entity.$Dictionary.content,
          ]);

//  Future<BrigadeCollection> findAllByName(String name) => loadC(selectBuilder()
//    ..where('address ILIKE @p1')
//    ..setParameter('p1', '%$name%'));
//
//  Future<BrigadeCollection> findAllByBrigadeName(String brigadeName) =>
//      loadC(selectBuilder()
//        ..where('address = @p1')
//        ..setParameter('p1', brigadeName));
}

class Dictionary extends entity.Dictionary with Entity<App> {}

class DictionaryCollection extends entity.DictionaryCollection<Dictionary> {
  List<Map<String, dynamic>> pair() =>
      map((type) => {'k': type.dictionary_id, 'v': '${type.content}'}).toList();
}
