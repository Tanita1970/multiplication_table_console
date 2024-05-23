import 'package:multiplication_table_console/models/task.dart';
import 'package:multiplication_table_console/models/user.dart';

class UserTask {
  User user;
  Task task;

  int userAnswer = 0;
  bool isCorrect = false;

  UserTask(this.user, this.task);

  void setAnswer(int answer) {
    userAnswer = answer;
  }

  void checkAnswer() {
    if (userAnswer == task.result) {
      isCorrect = true;
    } else {
      isCorrect = false;
    }
  }

  void reset() {
    userAnswer = 0;
    isCorrect = false;
    // countCongAnswer = 0;
  }

  @override
  String toString() {
    return '\n$task. Ответ пользователя: $userAnswer ($isCorrect)';
  }
}
