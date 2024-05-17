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
      mode: Mode.taskCount,
      taskCount: 10,
    ),
  ),
  User(
    name: 'Vasya',
    email: 'vasya@example.com',
    password: 'vasya12345',
    isPremium: true,
    setting: Setting(
      numOneFrom: 4,
      numOneTo: 8,
      numTwoFrom: 4,
      numTwoTo: 9,
      mode: Mode.timed,
      timeMinute: 0,
      timeSecond: 30,
    ),
  ),
  User(
    name: 'Alina',
    email: 'alina@example.com',
    password: 'alina12345',
    isPremium: true,
    setting: Setting(
      numOneFrom: 3,
      numOneTo: 6,
      numTwoFrom: 2,
      numTwoTo: 7,
      mode: Mode.timed,
      timeMinute: 0,
      timeSecond: 40,
    ),
  ),
  User(
    name: 'Andrey',
    email: 'andrey@example.com',
    password: 'andrey12345',
    isPremium: true,
    setting: Setting(
      numOneFrom: 9,
      numOneTo: 9,
      numTwoFrom: 1,
      numTwoTo: 9,
      mode: Mode.taskCount,
      taskCount: 10,
    ),
  ),
];
