part of person.gui;

class DateCell extends cl_form.RowDataCell<DateTime> {
  DateCell(grid, row, cell, object)
      : super(grid, row, cell,
            object == null || object.isEmpty ? null : DateTime.parse(object));

  void render() {
    if (object != null)
      cell.text = '${new DateFormat('dd.MM.yyyy').format(object)}г.';
    else
      cell.text = '';
    //cl_util.Calendar.string(object);
  }
}
