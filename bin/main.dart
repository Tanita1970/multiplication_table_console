// import 'dart:io';
// import 'dart:math';
import 'dart:io';
// import 'dart:js_interop';

import 'package:multiplication_table_console/data/registered_users.dart';
import 'package:multiplication_table_console/models/setting.dart';
// import 'package:multiplication_table_console/models/task.dart';
import 'package:multiplication_table_console/models/user.dart';
import 'package:multiplication_table_console/services/file_operations.dart';
// import 'package:multiplication_table_console/models/user_task.dart';
import 'package:multiplication_table_console/services/tasks_generator.dart';

void main() async {
  print('\n Добро пожаловать в Таблицу умножения!\n');
  String? number = menu() ?? '3';
  switch (number) {
    case '1':
      print('\n ВВЕДИТЕ email: ');
      var email = stdin.readLineSync()!;

      print('\n ВВЕДИТЕ ПАРОЛЬ: ');
      var password = stdin.readLineSync()!;
      User newUser = User(name: 'Новый пользователь', setting: Setting());
      newUser.setEmail(email);
      newUser.setPassword(password);
      Future<User> futureUser = newUser.authorization('registered_users.json');

      User user = await futureUser;

      if (user.name == '') {
        menu();
      } else {
        TasksGenerator(user).startTask();
      }

    case '2':
      User newUser2 = User(name: 'Новый пользователь', setting: Setting());
      newUser2.register();
      print('\n Создан пользователь ${newUser2.toString()}\n');

    case '3':
      exit(0);
    // default:
  }
  // User newUser1 = User(name: 'Новый пользователь', setting: Setting());
  // newUser1.register();

  // Очищаем текущий список для теста загрузки
  // registeredUsers.clear();
  // print(registeredUsers);

  // Загружаем пользователей из файла
  registeredUsers = await loadUsersFromFile('registered_users.json');

  // Печатаем загруженные данные
  for (var user in registeredUsers) {
    print('kllkjlkjlkjl');
    print(user);
  }
  // print('\nСоздан пользователь ${newUser1.toString()}\n');

  // User newUser2 = User(name: 'Новый пользователь');
  // newUser2.register();
  // // print('\nСоздан пользователь ${newUser2.toString()}\n');

  // print('\n СПИСОК ВСЕХ ЗАРЕГИСТРИРОВАННЫХ ПОЛЬЗОВАТЕЛЕЙ: \n');
  // // print(registeredUsers[0].email);
  // print(registeredUsers.toString());

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

String? menu() {
  print('\n Меню:');
  print('1. Авторизация');
  print('2. Регистрация');
  print('3. Выход');
  print('\n Введите номер меню:');
  var number = stdin.readLineSync();
  return number;
}
