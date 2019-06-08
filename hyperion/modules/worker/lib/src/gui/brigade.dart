part of person.gui;

class Brigade extends ItemBuilder {
  UrlPattern contr_get = RoutesBrigade.itemGet;
  UrlPattern contr_save = RoutesBrigade.itemSave;
  UrlPattern contr_del = RoutesBrigade.itemDelete;

  cl_form.GridData workerGrid;
  cl_gui.LabelField addRow;
  cl_form.Text totalMoney;
  InputWorker inputWorker;
  cl_form.Input sum, days, quadrature, lvPerQuadrature, advancee;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = 'Create new Brigade'
    ..width = 800
    ..height = 1000
    ..icon = Icon.Worker;

  Brigade(ap, [id]) : super(ap, id);

  Future<void> setDefaults() async {
    workerGrid.hide();
    addRow.hide();
    form.getElement('address').focus();

    quadrature.onValueChanged.listen((e) {
      if (e.getValue() != null && lvPerQuadrature.getValue() != null) {
        totalMoney.setValue(e.getValue() * lvPerQuadrature.getValue());
      }
    });

    lvPerQuadrature.onValueChanged.listen((e) {
      if (e.getValue() != null && quadrature.getValue() != null) {
        totalMoney.setValue(e.getValue() * quadrature.getValue());
      }
    });
  }

  Future<void> setData() async {
    workerGrid.show();
    addRow.show();
    await super.setData();
  }

  void setUI() {
    final t1 = new cl_gui.FormElement(form);
    final t = createTab(null, t1);
    layout.contInner.activeTab(t);
    totalMoney = new cl_form.Text()..setName('total_money');
    final address = new cl_form.Input()
      ..setName($Brigade.address)
      ..setRequired(true);

    final selectMaterialType = new SelectMaterialType()
      ..setName($Brigade.material)
      ..setRequired(true);

    quadrature = new cl_form.Input(new cl_form.InputTypeDouble())
      ..setName($Brigade.quadrature)
      ..setSuffix('кв/м')
      ..setRequired(true);

    lvPerQuadrature = new cl_form.Input(new cl_form.InputTypeDouble())
      ..setName($Brigade.lv_per_quadrature)
      ..setSuffix('лв/кв')
      ..setRequired(true);

    workerGrid = new cl_form.GridData();
    form.add(workerGrid);

    final name = new cl_form.GridColumn('worker_id')
      ..title = 'Worker'
      ..width = '10%';

    final relId = new cl_form.GridColumn('relation_salary_worker_id')
      ..visible = false;

    final workDays = new cl_form.GridColumn('work_days')
      ..title = 'Work days'
      ..width = '10%'
      ..type = (grid, row, cell, object) {
        days = new cl_form.Input(new cl_form.InputTypeInt())
          ..setName('work_days')
          ..setValue(object)
          ..onValueChanged.listen((e) => calculateSalary());
        return new cl_form.RowEditCell(grid, row, cell, days);
      };

    final advance = new cl_form.GridColumn('advance')
      ..title = 'Advance'
      ..width = '10%'
      ..type = (grid, row, cell, object) {
        advancee = new cl_form.Input(new cl_form.InputTypeDouble())
          ..setName('advance')
          ..setValue(object)
          ..onValueChanged.listen((e) => calculateSalary());
        return new cl_form.RowEditCell(grid, row, cell, advancee);
      };

    final salary = new cl_form.GridColumn('salary')
      ..title = 'Salary'
      ..width = '10%'
      ..type = (grid, row, cell, object) {
        sum = new cl_form.Input(new cl_form.InputTypeDouble())
          ..setName('salary')
          ..setValue(object);
        return new cl_form.RowEditCell(grid, row, cell, sum);
      };

    final delBtn = new cl_form.GridColumn('btn')
      ..width = '1%'
      ..send = false;

    final addBtn = new cl_action.Button()
      ..setIcon(Icon.Add)
      ..addClass('important')
      ..addAction((_) => workerGrid.rowAdd({
            'worker_id': null,
            'work_days': null,
            'relation_salary_worker_id': null,
            'advance': null,
            'salary': null
          }));

    workerGrid
      ..setName('workers_data')
      ..initGridHeader([name, workDays, advance, salary, delBtn, relId])
      ..addHookRow((row, obj) {
        obj['btn'] = new cl_action.Button()
          ..addAction((e) => workerGrid.rowRemove(row))
          ..addAction((e) => calculateSalary())
          ..setIcon(cl.Icon.delete);
        inputWorker = new InputWorker(ap)..setValue(obj['worker_id']);
        obj['worker_id'] = inputWorker;
      });
    t1
      ..addRow('Address/Object', [address]).addClass('col6')
      ..addRow('Material', [selectMaterialType]).addClass('col2')
      ..addRow('Аrea quadrature', [quadrature]).addClass('col2')
      ..addRow('Lv per square', [lvPerQuadrature]).addClass('col2')
      ..addRow('Еarnings', [totalMoney]).addClass('col2')
      ..addRow(null, [workerGrid]);
    addRow = t1.addRow(null, [addBtn]);
  }

  Future calculateSalary() async {
    final gridValueAll = workerGrid.getValueAll();
    int allWorkDaysForWorkersPerSquare = 0;
    double allWorkersPerDaySalarys = 0.0;

    for (var el in gridValueAll) {
      final salaryTypeAndSalaryPerDay =
          await GetDataFromWorkers(el['worker_id']);

      final salaryType = salaryTypeAndSalaryPerDay['salary_type'];
      if (salaryType == 2) {
        allWorkDaysForWorkersPerSquare += el['work_days'];
      } else if (salaryType == 1) {
        final salary =
            el['work_days'] * salaryTypeAndSalaryPerDay['salary_per_day'];
        allWorkersPerDaySalarys += salary;
      }
    }

    for (final r in workerGrid.tbody.dom.childNodes) {
      final i = workerGrid.getRowMap(r);
      final brigadeTotalMoney = totalMoney.getValue();

      final dataFromWorkers =
          await GetDataFromWorkers(i['worker_id'].getValue());
      final salaryType = dataFromWorkers['salary_type'];
      final salaryPerDay = dataFromWorkers['salary_per_day'];
      final workDays = i['work_days'].getValue();
      final salaryCoefficient = dataFromWorkers['salary_coefficient'];
      final advance = i['advance'].getValue();

      if (salaryType == 1) {
        if (salaryPerDay != null && workDays != null) {
          final salary = salaryPerDay * workDays;
          if (advance != null) {
            final salaryMinusAdvance = salary - advance;
            workerGrid.getCell(r, 'salary').setValue(salaryMinusAdvance);
          } else {
            workerGrid.getCell(r, 'salary').setValue(salary);
          }
        }
      } else if (salaryType == 2) {
        final moneyForWorkers = brigadeTotalMoney - allWorkersPerDaySalarys;
        final moneyPerDay = moneyForWorkers / allWorkDaysForWorkersPerSquare;
        final salary = moneyPerDay * workDays;

        final salaryWithCoeff = salary * salaryCoefficient;
        workerGrid.getCell(r, 'salary').setValue(salaryWithCoeff);

        if (advance != null) {
          final salaryCoeffMinusAdvance = salaryWithCoeff - advance;
          workerGrid.getCell(r, 'salary').setValue(salaryCoeffMinusAdvance);
        }
      }
    }
  }

  Future<Map> GetDataFromWorkers(int worker_id) async {
    final data = await ap.serverCall(
        RoutesBrigade.getSalaryType.reverse([]), {'worker_id': worker_id});
    return data;
  }
}
