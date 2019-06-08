part of person.gui;

class SelectPaymentType extends cl_form.Select {
  static final List<Map> salaryOptions = [
    {'v': '', 'k': null},
    {'v': 'На надник', 'k': 1},
    {'v': 'На квадрат', 'k': 2}
  ];

  SelectPaymentType() : super() {
    salaryOptions.forEach((option) => addOption(option['k'], option['v']));
  }
}
