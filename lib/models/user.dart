import 'dart:io';

import 'package:multiplication_table_console/models/setting.dart';
import 'package:multiplication_table_console/data/registered_users.dart';
import 'package:multiplication_table_console/services/file_manager.dart';

class User {
  String name;
  bool isPremium;
  Setting setting;
  String email;
  String password;

  User({
    required this.name,
    required this.isPremium,
    required this.setting,
    required this.email,
    required this.password,
  });

  User.defaultValue()
      : name = "",
        isPremium = false,
        setting = Setting.defaultValue(),
        email = "",
        password = "";

// Устанавливаем имя пользователя
  void setName(String name) {
    this.name = name;
  }

// Устанавливаем email пользователю
  void setEmail(String email) {
    this.email = email;
  }

  // Устанавливаем пароль пользователю
  void setPassword(String password) {
    this.password = password;
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
