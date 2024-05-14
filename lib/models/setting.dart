// import 'dart:math';
// import 'package:multiplication_table_console/models/task.dart';

enum Mode {
  timed,
  taskCount,
}

class Setting {
  int numOneFrom = 1;
  int numOneTo = 9;
  int numTwoFrom = 1;
  int numTwoTo = 9;
  int timeMinute = 0;
  int timeSecond = 30;
  int taskCount = 10;
  Mode mode = Mode.taskCount;

  // Setting() {
  //   if (mode == Mode.taskCount) {
  //     timeMinute = 0;
  //     timeSecond = 0;
  //     taskCount = 10;
  //   } else {
  //     timeMinute = 0;
  //     timeSecond = 30;
  //     taskCount = 0;
  //   }
  // }

  void setNumOneFromTo({required int valueFrom, required int valueTo}) {
    if (valueFrom > valueTo) {
      swapValues(valueFrom, valueTo);
    }
    numOneFrom = valueFrom;
    numOneTo = valueTo;

    if (valueFrom < 0 || valueFrom == 0) {
      numOneFrom = 1;
    }
    if (valueFrom > 9) {
      numOneFrom = 9;
    }
    if (valueTo < 0 || valueTo == 0) {
      numOneTo = 9;
    }
    if (valueTo > 9) {
      numOneTo = 9;
    }
  }

  void setNumTwoFromTo({required int valueFrom, required int valueTo}) {
    if (valueFrom > valueTo) {
      swapValues(valueFrom, valueTo);
    }
    numTwoFrom = valueFrom;
    numTwoTo = valueTo;

    if (numTwoFrom < 0 || numTwoFrom == 0) {
      numTwoFrom = 1;
    }
    if (numTwoFrom > 9) {
      numTwoFrom = 9;
    }
    if (numTwoTo < 0 || numTwoTo == 0) {
      numTwoTo = 0;
    }
    if (numTwoTo > 9) {
      numTwoTo = 9;
    }
  }

  void setTimeMinute({required int minute}) {
    if (minute < 0) {
      timeMinute = 0;
    }
    if (minute > 59) {
      timeMinute = 59;
    }
  }

  void setTimeSecond({required int second}) {
    if (second <= 0) {
      timeSecond = 30;
    }
    if (second > 59) {
      timeSecond = 59;
    }
  }

  void setTaskCount({required int count}) {
    taskCount = count;
  }

  void setMode({required Mode value}) {
    if (value == Mode.taskCount) {
      timeMinute = 0;
      timeSecond = 0;
      taskCount = 10;
    } else {
      timeMinute = 0;
      timeSecond = 30;
      taskCount = 0;
    }
    mode = value;
  }

  void swapValues(int a, int b) {
    int temp = a;
    a = b;
    b = temp;
  }

  @override
  String toString() {
    return 'Первое число: от $numOneFrom до $numOneTo,\n'
        'Второе число: От $numTwoFrom до $numTwoTo,\n'
        'Время: $timeMinute мин. $timeSecond сек.,\n'
        'Количество примеров: $taskCount,\n'
        'Режим тренировки: ${mode == Mode.timed ? 'По времени' : 'По количеству примеров'}';
  }
}
