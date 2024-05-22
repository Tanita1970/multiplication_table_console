import 'dart:io';

import 'package:multiplication_table_console/models/setting.dart';
import 'package:multiplication_table_console/data/registered_users.dart';
import 'package:multiplication_table_console/services/file_operations.dart';

class User {
  String name;
  bool isPremium;
  Setting setting;
  String email;
  String password;

  User({
    required this.name,
    this.isPremium = false,
    required this.setting,
    this.email = 'Нет',
    this.password = 'Нет',
  });
// Устанавливаем email пользователю
  void setEmail(String email) {
    this.email = email;
  }

  // Устанавливаем пароль пользователю
  void setPassword(String password) {
    this.password = password;
  }

  void register() async {
    inputUserData();

    // Добавление нового пользователя в список registeredUsers
    User newUser = User(
        name: name,
        isPremium: isPremium,
        setting: setting,
        email: email,
        password: password);
    registeredUsers.add(newUser);

    // Сохранение списка пользователей в файл
    // await saveUsersToFile(registeredUsers, 'registered_users.json');

    // // Очищаем текущий список для теста загрузки
    // registeredUsers.clear();

    // // Загрузка списка пользователей из файла
    // List<User> loadedUsers = await loadUsersFromFile('registered_users.json');
    // print('Загруженные пользователи:');
    // for (var user in loadedUsers) {
    //   print(user);
    // }

    // Добавляем новых пользователей в файл
    await addUsersToFile(registeredUsers, 'registered_users.json');

    // Загружаем и печатаем всех пользователей из файла для проверки
    // List<User> allUsers = await loadUsersFromFile('registered_users.json');
    // print('Все пользователи после добавления новых:');
    // for (var user in allUsers) {
    //   print(user);
    // }
  }

// // Проверка на существование пользователя в базе данных
  // for (User user in registeredUsers) {
  //   if (user.name == name && user.email == email) {
  //     print('Вы уже зарегистрированы!');
  //     return;
  //   }
  // }
  Future<User> authorization(filePath) async {
    registeredUsers = await loadUsersFromFile(filePath);
    for (User user in registeredUsers) {
      if (user.email == email && user.password == password) {
        print('Вы успешно вошли в систему!');
        return user;
      }
    }
    print('Вы не авторизованы!');
    return User(
      name: '',
      isPremium: false,
      setting: Setting(),
      email: '',
      password: '',
    );
  }

  void inputUserData() {
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

  // Конвертируем объект в JSON
  Map<String, dynamic> toJson() => {
        'name': name,
        'isPremium': isPremium,
        'setting': setting.toJson(),
        'email': email,
        'password': password,
      };

  // Конструктор из JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      isPremium: json['isPremium'],
      setting: Setting.fromJson(json['setting']),
      email: json['email'],
      password: json['password'],
    );
  }

  @override
  String toString() {
    return '\n\n*** ПОЛЬЗОВАТЕЛЬ ${name.toUpperCase()} ***\n'
        'isPremium: $isPremium,\n'
        'email: $email,\n'
        'password: $password,\n\n'
        'НАСТРОЙКИ:\n$setting';
  }
}
