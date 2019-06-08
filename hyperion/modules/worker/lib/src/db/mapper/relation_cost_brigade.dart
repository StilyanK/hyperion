part of person.mapper;

class RelationCostBrigadeMapper
    extends Mapper<RelationCostBrigade, RelationCostBrigadeCollection, App> {
  String table = 'relation_cost_brigade';
  dynamic pkey = 'relation_cost_brigade_id';

  RelationCostBrigadeMapper(m) : super(m);

  CollectionBuilder<RelationCostBrigade, RelationCostBrigadeCollection, App>
      findAllByBuilder() => collectionBuilder()
        ..filterRule = (new FilterRule()
          ..eq = [entity.$RelationCostBrigade.relation_cost_brigade_id]
          ..llike = [
            entity.$RelationCostBrigade.relation_cost_brigade_id,
          ]);

//  Future<RelationBrigadeCollection> findAllByBrigadeId(int id) =>
//      loadC(selectBuilder()
//        ..where('brigade_id =  @p1')
//        ..setParameter('p1', id));
//
//  Future<RelationBrigadeCollection> findAllBySalaryType(
//      int salaryType, int brigadeId, int workerId) =>
//      loadC(selectBuilder()
//        ..leftJoin(
//            'workers', 'workers.worker_id = relation_salary_worker.worker_id')
//        ..where('workers.salary_type = @p1')
//        ..andWhere('relation_salary_worker.brigade_id = @p2')
//        ..andWhere('workers.worker_id != @p3')
//        ..setParameter('p1', salaryType)
//        ..setParameter('p2', brigadeId)
//        ..setParameter('p3', workerId));
}

class RelationCostBrigade extends entity.RelationCostBrigade with Entity<App> {}

class RelationCostBrigadeCollection
    extends entity.RelationCostBrigadeCollection<RelationCostBrigade> {}
