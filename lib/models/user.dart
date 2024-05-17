import 'dart:io';

import 'package:multiplication_table_console/models/setting.dart';
import 'package:multiplication_table_console/data/list_of_registered_users.dart';

class User {
  String name;
  bool isPremium = false;
  Setting setting = Setting();
  String email = 'Нет';
  String password = 'Нет';

  User({required this.name, isPremium, setting, email, password});  

  void register() {
    print('Регистрация...');

    /// Ввод имени пользователя
    int attemptForName = 1;
    print('\n ********** ВВЕДИТЕ ИМЯ **********');
    do {
      print('Попытка №$attemptForName');
      name = stdin.readLineSync()!;
      attemptForName++;
      if (attemptForName > 3 && isValidName(name) == false) {
        print('Вам отказано в регистрации!');
        return;
      }
    } while (!isValidName(name) && attemptForName <= 3);

    /// Ввод почтового ящика
    int attemptForEmail = 1;

    print('\n ********** ВВЕДИТЕ email: **********');

    do {
      print(' Попытка №$attemptForEmail');
      attemptForEmail++;

      email = stdin.readLineSync()!;

      if (attemptForEmail > 3 && isValidEmail(email) == false) {
        print('Вам отказано в регистрации!');
        return;
      }
    } while (!isValidEmail(email) && attemptForEmail <= 3);

    /// Ввод пароля
    int attemptForPassword = 1;
    do {
      print('\n ********** ВВЕДИТЕ ПАРОЛЬ **********\n'
          'Пароль должен содержать не менее 8 символов,\n'
          'включая хотя бы одну цифру и одну букву.\n');
      print(' Попытка №$attemptForPassword');
      attemptForPassword++;
      password = stdin.readLineSync()!;

      if (attemptForPassword > 3 && isValidPassword(password) == false) {
        print('Вам отказано в регистрации!');
        return;
      }
    } while (!isValidPassword(password) && attemptForPassword <= 3);

    attemptForPassword = 1;
    print('\n ********** ВВЕДИТЕ ПАРОЛЬ ЕЩЁ РАЗ **********\n');
    String confirmPassword;
    do {
      print('Попытка №$attemptForPassword');
      confirmPassword = stdin.readLineSync()!;
      attemptForPassword++;
    } while (password != confirmPassword && attemptForPassword <= 3);

    /// Проверка на существование пользователя в базе данных    
    for (User user in registeredUsers) {
      if (user.name == name && user.email == email) {
        print('Вы уже зарегистрированы!');
        return;
      }
    }
    /// Создание нового пользователя в базе данных
    User newUser = User(
        name: name,
        isPremium: isPremium,
        setting: setting,
        email: email,
        password: password);
    registeredUsers.add(newUser);
    print('Вы успешно зарегистрировались!');
  }

  bool isValidName(String name) {
    // Простое регулярное выражение для проверки подлинности имени
    RegExp nameRegex = RegExp(r'^[\w-]+(\.[\w-]+)*$');
    return nameRegex.hasMatch(name);
  }

  bool isValidEmail(String email) {
    // Простое регулярное выражение для проверки подлинности электронной почты
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  bool isValidPassword(String password) {
    // Простая проверка пароля: не менее 8 символов, включая как минимум одну цифру и одну букву
    RegExp passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    return passwordRegex.hasMatch(password);
  }

  bool login(String email, String password) {
    // Сверка адреса электронной почты и пароля 
    // с учетными данными зарегистрированного пользователя
    for (User user in registeredUsers) {
      if (user.email == email && user.password == password) {
        print('Вы успешно вошли в систему!');
        return true;
      }
    }
    print('Неверный email или пароль!');
    return false;
  }

  @override
  String toString() {
    return '\n*** Информация о пользователе ***\nИмя: $name,\n'
        'isPremium: $isPremium,\n'
        'email: $email,\n'
        'password: $password,\n\n'
        '*** setting ***\n$setting\n';
  }
}