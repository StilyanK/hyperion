part of worker.entity;

@MSerializable()
class Worker {
  int worker_id;
  String name;
  int salary_type;
  double salary_coefficient;
  double salary_per_day;

  Worker();

  void init(Map data) => _$WorkerFromMap(this, data);

  Map<String, dynamic> pair() => {'k': worker_id, 'v': name};

  Map<String, dynamic> toJson() => _$WorkerToMap(this, true);

  Map<String, dynamic> toMap() => _$WorkerToMap(this);
}

class WorkerCollection<E extends Worker> extends Collection<E> {
  List<Map<String, dynamic>> pair() =>
      map((worker) => {'k': worker.worker_id, 'v': worker.name}).toList();
}
