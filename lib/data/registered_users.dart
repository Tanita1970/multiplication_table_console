import 'package:multiplication_table_console/models/setting.dart';
import 'package:multiplication_table_console/models/user.dart';

List<User> registeredUsers = [
  User(
    name: 'Tanya',
    email: 'tanya@example.com',
    password: 'tanya12345',
    isPremium: true,
    setting: Setting(
      numOneFrom: 2,
      numOneTo: 8,
      numTwoFrom: 2,
      numTwoTo: 8,
      timeMinute: 0,
      timeSecond: 30,
      mode: Mode.taskCount,
      taskCount: 10,
    ),
  ),
];
