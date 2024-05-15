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
    for (var i = 0; i < count; i++) {
      Task task = getRandomTask();
      print('${task.numOne} * ${task.numTwo} =?');

      int answer = int.parse(stdin.readLineSync() ?? '');
      UserTask userTask = UserTask(user, task);
      userTask.setAnswer(answer);
      userTask.checkAnswer();

      if (userTask.isCorrect) {
        correctAnswersCount++; // Проверить, вроде не нужно!
        solvedTasks.add(task);
        unsolvedTasks.remove(task);
      } else {
        wrongAnswersCount++; // Проверить, вроде не нужно!
      }
      userTasks.add(userTask);
    }
  }

  void startTaskByTime(List<Task> tasks) {
    Timer timer;
    int timeLimit = user.setting.timeMinute * 60 + user.setting.timeSecond;
    int elapsedTime = 0;
    
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      elapsedTime++;
      if (elapsedTime >= timeLimit) {
        t.cancel();
        print('Время вышло!');
        return;
      }
    });
    training(tasks.length);
  }

  void startTaskByCount(List<Task> tasks) {
    training(user.setting.taskCount);
  }

  void startTask() {
    tasks = generateTasks();
    if (user.setting.mode == Mode.timed) {
      startTaskByTime(tasks);
    } else {
      startTaskByCount(tasks);
    }
    print(userTasks);
    print('\nВсего правильных ответов: $correctAnswersCount.\n'
        'Всего не правильных ответов: $wrongAnswersCount');
    print('Правильно решенные: $solvedTasks');
    print('Не решенные: $unsolvedTasks');
  }
}
