part of person.gui;

class SelectMaterialType extends cl_form.Select {
  static final List<Map> materialOptions = [
    {'v': '', 'k': null},
    {'v': 'Дограма', 'k': 1},
    {'v': 'Фасада', 'k': 2},
    {'v': 'Бонд', 'k': 3},
    {'v': 'HPL', 'k': 4}
  ];

  SelectMaterialType() : super() {
    materialOptions.forEach((option) => addOption(option['k'], option['v']));
  }
}
