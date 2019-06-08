part of person.gui;

class CarList extends Listing {


  UrlPattern contr_get = RoutesCar.collectionGet;
  UrlPattern contr_del = RoutesCar.collectionDelete;

  String mode = Listing.MODE_LIST;
  String key = $Car.car_id;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = 'Vehicle list'
    ..width = 1200
    ..height = 1000
    ..icon = Icon.Car;

  CarList(ap, {autoload = true}) : super(ap, autoload: autoload) {
    menu.add(new cl_action.Button()
      ..setStyle({'margin-left': 'auto'})
      ..setTitle('Add vehicle')
      ..setIcon(cl.Icon.add)
      ..addClass('important')
      ..addAction((e) => onEdit(0)));
  }

  List<String> initOrder() => [$Car.car_name, 'ASC'];

  List<cl_form.GridColumn> initHeader() => [
        new cl_form.GridColumn($Car.car_name)
          ..title = 'Name'
          ..sortable = true,
        new cl_form.GridColumn($Car.insurance_expires)
          ..title = 'Validity of insurance to'
          ..sortable = true
          ..type = (grid, row, cell, object) =>
              new DateTimeCell(grid, row, cell, object),
        new cl_form.GridColumn($Car.vignette_expires)
          ..title = 'Validity of vignette to'
          ..sortable = true
          ..type = (grid, row, cell, object) =>
              new DateTimeCell(grid, row, cell, object),
        new cl_form.GridColumn($Car.year_check_expires)
          ..title = 'Validity of annual review to'
          ..sortable = true
          ..type = (grid, row, cell, object) =>
              new DateTimeCell(grid, row, cell, object),
      ];

  void onEdit(dynamic id) {
    ap.run<Car>('car/$id').addHook(ItemBase.change_after, (_) {
      getData();
      return true;
    });
  }

//  void customRow(TableRowElement row, Map obj)  {
//    final salaryType = obj['salary_type'];
//    if (salaryType == shared.SalaryConstants.perSquare) {
//      obj['salary'] = 'На квадрат';
//    } else {
//      obj['salary'] = 'На надник';
//    }
//  }
}
