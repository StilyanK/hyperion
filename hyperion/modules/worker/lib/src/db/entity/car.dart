part of worker.entity;

@MSerializable()
class Car {
  int car_id;
  String car_name;
  DateTime insurance_expires;
  DateTime vignette_expires;
  DateTime year_check_expires;

  Car();

  void init(Map data) => _$CarFromMap(this, data);

  Map<String, dynamic> pair() => {'k': car_id, 'v': car_name};

  Map<String, dynamic> toJson() => _$CarToMap(this, true);

  Map<String, dynamic> toMap() => _$CarToMap(this);
}

class CarCollection<E extends Car> extends Collection<E> {
  List<Map<String, dynamic>> pair() =>
      map((car) => {'k': car.car_id, 'v': car.car_name}).toList();
}
