part of worker.entity;

@MSerializable()
class RelationCostBrigade {
  int relation_cost_brigade_id;
  int brigade_id;
  int cost_id;
  String note;
  double price;

  RelationCostBrigade();

  void init(Map data) => _$RelationCostBrigadeFromMap(this, data);

  Map<String, dynamic> toJson() => _$RelationCostBrigadeToMap(this, true);

  Map<String, dynamic> toMap() => _$RelationCostBrigadeToMap(this);
}

class RelationCostBrigadeCollection<E extends RelationCostBrigade>
    extends Collection<E> {}
