part of worker.entity;

@MSerializable()
class RelationBrigade {
  int relation_salary_worker_id;
  int worker_id;
  int work_days;
  int brigade_id;
  double advance;
  double salary;

  RelationBrigade();

  void init(Map data) => _$RelationBrigadeFromMap(this, data);

  Map<String, dynamic> toJson() => _$RelationBrigadeToMap(this, true);

  Map<String, dynamic> toMap() => _$RelationBrigadeToMap(this);
}

class RelationBrigadeCollection<E extends RelationBrigade>
    extends Collection<E> {}
