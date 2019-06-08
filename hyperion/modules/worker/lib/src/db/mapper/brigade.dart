part of person.mapper;

class BrigadeMapper extends Mapper<Brigade, BrigadeCollection, App> {
  String table = 'brigade';
  dynamic pkey = 'brigade_id';

  BrigadeMapper(m) : super(m);

  //eq, llike, like, rlike, date, ts
  CollectionBuilder<Brigade, BrigadeCollection, App> findAllByBuilder() =>
      collectionBuilder()
        ..filterRule = (new FilterRule()
          ..eq = [entity.$Brigade.brigade_id]
          ..llike = [
            entity.$Brigade.address,
          ]);

  Future<BrigadeCollection> findAllByName(String name) => loadC(selectBuilder()
    ..where('address ILIKE @p1')
    ..setParameter('p1', '%$name%'));

  Future<BrigadeCollection> findAllByBrigadeName(String brigadeName) =>
      loadC(selectBuilder()
        ..where('address = @p1')
        ..setParameter('p1', brigadeName));
}

class Brigade extends entity.Brigade with Entity<App> {}

class BrigadeCollection extends entity.BrigadeCollection<Brigade> {
  List<Map<String, dynamic>> pair() =>
      map((type) => {'k': type.brigade_id, 'v': '${type.address}'}).toList();
}
