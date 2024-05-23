import 'package:multiplication_table_console/data/registered_users.dart';
import 'package:multiplication_table_console/models/user.dart';
import 'package:multiplication_table_console/services/file_manager.dart';

/// UserManger:
///  - хранит зарегистрированных пользователей
///  - регистрирует пользователя(получая на вход имя, пароль, емейл),
///    прверяя корректность данных и добавляя в список пользователей
///  - авторизовывает пользователя(получает на вход имя, пароль)
///    через поиск в списке пользователей, после чего возвращает пользователя из метода
class UserManager {
  /// Регистрирация нового пользователя
  void register(User newUser) {
    // Добавление нового пользователя в список registeredUsers
    registeredUsers.add(newUser);

    // Добавляем новых пользователей в файл
    FileManager().addUsersToFile(registeredUsers);
  }

  /// Авторизация пользователя в приложении
  User login(String name, String email, String password) {
    registeredUsers = FileManager().loadUsersFromFile();
    for (User user in registeredUsers) {
      if (user.name == name &&
          user.email == email &&
          user.password == password) {
        print('Вы успешно вошли в систему!');
        return user;
      }
    }

    throw Exception('Пользователь не найден');
  }

  /// Проверка правильности введенного имени name
  bool isValidName(String name) {
    // Простое регулярное выражение для проверки подлинности имени
    RegExp nameRegex = RegExp(r'^[\w-]+(\.[\w-]+)*$');
    return nameRegex.hasMatch(name);
  }

  /// Проверка правильности введенного email
  bool isValidEmail(String email) {
    // Простое регулярное выражение для проверки подлинности электронной почты
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  /// Проверка правильности введенного пароля
  bool isValidPassword(String password) {
    // Простая проверка пароля: не менее 8 символов, включая как минимум одну цифру и одну букву
    RegExp passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    return passwordRegex.hasMatch(password);
  }
}
