// import 'dart:math';
// import 'package:multiplication_table_console/models/task.dart';

enum Mode {
  timed,
  taskCount,
}

extension ModeExtension on Mode {
  String get displayName {
    switch (this) {
      case Mode.timed:
        return 'По времени';
      case Mode.taskCount:
        return 'По количеству примеров';
      default:
        return '';
    }
  }

  static Mode fromString(String mode) {
    switch (mode) {
      case 'По времени':
        return Mode.timed;
      case 'По количеству примеров':
        return Mode.taskCount;
      default:
        throw Exception('Invalid mode string');
    }
  }
}

class Setting {
  int numOneFrom;
  int numOneTo;
  int numTwoFrom;
  int numTwoTo;
  int timeMinute;
  int timeSecond;
  int taskCount;
  Mode mode;

  Setting({
    required this.numOneFrom,
    required this.numOneTo,
    required this.numTwoFrom,
    required this.numTwoTo,
    required this.timeMinute,
    required this.timeSecond,
    required this.taskCount,
    required this.mode,
  });

  Setting.defaultValue()
      : numOneFrom = 1,
        numOneTo = 9,
        numTwoFrom = 1,
        numTwoTo = 9,
        timeMinute = 0,
        timeSecond = 30,
        taskCount = 12,
        mode = Mode.taskCount;

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
    } else {
      taskCount = 0;
    }
    mode = value;
  }

  void swapValues(int a, int b) {
    int temp = a;
    a = b;
    b = temp;
  }

  // Конвертируем объект в JSON
  Map<String, dynamic> toJson() => {
        'numOneFrom': numOneFrom,
        'numOneTo': numOneTo,
        'numTwoFrom': numTwoFrom,
        'numTwoTo': numTwoTo,
        'timeMinute': timeMinute,
        'timeSecond': timeSecond,
        'taskCount': taskCount,
        'mode': mode.displayName,
      };

  // Конструктор из JSON
  factory Setting.fromJson(Map<String, dynamic> json) {
    return Setting(
      numOneFrom: json['numOneFrom'],
      numOneTo: json['numOneTo'],
      numTwoFrom: json['numTwoFrom'],
      numTwoTo: json['numTwoTo'],
      timeMinute: json['timeMinute'],
      timeSecond: json['timeSecond'],
      taskCount: json['taskCount'],
      mode: ModeExtension.fromString(json['mode']),
    );
  }

  @override
  String toString() {
    return 'Первое число: от $numOneFrom до $numOneTo,\n'
        'Второе число: От $numTwoFrom до $numTwoTo,\n'
        'Время: $timeMinute мин. $timeSecond сек.,\n'
        'Количество примеров: $taskCount,\n'
        'Режим тренировки: $mode';
  }
}
