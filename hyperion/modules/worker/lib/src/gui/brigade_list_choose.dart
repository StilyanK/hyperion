part of person.gui;

class BrigadeListChoose extends BrigadeList {
  String mode = Listing.MODE_CHOOSE;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = 'Choose an object'
    ..width = 1100
    ..height = 850
    ..icon = Icon.WorkerList;

  void Function(Map) call;

  BrigadeListChoose(this.call, ap, {bool autoload = true})
      : super(ap, autoload: autoload);

  void onClick(TableRowElement row) {
    call(grid.rowToMap(row));
    wapi.close();
  }
}
