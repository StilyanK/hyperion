library person.gui;

import 'dart:async';
import 'dart:html';

import 'package:cl/action.dart' as cl_action;
import 'package:cl/app.dart' as cl_app;
import 'package:cl/base.dart' as cl;
import 'package:cl/forms.dart' as cl_form;
import 'package:cl/gui.dart' as cl_gui;
import 'package:cl_base/client.dart';
import 'package:communicator/client.dart';
import 'package:intl/intl.dart';

import 'entity.dart';
import 'path.dart';
import 'shared.dart' as shared;

part 'gui/brigade.dart';

part 'gui/brigade_list.dart';

part 'gui/brigade_list_choose.dart';

part 'gui/car.dart';

part 'gui/car_list.dart';

part 'gui/element/date_time_cell.dart';

part 'gui/element/form_date.dart';

part 'gui/element/input_brigade.dart';

part 'gui/element/input_worker.dart';

part 'gui/element/select_brigade.dart';

part 'gui/element/select_material_type.dart';

part 'gui/element/select_salary_type.dart';

part 'gui/worker.dart';
part 'gui/dictionary.dart';

part 'gui/worker_list.dart';

part 'gui/worker_list_choose.dart';

abstract class Icon {
  static const String Worker = cl.Icon.person;
  static const String WorkerList = cl.Icon.assignment;
  static const String Brigade = cl.Icon.group;
  static const String WorkerBrigade = cl.Icon.send;
  static const String Salary = cl.Icon.mail;
  static const String Add = cl.Icon.add;
  static const String Car = cl.Icon.device_hub;
  static const String Dictionary = cl.Icon.file_download;
}
