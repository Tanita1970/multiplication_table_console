import 'package:multiplication_table_console/models/task.dart';
import 'package:multiplication_table_console/models/user.dart';

class TasksGenerator {
  final User user;
  List<Task> tasks = [];

  TasksGenerator(this.user) {
    // tasks = [];
    int num_1 = user.setting.numOneFrom;    
    int countNumOne = user.setting.numOneTo - user.setting.numOneFrom + 1;
    int countNumTwo = user.setting.numTwoTo - user.setting.numTwoFrom + 1;
    for (int i = 0; i < countNumOne; i++) {
      int num_2 = user.setting.numTwoFrom;
      for (int j = 0; j < countNumTwo; j++) {
        tasks.add(
          Task(
            numOne: num_1,
            numTwo: num_2,
            result: num_1 * num_2,
          ),
        );
        num_2++;
      }
      num_1++;
    }
  }
}
  // if (user.setting.mode == Mode.timed) {
  // int totalSeconds = user.setting.timeMinute * 60 + user.setting.timeSecond;
  // int taskCount = totalSeconds ~/ 5; // Каждый вопрос занимает 5 секунд
  // } else {
  //   for (int i = 0; i < taskCount; i++) {
  //     tasks.add(Task(numOne: Random().nextInt(numOne) + 1, numTwo: Random().nextInt(numTwo) + 1));
  //   }
  // }

