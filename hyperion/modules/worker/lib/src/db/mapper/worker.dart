part of person.mapper;

class WorkerMapper extends Mapper<Worker, WorkerCollection, App> {
  String table = 'workers';
  dynamic pkey = 'worker_id';

  WorkerMapper(m) : super(m);

  CollectionBuilder<Worker, WorkerCollection, App> findAllByBuilder() =>
      collectionBuilder()
        ..filterRule = (new FilterRule()
          ..eq = [entity.$Worker.worker_id]
          ..llike = [
            entity.$Worker.name,
          ]);

  Future<WorkerCollection> findAllByName(String name) => loadC(selectBuilder()
    ..where('name ILIKE @p1')
    ..setParameter('p1', '%$name%'));

  Future<WorkerCollection> findAllByExactName(String name) =>
      loadC(selectBuilder()
        ..where('name = @p1')
        ..setParameter('p1', name));

  Future<WorkerCollection> findByWorkerIdAndSalaryType(
          int worker_id, int salary_type) =>
      loadC(selectBuilder()
        ..where('worker_id = @p1')
        ..andWhere('salary_type = @p2')
        ..setParameter('p1', worker_id)
        ..setParameter('p2', salary_type));
}

class Worker extends entity.Worker with Entity<App> {}

class WorkerCollection extends entity.WorkerCollection<Worker> {
  List<Map<String, dynamic>> pair() =>
      map((type) => {'k': type.worker_id, 'v': '${type.name}'}).toList();
}
