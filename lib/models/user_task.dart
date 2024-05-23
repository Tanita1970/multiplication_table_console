import 'package:multiplication_table_console/models/task.dart';
import 'package:multiplication_table_console/models/user.dart';

class UserTask {
  User user;
  Task task;

  int userAnswer = 0;
  bool isCorrectAnswer = false;

  UserTask(this.user, this.task);

  void setAnswer(int answer) {
    userAnswer = answer;
    isCorrectAnswer = answer == task.result;
  }

  @override
  String toString() {
    return '\n$task. Ответ пользователя: $userAnswer ($isCorrectAnswer)';
  }
}
