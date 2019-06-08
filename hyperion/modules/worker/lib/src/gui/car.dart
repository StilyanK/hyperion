part of person.gui;

class Car extends ItemBuilder {
  UrlPattern contr_get = RoutesCar.itemGet;
  UrlPattern contr_save = RoutesCar.itemSave;
  UrlPattern contr_del = RoutesCar.itemDelete;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = 'Create Vehicle'
    ..width = 1000
    ..height = 800
    ..icon = Icon.Car;

  Car(ap, [id]) : super(ap, id);

  Future<void> setDefaults() async {
    form.getElement($Car.car_name).focus();
  }

  void setUI() {
    final t1 = new cl_gui.FormElement(form);
    final t = createTab(null, t1);
    layout.contInner.activeTab(t);

    final name = new cl_form.Input()
      ..setName('car_name')
      ..setRequired(true);

    final insuranceExpires = new cl_form.InputDate()
      ..setName('insurance_expires');

    final vignetteExpires = new cl_form.InputDate()
      ..setName('vignette_expires');

    final yearCheckExpires = new cl_form.InputDate()
      ..setName('year_check_expires');

    t1
      ..addRow('Name', [name]).addClass('col6')
      ..addRow('Validity of insurance to', [insuranceExpires])
          .addClass('col2')
      ..addRow('Validity of vignette to', [vignetteExpires]).addClass('col2')
      ..addRow('Validity of annual review to', [yearCheckExpires])
          .addClass('col2');
  }
}
