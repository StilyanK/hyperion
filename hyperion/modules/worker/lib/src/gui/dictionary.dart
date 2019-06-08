part of person.gui;

class Dictionary extends ItemBuilder {
  UrlPattern contr_get = RoutesDictionary.itemGet;
  UrlPattern contr_save = RoutesDictionary.itemSave;
  UrlPattern contr_del = RoutesDictionary.itemDelete;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = 'Dictionary'
    ..width = 1000
    ..height = 800
    ..icon = Icon.Dictionary;

  Dictionary(ap, [id]) : super(ap, id);

  Future<void> setDefaults() async {
//    form.getElement($Car.car_name).focus();
  }

  void setUI() {
    final t1 = new cl_gui.FormElement(form);
    final t = createTab(null, t1);
    layout.contInner.activeTab(t);

    final content = new cl_form.TextArea()
    ..setName('content')
      ..setStyle({'height':'500px'});


    t1.addRow(null, [content]);

  }
}
