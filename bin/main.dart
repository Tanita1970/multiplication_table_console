// import 'dart:io';
// import 'dart:math';
import 'package:multiplication_table_console/models/setting.dart';
// import 'package:multiplication_table_console/models/task.dart';
import 'package:multiplication_table_console/models/user.dart';
// import 'package:multiplication_table_console/models/user_task.dart';
import 'package:multiplication_table_console/services/tasks_generator.dart';

void main() {
  print('Добро пожаловать в Таблицу умножения!');
  var userTanya = User(name: 'Таня');
  userTanya.setting.setNumOneFromTo(valueFrom: 2, valueTo: 5);
  userTanya.setting.setNumTwoFromTo(valueFrom: 4, valueTo: 6);
  userTanya.setting.setMode(value: Mode.timed);
  // userTanya.setting.setMode(value: Mode.taskCount);
  print('Создан пользователь ${userTanya.toString()}');
  TasksGenerator(userTanya).startTask();
}
