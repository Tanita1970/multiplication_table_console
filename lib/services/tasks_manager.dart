import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:async';

import 'package:multiplication_table_console/models/setting.dart';
import 'package:multiplication_table_console/models/task.dart';
import 'package:multiplication_table_console/models/user.dart';
import 'package:multiplication_table_console/models/user_task.dart';
import 'package:multiplication_table_console/services/user_manager.dart';

class TasksManager {
  TasksManager(this.user);

  final User user;

  List<Task> tasks = [];
  List<UserTask> userTasks = [];

  int correctAnswersCount = 0;
  int wrongAnswersCount = 0;

  List<Task> solvedTasks = [];
  List<Task> unsolvedTasks = [];

  /// Метод generateTasks создает список всех возможных задач
  /// на основе настроек пользователя для первого и второго чисел.
  List<Task> generateTasks() {
    List<Task> tasks = [];
    for (int i = user.setting.numOneFrom; i <= user.setting.numOneTo; i++) {
      for (int j = user.setting.numTwoFrom; j <= user.setting.numTwoTo; j++) {
        tasks.add(Task(numOne: i, numTwo: j, result: i * j));
      }
    }
    // print(' Список tasks: ${tasks.toString()}');
    return tasks;
  }

  /// startTaskByTime(List<Task> tasks) - Тренировка по времени
  void startTaskByTime(List<Task> tasks) {
    // training(tasks.length);
    int timeTraining = user.setting.timeMinute * 60 + user.setting.timeSecond;
    Timer(Duration(seconds: timeTraining), () {
      print('\n\nИстекло время для ввода чисел.');
      print(userTasks);
      print('\nВсего правильных ответов: $correctAnswersCount.\n'
          'Всего не правильных ответов: $wrongAnswersCount');
      print('Правильно решенные: $solvedTasks');
      print('Не решенные: $unsolvedTasks');
      print('tasks: $tasks');
      exit(0);
    });

    // print('Список всех примеров: $tasks');
    tasks.shuffle();
    // print('Перемешанные $tasks');

    if (unsolvedTasks.isEmpty) unsolvedTasks.addAll(tasks);

    print('\n\nТренировка ПО ВРЕМЕНИ началась!!!');
    print('Время: $timeTraining');
    print('\n*** Пример №1:');
    int counterTasks = 0;
    int index = 0;
    print('${tasks[index].numOne} * ${tasks[index].numTwo} = ?');

    stdin.transform(utf8.decoder).listen((String data) {
      int answer = int.parse(data.trim());
      UserTask userTask = UserTask(user, tasks[index]);
      userTask.setAnswer(answer);
      userTask.checkAnswer();
      userTasks.add(userTask);
      if (userTask.isCorrect) {
        correctAnswersCount++;
        solvedTasks.add(tasks[index]);
        unsolvedTasks.remove(tasks[index]);
      } else {
        var savedTask = tasks[index];
        tasks.removeAt(index);
        int newIndex = (index + 2 < tasks.length) ? index + 2 : tasks.length;
        tasks.insert(newIndex, savedTask);
        index--;
        wrongAnswersCount++;
      }

      index++;
      if (index >= tasks.length) {
        tasks.shuffle();
        index = 0;
      }
      print('\n*** Пример №${counterTasks + 1}:');
      counterTasks++;
      print('${tasks[index].numOne} * ${tasks[index].numTwo} = ?');
    });
  }

  /// startTaskByCount(List<Task> tasks) - тренировка по количеству заданий
  void startTaskByCount(List<Task> tasks) {
    // training(user.setting.taskCount);
    // print('Список всех примеров: $tasks');
    tasks.shuffle();
    // print('Перемешанные $tasks');

    if (unsolvedTasks.isEmpty) unsolvedTasks.addAll(tasks);

    print('\n\nТренировка ПО КОЛИЧЕСТВУ началась!!!');
    print(
        '${user.name}, тебе надо решить ${user.setting.taskCount} примеров!\n');
    int counterTasks = 1;
    int userSettingTaskCount = user.setting.taskCount;
    for (var index = 0; index < userSettingTaskCount; index++) {
      print('\n*** Пример №$counterTasks:');
      print('${tasks[index].numOne} * ${tasks[index].numTwo} = ?');

      int answer = int.parse(stdin.readLineSync() ?? '');
      UserTask userTask = UserTask(user, tasks[index]);
      userTask.setAnswer(answer);
      userTask.checkAnswer();
      userTasks.add(userTask);
      if (userTask.isCorrect) {
        correctAnswersCount++;
        solvedTasks.add(tasks[index]);
        unsolvedTasks.remove(tasks[index]);
      } else {
        var savedTask = tasks[index];
        tasks.removeAt(index);
        int newIndex = (index + 2 < tasks.length) ? index + 2 : tasks.length;
        tasks.insert(newIndex, savedTask);
        index--;
        userSettingTaskCount--;
        wrongAnswersCount++;
      }

      if (index >= tasks.length) {
        tasks.shuffle();
        index = 0;
      }

      counterTasks++;
    }
    print(userTasks);
    print('\nВсего правильных ответов: $correctAnswersCount.\n'
        'Всего не правильных ответов: $wrongAnswersCount');
    print('Правильно решенные: $solvedTasks');
    print('Не решенные: $unsolvedTasks');
    print('tasks: $tasks');
  }

  void startTask() {
    tasks = generateTasks();
    if (user.setting.mode == Mode.timed) {
      startTaskByTime(tasks);
    } else {
      startTaskByCount(tasks);
    }
  }
}
