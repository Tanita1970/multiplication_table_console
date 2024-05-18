// import 'dart:io';
// import 'dart:math';
import 'package:multiplication_table_console/data/registered_users.dart';
import 'package:multiplication_table_console/models/setting.dart';
// import 'package:multiplication_table_console/models/task.dart';
import 'package:multiplication_table_console/models/user.dart';
// import 'package:multiplication_table_console/models/user_task.dart';
import 'package:multiplication_table_console/services/tasks_generator.dart';

void main() {
  // print('Добро пожаловать в Таблицу умножения!');
  // User newUser1 = User(name: 'Новый пользователь');
  // newUser1.register();
  // // print('\nСоздан пользователь ${newUser1.toString()}\n');

  // User newUser2 = User(name: 'Новый пользователь');
  // newUser2.register();
  // // print('\nСоздан пользователь ${newUser2.toString()}\n');

  print('\n СПИСОК ВСЕХ ЗАРЕГИСТРИРОВАННЫХ ПОЛЬЗОВАТЕЛЕЙ: \n');
  // print(registeredUsers[0].email);
  print(registeredUsers.toString());

  // var userTanya = User(name: 'Таня');
  // userTanya.setting.setNumOneFromTo(valueFrom: 2, valueTo: 5);
  // userTanya.setting.setNumTwoFromTo(valueFrom: 4, valueTo: 6);
  // userTanya.setting.setTimeMinute(minute: 0);
  // userTanya.setting.setTimeSecond(second: 30);
  // userTanya.setting.setTaskCount(count: 10);
  // // userTanya.setting.setMode(value: Mode.timed);
  // userTanya.setting.setMode(value: Mode.taskCount);
  // print('Создан пользователь ${userTanya.toString()}');
  // TasksGenerator(userTanya).startTask();
}
