class Task {
  final int numOne;
  final int numTwo;
  final int result;

  const Task({
    required this.numOne,
    required this.numTwo,
    required this.result,
  });
  @override
  String toString() {
    return 'Task{numOne: $numOne, numTwo: $numTwo, result: $result}\n';
  }
}
