import 'dart:io';
import 'dart:convert';
import 'package:multiplication_table_console/models/user.dart';

/// Класс FileManager позволяет управлять процессом
/// чтения и записи информации о пользователе в файл
class FileManager {
  /// Функция для сохранения списка пользователей users в файл filePath
  Future<void> saveUsersToFile(List<User> users, String filePath) async {
    final file = File(filePath);

    // Конвертируем список пользователей в JSON
    List<Map<String, dynamic>> jsonList =
        users.map((user) => user.toJson()).toList();

    // Конвертируем список JSON в строку
    String jsonString = jsonEncode(jsonList);

    // Записываем строку в файл
    await file.writeAsString(jsonString);
    print('Данные сохранены в файл $filePath');
  }

  /// Функция для загрузки списка пользователей из файла filePath
  Future<List<User>> loadUsersFromFile(String filePath) async {
    final file = File(filePath);

    // Проверяем, существует ли файл
    if (!await file.exists()) {
      print('Файл $filePath не существует. Создаем новый файл.');

      // Если файла по указанному пути не существует, то
      // создаем файл и записываем в него пустой список
      await saveUsersToFile([], filePath);
    }

    // Читаем содержимое файла как строку
    String jsonString = await file.readAsString();

    // Конвертируем JSON-строку в список
    List<dynamic> jsonList = jsonDecode(jsonString);

    // Конвертируем JSON-строку в список объектов User
    // и возвращаем
    return jsonList.map((json) => User.fromJson(json)).toList();
  }

  /// Функция для добавления новых пользователей newUsers в файл filePath
  Future<void> addUsersToFile(List<User> newUsers, String filePath) async {
    // Загружаем текущих пользователей из файла в users
    List<User> users = await loadUsersFromFile(filePath);

    // Добавляем новых пользователей в список users
    users.addAll(newUsers);

    // Сохраняем обновленный список обратно в файл
    await saveUsersToFile(users, filePath);
  }
}
