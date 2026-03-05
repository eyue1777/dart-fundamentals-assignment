// Task 2: Async Calculator App

import 'dart:async';

// Delay used to simulate slow operations
const Duration calculationDelay = Duration(milliseconds: 1500);

/**
 * Custom exception for unknown operations.
 */
class UnknownOperationException implements Exception {
  final String operation;
  UnknownOperationException(this.operation);

  @override
  String toString() =>
      'Hmm… I don’t recognize "$operation". Try add, subtract, multiply, or divide.';
}

/**
 * Calculator class with basic operations and async support.
 */
class Calculator {
  // Name of the calculator
  final String name;

  // Keeps track of your calculation adventures
  final List<String> _history = [];

  // Constructor
  Calculator(this.name);

  // Read-only access to history
  List<String> get history => List.unmodifiable(_history);

  /**
   * Adds two numbers — because who doesn’t love addition?
   */
  double add(double a, double b) {
    return a + b;
  }

  /**
   * Subtracts the second number from the first — simple math!
   */
  double subtract(double a, double b) {
    return a - b;
  }

  /**
   * Multiplies two numbers — let’s make them bigger!
   */
  double multiply(double a, double b) {
    return a * b;
  }

  /**
   * Divides two numbers.
   * Throws error if divisor is zero — math can’t break reality.
   */
  double divide(double a, double b) {
    if (b == 0) {
      throw ArgumentError('Cannot divide by zero. That’s a no-go!');
    }
    return a / b;
  }

  /**
   * Performs the calculation asynchronously with a short "thinking" pause.
   */
  Future<double> computeAsync(double a, double b, String op) async {
    double result;

    switch (op) {
      case 'add':
        result = add(a, b);
        break;
      case 'subtract':
        result = subtract(a, b);
        break;
      case 'multiply':
        result = multiply(a, b);
        break;
      case 'divide':
        result = divide(a, b);
        break;
      default:
        throw UnknownOperationException(op);
    }

    // Save this calculation in history
    _history.add('$op($a, $b) = $result');

    // Simulating a "thinking" pause…
    await Future.delayed(calculationDelay);

    return result;
  }

  /**
   * Calls computeAsync and prints the result in a friendly way.
   * Catches errors so the app keeps running smoothly.
   */
  Future<void> displayResult(double a, double b, String op) async {
    try {
      final double result = await computeAsync(a, b, op);
      print('result of $op($a, $b) is: $result');
    } catch (e) {
      print('\u{26A0} Oops! $e');
    }
  }

  /**
   * Prints all previous calculations in a readable way.
   */
  void printHistory() {
    print('\n Here’s your calculation history so far:');

    if (_history.isEmpty) {
      print('Nothing yet — go ahead, try some calculations!');
    } else {
      for (int i = 0; i < _history.length; i++) {
        print('${i + 1}. ${_history[i]}');
      }
    }
  }

  /**
   * Applies the same operation to a list of values step by step.
   */
  Future<double> computeChained(List<double> values, String op) async {
    if (values.isEmpty) {
      throw ArgumentError('List cannot be empty — give me some numbers!');
    }

    double result = values[0];

    for (int i = 1; i < values.length; i++) {
      result = await computeAsync(result, values[i], op);
    }

    return result;
  }
}

/**
 * Program entry point — let’s have some fun with numbers!
 */
Future<void> main() async {
  final Calculator calc = Calculator('Async Calculator App');

  print(' Welcome to ${calc.name}! \n===============================');

  // Run operations one by one (watch the calculator "think")
  await calc.displayResult(10, 4, 'add');
  await calc.displayResult(10, 4, 'subtract');
  await calc.displayResult(10, 4, 'multiply');
  await calc.displayResult(10, 2, 'divide');
  await calc.displayResult(15, 3, 'divide');

  // Test divide by zero — handle with care!
  await calc.displayResult(10, 0, 'divide');

  // Test an invalid operation — friendly warning
  await calc.displayResult(5, 3, 'power');

  print('\n All calculations completed!\n=====================');

  // Show history
  calc.printHistory();

  // Run operations in parallel — faster results!
  print('\n\u{26A1} Parallel Execution Demo');
  final Calculator parallelCalc = Calculator('ParallelCalc');

  final stopwatch = Stopwatch()..start();

  await Future.wait([
    parallelCalc.displayResult(20, 5, 'add'),
    parallelCalc.displayResult(20, 5, 'subtract'),
    parallelCalc.displayResult(20, 5, 'multiply'),
    parallelCalc.displayResult(20, 5, 'divide'),
  ]);

  stopwatch.stop();
  print(
    '\u{23F1}  Parallel execution took: ${stopwatch.elapsedMilliseconds}ms',
  );
  print('(Much quicker because tasks ran at the same time)');

  // Chain operations demo
  print('\n\u{1F517} Chained Operations Demo');
  final chainCalc = Calculator('ChainCalc');
  final chainResult = await chainCalc.computeChained([10, 5, 2], 'add');
  print('\u{1F9EE} Adding 10, 5, and 2 step by step gives: $chainResult');
}
