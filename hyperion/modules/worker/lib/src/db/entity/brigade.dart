part of worker.entity;

@MSerializable()
class Brigade {
  int brigade_id;
  String address;
  int material;
  double quadrature;
  double lv_per_quadrature;
  double total_money;

  Brigade();

  void init(Map data) => _$BrigadeFromMap(this, data);

  Map<String, dynamic> pair() => {'k': brigade_id, 'v': address};

  Map<String, dynamic> toJson() => _$BrigadeToMap(this, true);

  Map<String, dynamic> toMap() => _$BrigadeToMap(this);
}

class BrigadeCollection<E extends Brigade> extends Collection<E> {
  List<Map<String, dynamic>> pair() =>
      map((object) => {'k': object.brigade_id, 'v': object.address}).toList();
}
