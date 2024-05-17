import 'dart:async';
import 'dart:convert';
import 'dart:io';

void main() {
  List<int> numbers = [];
  int maxNumbers = 20;

  stdout.write('Введите до 20 чисел (нажмите Enter после каждого числа): ');

  Timer(Duration(seconds: 30), () {
    print('\n\nИстекло время для ввода чисел.');
    if (numbers.isNotEmpty) {
      print('Введенные числа: $numbers');
    } else {
      print('Вы не успели ввести числа.');
    }
    exit(0);
  });

  print('object111111111111');
  List<int> task = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];
  var i = 0;
  print('${task[i]} * ${task[i]} = ?');

  stdin.transform(utf8.decoder).listen((String data) {
    if (numbers.length < maxNumbers) {
      try {
        int number = int.parse(data.trim());
        print('Ваш ответ: $number');
        numbers.add(number);
        i = i + 1;
        print('${task[i]} * ${task[i]} = ?');

        // numbers.add(int.parse(data.trim()));
      } catch (e) {
        print('Неверный формат числа. Пожалуйста, введите целое число.');
      }
    } else {
      print('Вы уже ввели максимальное количество чисел ($maxNumbers).');
    }
  });
}
