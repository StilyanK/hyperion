part of person.gui;

class Worker extends ItemBuilder {
  UrlPattern contr_get = RoutesWorker.itemGet;
  UrlPattern contr_save = RoutesWorker.itemSave;
  UrlPattern contr_del = RoutesWorker.itemDelete;
  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = 'New worker'
    ..width = 600
    ..height = 400
    ..icon = Icon.Worker;

  Worker(ap, [id]) : super(ap, id);

  cl_gui.LabelField salaryCoefficientRow;
  cl_gui.LabelField salaryPerDayRow;
  cl_gui.LabelField advanceRow;
  cl_form.Input salaryPerDayInput, salaryCoefficientInput;

  Future<void> setDefaults() async {
    form.getElement($Worker.name).focus();
    salaryCoefficientRow.hide();
    salaryPerDayRow.hide();
  }

  Future<void> setData() async {
    await super.setData();
  }

  void setUI() {
    final t1 = new cl_gui.FormElement(form);
    final t = createTab(null, t1);
    layout.contInner.activeTab(t);

    final newWorker = new cl_form.Input()
      ..setName($Worker.name)
      ..setRequired(true);

    final salaryType = new SelectPaymentType()
      ..onValueChanged.listen((e) {
        if (e.getValue() == 1) {
          salaryPerDayInput.setRequired(true);
          salaryCoefficientInput.setRequired(false);
          salaryCoefficientRow.hide();
          salaryPerDayRow.show();
        } else if (e.getValue() == 2) {
          salaryPerDayInput.setRequired(false);
          salaryCoefficientInput.setRequired(true);
          salaryCoefficientRow.show();
          salaryPerDayRow.hide();
        } else {
          salaryCoefficientRow.hide();
          salaryPerDayRow.hide();
        }
      })
      ..setName($Worker.salary_type)
      ..setRequired(true);

    salaryPerDayInput = new cl_form.Input(new cl_form.InputTypeDouble())
      ..setName($Worker.salary_per_day)
      ..setRequired(true);

    salaryCoefficientInput = new cl_form.Input(new cl_form.InputTypeDouble())
      ..setName($Worker.salary_coefficient)
      ..setRequired(true);

    t1
      ..addRow('New worker', [newWorker])
      ..addRow('Type of payment', [salaryType]);

    salaryCoefficientRow =
        t1.addRow('Coefficient of payment', [salaryCoefficientInput]);
    salaryPerDayRow = t1.addRow('Salary per day', [salaryPerDayInput]);
  }
}
