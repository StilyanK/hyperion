part of person.gui;

class Date {
  DateTime date;

  Date(this.date);

  String get() => new DateFormat('dd/MM/yyyy').format(date.toLocal());

  String getWithTime() => new DateFormat('dd/MM/yyyy').format(date.toLocal());

  String toString() => get();
}

class DateTimeCell extends cl_form.RowDataCell<Date> {
  DateTimeCell(grid, row, cell, object)
      : super(
            grid,
            row,
            cell,
            object == null || object.isEmpty
                ? null
                : new Date(DateTime.parse(object)));

  void render() {
    cell.text = object == null ? '' : object.getWithTime();
  }
}
