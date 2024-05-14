import 'package:multiplication_table_console/models/setting.dart';

class User {
  String name;
  bool isPremium = false;
  Setting setting = Setting();
  String email = 'Нет';
  String password = 'Нет';

  User({
    required this.name,
  });

  @override
  String toString() {
    return '\n*** Информация о пользователе ***\nИмя: $name,\n'
        'isPremium: $isPremium,\n'
        'email: $email,\n'
        'password: $password,\n\n'
        '*** setting ***\n$setting\n';
  }
}
