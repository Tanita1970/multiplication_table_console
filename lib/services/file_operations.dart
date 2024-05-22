import 'dart:io';
import 'dart:convert';
import 'package:multiplication_table_console/models/user.dart';

/// Функция для сохранения списка пользователей в файл на диске
Future<void> saveUsersToFile(List<User> users, String filePath) async {
  final file = File(filePath);

  List<Map<String, dynamic>> jsonList =
      users // Конвертируем список пользователей в JSON
          .map((user) => user.toJson())
          .toList();
  String jsonString = jsonEncode(jsonList); // Конвертируем список JSON в строку
  await file.writeAsString(jsonString); // Записываем строку в файл
  print('Данные сохранены в файл $filePath');
}

/// Функция для загрузки списка пользователей из файла
Future<List<User>> loadUsersFromFile(String filePath) async {
  final file = File(filePath);

  // Проверяем, существует ли файл
  if (!await file.exists()) {
    // Создаем пустой файл и записываем в него пустой список
    print('Файл $filePath не существует. Создаем новый файл.');
    await saveUsersToFile([], filePath);
  }

  String jsonString =
      await file.readAsString(); // Читаем содержимое файла как строку
  List<dynamic> jsonList =
      jsonDecode(jsonString); // Конвертируем JSON-строку в список
  return jsonList
      .map((json) => User.fromJson(json))
      .toList(); // Конвертируем список JSON в список объектов User
}

/// Функция для добавления новых пользователей в файл
Future<void> addUsersToFile(List<User> newUsers, String filePath) async {
  List<User> users = await loadUsersFromFile(
      filePath); // Загружаем текущих пользователей из файла
  users.addAll(newUsers); // Добавляем новых пользователей к списку
  await saveUsersToFile(
      users, filePath); // Сохраняем обновленный список обратно в файл
}
