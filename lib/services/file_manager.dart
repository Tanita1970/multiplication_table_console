import 'dart:io';
import 'dart:convert';
import 'package:multiplication_table_console/globals.dart';
import 'package:multiplication_table_console/models/user.dart';

/// Класс FileManager позволяет управлять процессом
/// чтения и записи информации о пользователе в файл
class FileManager {
  /// Функция для сохранения списка пользователей users в файл filePath
  void _saveUsersToFile(List<User> users) {
    final file = File(registredUsersFilePath);

    // Конвертируем список пользователей в JSON
    List<Map<String, dynamic>> jsonList =
        users.map((user) => user.toJson()).toList();

    // Конвертируем список JSON в строку
    String jsonString = jsonEncode(jsonList);

    // Записываем строку в файл
    file.writeAsStringSync(jsonString);
    print('Данные сохранены в файл $registredUsersFilePath');
  }

  /// Функция для загрузки списка пользователей из файла filePath
  List<User> loadUsersFromFile() {
    final file = File(registredUsersFilePath);

    // Проверяем, существует ли файл
    if (!file.existsSync()) {
      print('Файл $registredUsersFilePath не существует. Создаем новый файл.');

      // Если файла по указанному пути не существует, то
      // создаем файл и записываем в него пустой список
      _saveUsersToFile([]);
    }

    // Читаем содержимое файла как строку
    String jsonString = file.readAsStringSync();

    // Конвертируем JSON-строку в список
    List<dynamic> jsonList = jsonDecode(jsonString);

    // Конвертируем JSON-строку в список объектов User
    // и возвращаем
    return jsonList.map((json) => User.fromJson(json)).toList();
  }

  /// Функция для добавления новых пользователей newUsers в файл filePath
  void addUsersToFile(User newUsers) {
    // Загружаем текущих пользователей из файла в users
    List<User> users = loadUsersFromFile();

    // Добавляем новых пользователей в список users
    users.add(newUsers);

    // Сохраняем обновленный список обратно в файл
    _saveUsersToFile(users);
  }
}
