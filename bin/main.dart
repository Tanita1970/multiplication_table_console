import 'dart:io';

import 'package:multiplication_table_console/models/setting.dart';
import 'package:multiplication_table_console/models/user.dart';
import 'package:multiplication_table_console/services/tasks_manager.dart';
import 'package:multiplication_table_console/services/user_manager.dart';

// Удалить эти глобальные переменные
String name = '';
String email = '';
String password = '';

// Добавить глбальные переменные, отвечающие за инициализацию UserManager, FileManager.
// Во всём коде использовать эти переменные вместо создания объекта на каждый вызов метода

void main() async {
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
        User user = UserManager().login(name, email, password);
        print('\n Пользователь ${user.name} авторизован\n');
        TasksManager(user).startTask();
      } catch (e) {
        print('\n Пользователь $name не авторизован\n');
      }

    case '2':
      // Поправить на record (метод inputUserData должен взвращать 3 строки, имя, мыло, пароль)
      inputUserData();
      User newUser2 = User(
          name: name,
          email: email,
          password: password,
          setting: Setting.defaultValue(),
          isPremium: false);
      UserManager().register(newUser2);
      print('\n Создан пользователь ${newUser2.toString()}\n');

    case '3':
      exit(0);

    default:
      exit(0);
  }
  /*
  // User newUser1 = User(name: 'Новый пользователь', setting: Setting());
  // newUser1.register();

  // Очищаем текущий список для теста загрузки
  // registeredUsers.clear();
  // print(registeredUsers);

  // // Загружаем пользователей из файла
  // registeredUsers = await loadUsersFromFile('registered_users.json');

  // Печатаем загруженные данные
  // for (var user in registeredUsers) {
  //   print('kllkjlkjlkjl');
  //   print(user);
  // }
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
  */
}

void inputUserData() {
  print('Регистрация...');
  inputName();
  inputEmail();
  inputPassword();
}

/// Ввод имени пользователя
void inputName() {
  int attemptForName = 1;
  print('\n ********** ВВЕДИТЕ ИМЯ **********');
  do {
    print('Попытка №$attemptForName');
    name = stdin.readLineSync()!;
    attemptForName++;
    if (attemptForName > 3 && UserManager().isValidName(name) == false) {
      print('Вам отказано в регистрации!');
      return;
    }
  } while (!UserManager().isValidName(name) && attemptForName <= 3);
}

/// Ввод почтового ящика
void inputEmail() {
  int attemptForEmail = 1;

  print('\n ********** ВВЕДИТЕ email: **********');

  do {
    print(' Попытка №$attemptForEmail');
    attemptForEmail++;

    email = stdin.readLineSync()!;

    if (attemptForEmail > 3 && UserManager().isValidEmail(email) == false) {
      print('Вам отказано в регистрации!');
      return;
    }
  } while (!UserManager().isValidEmail(email) && attemptForEmail <= 3);
}

/// Ввод пароля
void inputPassword() {
  int attemptForPassword = 1;
  do {
    print('\n ********** ВВЕДИТЕ ПАРОЛЬ **********\n'
        'Пароль должен содержать не менее 8 символов,\n'
        'включая хотя бы одну цифру и одну букву.\n');
    print(' Попытка №$attemptForPassword');
    attemptForPassword++;
    password = stdin.readLineSync()!;

    if (attemptForPassword > 3 &&
        UserManager().isValidPassword(password) == false) {
      print('Вам отказано в регистрации!');
      return;
    }
  } while (!UserManager().isValidPassword(password) && attemptForPassword <= 3);

  attemptForPassword = 1;
  print('\n ********** ВВЕДИТЕ ПАРОЛЬ ЕЩЁ РАЗ **********\n');
  String confirmPassword;
  do {
    print('Попытка №$attemptForPassword');
    confirmPassword = stdin.readLineSync()!;
    attemptForPassword++;
  } while (password != confirmPassword && attemptForPassword <= 3);
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
