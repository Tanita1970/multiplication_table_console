import 'dart:io';

import 'package:multiplication_table_console/globals.dart';
import 'package:multiplication_table_console/models/setting.dart';
import 'package:multiplication_table_console/models/user.dart';
import 'package:multiplication_table_console/services/tasks_manager.dart';

// Добавить глбальные переменные, отвечающие за инициализацию UserManager, FileManager.
// Во всём коде использовать эти переменные вместо создания объекта на каждый вызов метода

void main() {
  print('\n Добро пожаловать в Таблицу умножения!\n');
  String number = menu() ?? '3';
  switch (number) {
    case '1':
      print('\n ВВЕДИТЕ name: ');
      var name = stdin.readLineSync()!;
      print('\n ВВЕДИТЕ email: ');
      var email = stdin.readLineSync()!;
      print('\n ВВЕДИТЕ ПАРОЛЬ: ');
      var password = stdin.readLineSync()!;

      try {
        User user = userManager.login(name, email, password);
        print('\n Пользователь ${user.name} авторизован\n');
        TasksManager(user).startTask();
      } catch (e) {
        print('\n Пользователь $name не авторизован\n');
      }

    case '2':
      // Поправить на record (метод inputUserData должен взвращать 3 строки, имя, мыло, пароль)
      print('Регистрация...');
      var userData = inputUserData();
      User newUser2 = User(
          name: userData.name,
          email: userData.email,
          password: userData.password,
          setting: Setting.defaultValue(),
          isPremium: false);
      userManager.register(newUser2);
      print('\n Создан пользователь ${newUser2.toString()}\n');

    case '3':
      exit(0);

    default:
      exit(0);
  }
}

({String name, String email, String password}) inputUserData() {
  String name = inputName();
  String email = inputEmail();
  String password = inputPassword();
  return (name: name, email: email, password: password);
}

/// Ввод имени пользователя
String inputName() {
  String name = '';
  int attemptForName = 1;
  print('\n ********** ВВЕДИТЕ ИМЯ **********');
  do {
    print('Попытка №$attemptForName');
    name = stdin.readLineSync()!;
    attemptForName++;
    if (attemptForName > 3 && userManager.isValidName(name) == false) {
      print('Вам отказано в регистрации!');
      return name;
    }
  } while (!userManager.isValidName(name) && attemptForName <= 3);
  return name;
}

/// Ввод почтового ящика
String inputEmail() {
  String email = '';
  int attemptForEmail = 1;
  print('\n ********** ВВЕДИТЕ email: **********');
  do {
    print(' Попытка №$attemptForEmail');
    attemptForEmail++;

    email = stdin.readLineSync()!;

    if (attemptForEmail > 3 && userManager.isValidEmail(email) == false) {
      print('Вам отказано в регистрации!');
      return email;
    }
  } while (!userManager.isValidEmail(email) && attemptForEmail <= 3);
  return email;
}

/// Ввод пароля
String inputPassword() {
  String password = '';
  int attemptForPassword = 1;
  do {
    print('\n ********** ВВЕДИТЕ ПАРОЛЬ **********\n'
        'Пароль должен содержать не менее 8 символов,\n'
        'включая хотя бы одну цифру и одну букву.\n');
    print(' Попытка №$attemptForPassword');
    attemptForPassword++;
    password = stdin.readLineSync()!;

    if (attemptForPassword > 3 &&
        userManager.isValidPassword(password) == false) {
      print('Вам отказано в регистрации!');
    }
  } while (!userManager.isValidPassword(password) && attemptForPassword <= 3);

  attemptForPassword = 1;
  print('\n ********** ВВЕДИТЕ ПАРОЛЬ ЕЩЁ РАЗ **********\n');
  String confirmPassword;
  do {
    print('Попытка №$attemptForPassword');
    confirmPassword = stdin.readLineSync()!;
    attemptForPassword++;
    if (password == confirmPassword) return password;
  } while (password != confirmPassword && attemptForPassword <= 3);
  return password;
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
