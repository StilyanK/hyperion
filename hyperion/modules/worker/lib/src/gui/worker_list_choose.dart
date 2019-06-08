part of person.gui;

class PersonListChoose extends WorkerList {
  String mode = Listing.MODE_CHOOSE;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = 'Choose Brigade'
    ..width = 1100
    ..height = 850
    ..icon = Icon.WorkerList;

  void Function(Map) call;

  PersonListChoose(this.call, ap, {bool autoload = true})
      : super(ap, autoload: autoload);

  void onClick(TableRowElement row) {
    call(grid.rowToMap(row));
    wapi.close();
  }
}
