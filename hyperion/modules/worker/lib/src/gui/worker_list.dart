part of person.gui;

class WorkerList extends Listing {
  UrlPattern contr_get = RoutesWorker.collectionGet;
  UrlPattern contr_del = RoutesWorker.collectionDelete;

  String mode = Listing.MODE_LIST;
  String key = $Worker.worker_id;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = 'Workers'
    ..width = 1000
    ..height = 800
    ..icon = Icon.WorkerList;

  WorkerList(ap, {autoload = true}) : super(ap, autoload: autoload) {
    menu.add(new cl_action.Button()
      ..setStyle({'margin-left': 'auto'})
      ..setTitle('Add worker')
      ..setIcon(cl.Icon.add)
      ..addClass('important')
      ..addAction((e) => onEdit(0)));
  }

  List<String> initOrder() => [$Worker.name, 'ASC'];

//  customRow(row, obj) {
//    obj['birth'] = obj['birth'].toString()+"dasdsaa";
//  }

  List<cl_form.GridColumn> initHeader() => [
        new cl_form.GridColumn($Worker.name)
          ..title = 'Name'
          ..filter = (new cl_form.Input()..setName($Worker.name))
          ..sortable = true,
        new cl_form.GridColumn('salary')..title = 'Type of payment',
        new cl_form.GridColumn('address')
          ..title = 'Brigade'
          ..filter = (new cl_form.Input()..setName('address'))
          ..sortable = true,
        new cl_form.GridColumn($Worker.salary_per_day)
          ..title = 'Salary per day'
          ..filter = (new cl_form.Input()..setName($Worker.salary_per_day))
          ..sortable = true,
        new cl_form.GridColumn($Worker.salary_coefficient)
          ..title = 'Coefficient for salary'
          ..filter = (new cl_form.Input()..setName($Worker.salary_coefficient))
          ..sortable = true
      ];

  void onEdit(dynamic id) {
    ap.run<Worker>('worker/$id').addHook(ItemBase.change_after, (_) {
      getData();
      return true;
    });
  }

  void customRow(TableRowElement row, Map obj) {
    final salaryType = obj['salary_type'];
    if (salaryType == shared.SalaryConstants.perSquare) {
      obj['salary'] = 'Per square';
    } else {
      obj['salary'] = 'Per day';
    }
  }
}
