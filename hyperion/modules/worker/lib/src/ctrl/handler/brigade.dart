part of person.ctrl;

class IBrigade extends base.Item<App, Brigade, int> {
  final String group = Group.Worker;

  final String scope = Scope.Worker;

  IBrigade(req) : super(req, new App());

  Future<Map> doGet(int id) async {
    final brigade = await manager.app.brigade.find(id);
    if (brigade == null) throw new base.ResourceNotFoundException();
    final ent = brigade.toJson();
    final List<Map> result = [];
    final salRel =
        await manager.app.relationSalaryWorker.findAllByBrigadeId(id);

    if (salRel.isNotEmpty) {
      for (final c in salRel) {
        result.add({
          'worker_id': c.worker_id,
          'work_days': c.work_days,
          'relation_salary_worker_id': c.relation_salary_worker_id,
          'salary': c.salary,
          'advance': c.advance
        });
      }
      ent['workers_data'] = result;
      ent['total_money'] = brigade.quadrature * brigade.lv_per_quadrature;
    }

    return ent;
  }

  Future<int> doSave(int id, Map data) async {
    if (id == null) {
      final brigadeName =
          await manager.app.brigade.findAllByBrigadeName(data['address']);
      if (brigadeName.isNotEmpty)
        throw new base.WorkflowException(
            () => 'Съществува бригада с такова име!');
    }
    final brigade = await manager.app.brigade.prepare(id, data);

    await manager.persist();
    final workersData = data['workers_data'];
    if (workersData != null) {
      final insertList = workersData['insert'];
      final updateList = workersData['update'];
      final deleteList = workersData['delete'];
      print(data);
      if (insertList != null) {
        for (final i in insertList) {
          // ignore: avoid_single_cascade_in_expression_statements
          await manager.app.relationSalaryWorker.prepare(null, i)
            ..brigade_id = brigade.brigade_id;
        }
      }
      if (updateList != null) {
        for (final u in updateList) {
          await manager.app.relationSalaryWorker
              .prepare(u['relation_salary_worker_id'], u);
        }
      }
      if (deleteList != null) {
        for (final d in deleteList) {
          final ent = await manager.app.relationSalaryWorker
              .find(d['relation_salary_worker_id']);
          if (ent != null) manager.addDelete(ent);
        }
      }
    }

    await manager.commit();
    return brigade.brigade_id;
  }

  Future<dynamic> getSalaryType() => run(group, scope, 'read', () async {
        manager = await new Database().init(new App());
        final params = await getData();
        final salType = await manager.app.worker.find(params['worker_id']);
        return response({
          'salary_type': salType?.salary_type,
          'salary_per_day': salType?.salary_per_day,
          'salary_coefficient': salType?.salary_coefficient
        });
      });

  Future<bool> doDelete(int id) => manager.app.brigade.deleteById(id);
}
