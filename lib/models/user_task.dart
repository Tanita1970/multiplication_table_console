import 'package:multiplication_table_console/models/task.dart';
import 'package:multiplication_table_console/models/user.dart';

class UserTask {
  User user;
  Task task;

  int userAnswer = 0;
  bool isCorrect = false;
  int countCorrectAnswer = 0;
  int countWrongAnswer = 0;

  UserTask(this.user, this.task);

  void setAnswer(int answer) {
    userAnswer = answer;
  }

  void checkAnswer() {
    if (userAnswer == task.result) {
      isCorrect = true;
      countCorrectAnswer++;
    } else {
      isCorrect = false;
      countWrongAnswer++;
    }
  }

  void reset() {
    userAnswer = 0;
    isCorrect = false;
    countCorrectAnswer = 0;
    countWrongAnswer = 0;
  }

  @override
  String toString() {
    return 'UserTask: user: $user,\n'
        'task: $task,\n'
        'userAnswer: $userAnswer,\n'
        'isCorrect: $isCorrect,\n'
        'countCorrectAnswer: $countCorrectAnswer,\n'
        'countWrongAnswer: $countWrongAnswer';
  }
}
