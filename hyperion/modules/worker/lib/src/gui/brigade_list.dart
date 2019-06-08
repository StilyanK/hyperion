part of person.gui;

class BrigadeList extends Listing {

  UrlPattern contr_get = RoutesBrigade.collectionGet;
  UrlPattern contr_del = RoutesBrigade.collectionDelete;
  String mode = Listing.MODE_LIST;
  String key = $Brigade.brigade_id;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = 'List objects'
    ..width = 1000
    ..height = 800
    ..icon = Icon.WorkerList;

  BrigadeList(ap, {autoload = true}) : super(ap, autoload: autoload) {
    menu.add(new cl_action.Button()
      ..setStyle({'margin-left': 'auto'})
      ..setTitle('Добави Обект')
      ..setIcon(cl.Icon.add)
      ..addClass('important')
      ..addAction((e) => onEdit(0)));
  }

  List<String> initOrder() => [$Brigade.address, 'ASC'];

  List<cl_form.GridColumn> initHeader() => [
        new cl_form.GridColumn($Brigade.address)
          ..title = 'Name of the object'
          ..filter = (new cl_form.Input()..setName($Brigade.address))
          ..sortable = true,
        new cl_form.GridColumn($Brigade.material)
          ..title = 'Material'
          ..filter = (new cl_form.Input()..setName($Brigade.material))
          ..sortable = true,
        new cl_form.GridColumn($Brigade.quadrature)
          ..title = 'Аrea quadrature'
          ..filter = (new cl_form.Input()..setName($Brigade.quadrature))
          ..sortable = true,
        new cl_form.GridColumn($Brigade.lv_per_quadrature)
          ..title = 'Lv per square'
          ..filter = (new cl_form.Input()..setName($Brigade.lv_per_quadrature))
          ..sortable = true
      ];

  void onEdit(dynamic id) {
    ap.run<Brigade>('brigade/$id').addHook(ItemBase.change_after, (_) {
      getData();
      return true;
    });
  }

  void customRow(TableRowElement row, Map obj) {
    final salaryType = obj['material'];
    if (salaryType == 1) {
      obj['material'] = 'Аluminum window frames';
    } else if (obj['material'] == 2) {
      obj['material'] = 'Facade';
    } else if (obj['material'] == 3) {
      obj['material'] = 'Bond';
    } else if (obj['material'] == 4) {
      obj['material'] = 'HPL';
    }
  }
}
