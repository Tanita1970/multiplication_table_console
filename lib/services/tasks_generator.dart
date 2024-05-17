import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:async';

import 'package:multiplication_table_console/models/setting.dart';
import 'package:multiplication_table_console/models/task.dart';
import 'package:multiplication_table_console/models/user.dart';
import 'package:multiplication_table_console/models/user_task.dart';

class TasksGenerator {
  TasksGenerator(this.user);

  final User user;

  List<Task> tasks = [];
  List<UserTask> userTasks = [];

  int correctAnswersCount = 0;
  // Надо убрать, так как оказалось, что нигде не используется
  int wrongAnswersCount = 0;
  // Надо убрать, так как оказалось, что нигде не используется

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

  /// Получает произвольную задачу
  /// из списка не решенных задач
  Task getRandomTask() {
    print('***************************************');

    if (unsolvedTasks.isEmpty) {
      unsolvedTasks.addAll(tasks);
    }

    Random random = Random();
    int index = random.nextInt(unsolvedTasks.length);
    Task task = unsolvedTasks[index];
    return task;
  }

  void training(int count) {
    print('khkjhkjhkjhkjhkjhkjhkjkjkjh $tasks');
    List<int> numbers = [];
    int maxNumbers = 20;

    stdout.write('Введите до 20 чисел (нажмите Enter после каждого числа): ');

    Timer(Duration(seconds: 30), () {
      print('\n\nИстекло время для ввода чисел.');
      exit(0);
    });

    stdin.transform(utf8.decoder).listen((String data) {
      print('*****************************object');
      Task task = getRandomTask();
      print('${task.numOne} * ${task.numTwo} = ?');
      int answer = int.parse(data.trim());
      UserTask userTask = UserTask(user, task);
      userTask.setAnswer(answer);
      userTask.checkAnswer();
      userTasks.add(userTask);
      if (userTask.isCorrect) {
        correctAnswersCount++; // Проверить, вроде не нужно!
        solvedTasks.add(task);
        unsolvedTasks.remove(task);
      } else {
        wrongAnswersCount++; // Проверить, вроде не нужно!
      }
    });
  }

  void startTaskByTime(List<Task> tasks) {
    // training(tasks.length);

    Timer(Duration(seconds: 40), () {
      print('\n\nИстекло время для ввода чисел.');
      print(userTasks);
      print('\nВсего правильных ответов: $correctAnswersCount.\n'
          'Всего не правильных ответов: $wrongAnswersCount');
      print('Правильно решенные: $solvedTasks');
      print('Не решенные: $unsolvedTasks');
      print('tasks: $tasks');
      exit(0);
    });

    print('Список всех примеров: $tasks');
    tasks.shuffle();
    print('Перемешанные $tasks');

    if (unsolvedTasks.isEmpty) unsolvedTasks.addAll(tasks);

    print('\n\nТренировка началась!!!');
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

  void startTaskByCount(List<Task> tasks) {
    // training(user.setting.taskCount);
  }

  void startTask() {
    tasks = generateTasks();
    if (user.setting.mode == Mode.timed) {
      startTaskByTime(tasks);
    } else {
      startTaskByCount(tasks);
    }
    //   print(userTasks);
    //   print('\nВсего правильных ответов: $correctAnswersCount.\n'
    //       'Всего не правильных ответов: $wrongAnswersCount');
    //   print('Правильно решенные: $solvedTasks');
    //   print('Не решенные: $unsolvedTasks');
    // }
  }
}
