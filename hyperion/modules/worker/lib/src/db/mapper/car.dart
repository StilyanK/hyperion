part of person.mapper;

class CarMapper extends Mapper<Car, CarCollection, App> {
  String table = 'cars';
  dynamic pkey = 'car_id';

  CarMapper(m) : super(m);

  CollectionBuilder<Car, CarCollection, App> findAllByBuilder() =>
      collectionBuilder()
        ..filterRule = (new FilterRule()
          ..eq = [entity.$Car.car_id]
          ..llike = [
            entity.$Car.car_name,
          ]);

  Future<CarCollection> findAllByName(String name) => loadC(selectBuilder()
    ..where('name ILIKE @p1')
    ..setParameter('p1', '%$name%'));
}

class Car extends entity.Car with Entity<App> {}

class CarCollection extends entity.CarCollection<Car> {
  List<Map<String, dynamic>> pair() =>
      map((type) => {'k': type.car_id, 'v': '${type.car_name}'}).toList();
}
