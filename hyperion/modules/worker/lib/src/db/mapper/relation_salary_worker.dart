part of person.mapper;

class RelationBrigadeMapper
    extends Mapper<RelationBrigade, RelationBrigadeCollection, App> {
  String table = 'relation_salary_worker';

  RelationBrigadeMapper(m) : super(m);

  CollectionBuilder<RelationBrigade, RelationBrigadeCollection, App>
      findAllByBuilder() => collectionBuilder()
        ..filterRule = (new FilterRule()
          ..eq = [entity.$RelationBrigade.relation_salary_worker_id]
          ..llike = [
            entity.$RelationBrigade.relation_salary_worker_id,
          ]);

  Future<RelationBrigadeCollection> findAllByBrigadeId(int id) =>
      loadC(selectBuilder()
        ..where('brigade_id =  @p1')
        ..setParameter('p1', id));

  Future<RelationBrigadeCollection> findAllBySalaryType(
          int salaryType, int brigadeId, int workerId) =>
      loadC(selectBuilder()
        ..leftJoin(
            'workers', 'workers.worker_id = relation_salary_worker.worker_id')
        ..where('workers.salary_type = @p1')
        ..andWhere('relation_salary_worker.brigade_id = @p2')
        ..andWhere('workers.worker_id != @p3')
        ..setParameter('p1', salaryType)
        ..setParameter('p2', brigadeId)
        ..setParameter('p3', workerId));
}

class RelationBrigade extends entity.RelationBrigade with Entity<App> {}

class RelationBrigadeCollection
    extends entity.RelationBrigadeCollection<RelationBrigade> {}
