// Task 1: Number Analysis Program

/*
 * Entry point of the program.
 * Runs different number analysis functions and prints the results.
 */
void main() {

  // Example list of integers (includes positive and negative values)
  final List<int> numbers = [34, -7, 89, 12, -45, 67, 3, 100, -2, 55];

  print('Number Analysis Results');
  print('========================');
  print('Numbers: $numbers\n');

  try {

    // Run the analysis functions
    int maxValue = findMax(numbers);
    int minValue = findMin(numbers);
    int sumValue = calculateSum(numbers);
    double averageValue = calculateAverage(numbers);

    // Show the results
    print('Maximum value : $maxValue');
    print('Minimum value : $minValue');
    print('Sum           : $sumValue');
    print('Average       : $averageValue');

  } catch (e) {
    // In case something goes wrong (like an empty list)
    print('Error: $e');
  }

  // ---------- Extra features ----------

  print('\n--- Bonus Features ---');

  // Count how many numbers are negative
  int negativeCount = countNegatives(numbers);
  print('Count of negative numbers: $negativeCount');

  // Sort the list
  List<int> sortedNumbers = sortList(numbers);
  print('Sorted list (ascending): $sortedNumbers');

  // ---------- Using Dart collection methods ----------

  print('\n--- Collection Methods Comparison ---');

  try {

    int maxCollection = findMaxWithCollection(numbers);
    int minCollection = findMinWithCollection(numbers);
    int sumCollection = calculateSumWithCollection(numbers);
    double averageCollection = calculateAverageWithCollection(numbers);
    int negativeCountCollection = countNegativesWithCollection(numbers);
    List<int> sortedCollection = sortListWithCollection(numbers);

    print('Maximum (collection) : $maxCollection');
    print('Minimum (collection) : $minCollection');
    print('Sum (collection)     : $sumCollection');
    print('Average (collection) : $averageCollection');
    print('Negative count (collection): $negativeCountCollection');
    print('Sorted (collection)  : $sortedCollection');

    print('\nNotes:');
    print('Manual loops are easier to understand step-by-step.');
    print('Collection methods are shorter and cleaner once you get used to them.');

  } catch (e) {
    print('Error in collection methods: $e');
  }
}


// ---------- Manual implementations ----------

/*
 * Finds the largest number in the list.
 */
int findMax(List<int> numbers) {

  if (numbers.isEmpty) {
    throw ArgumentError('List cannot be empty');
  }

  int max = numbers[0];

  // Check the rest of the numbers
  for (int i = 1; i < numbers.length; i++) {
    if (numbers[i] > max) {
      max = numbers[i];
    }
  }

  return max;
}


/*
 * Finds the smallest number in the list.
 */
int findMin(List<int> numbers) {

  if (numbers.isEmpty) {
    throw ArgumentError('List cannot be empty');
  }

  int min = numbers[0];

  // Compare each number to find the smallest
  for (int i = 1; i < numbers.length; i++) {
    if (numbers[i] < min) {
      min = numbers[i];
    }
  }

  return min;
}


/*
 * Adds all numbers in the list.
 */
int calculateSum(List<int> numbers) {

  if (numbers.isEmpty) {
    throw ArgumentError('List cannot be empty');
  }

  int sum = 0;

  // Add each number to the total
  for (int number in numbers) {
    sum += number;
  }

  return sum;
}


/*
 * Calculates the average value.
 */
double calculateAverage(List<int> numbers) {

  if (numbers.isEmpty) {
    throw ArgumentError('List cannot be empty');
  }

  int sum = calculateSum(numbers);

  return sum / numbers.length;
}


/*
 * Counts how many values are negative.
 */
int countNegatives(List<int> numbers) {

  int count = 0;

  for (int number in numbers) {
    if (number < 0) {
      count++;
    }
  }

  return count;
}


/*
 * Sorts the list using bubble sort.
 * A copy is used so the original list stays unchanged.
 */
List<int> sortList(List<int> numbers) {

  List<int> sorted = List.from(numbers);

  int n = sorted.length;

  for (int i = 0; i < n - 1; i++) {
    for (int j = 0; j < n - i - 1; j++) {

      if (sorted[j] > sorted[j + 1]) {

        int temp = sorted[j];
        sorted[j] = sorted[j + 1];
        sorted[j + 1] = temp;

      }
    }
  }

  return sorted;
}


// ---------- Collection method versions ----------

int findMaxWithCollection(List<int> numbers) {

  if (numbers.isEmpty) {
    throw ArgumentError('List cannot be empty');
  }

  return numbers.reduce((current, next) => current > next ? current : next);
}


int findMinWithCollection(List<int> numbers) {

  if (numbers.isEmpty) {
    throw ArgumentError('List cannot be empty');
  }

  return numbers.reduce((current, next) => current < next ? current : next);
}


int calculateSumWithCollection(List<int> numbers) {

  if (numbers.isEmpty) {
    throw ArgumentError('List cannot be empty');
  }

  return numbers.fold(0, (sum, number) => sum + number);
}


double calculateAverageWithCollection(List<int> numbers) {

  if (numbers.isEmpty) {
    throw ArgumentError('List cannot be empty');
  }

  int sum = calculateSumWithCollection(numbers);

  return sum / numbers.length;
}


int countNegativesWithCollection(List<int> numbers) {

  return numbers.where((number) => number < 0).length;
}


List<int> sortListWithCollection(List<int> numbers) {

  // Create a copy first so we don't change the original list
  List<int> sorted = List.from(numbers);

  sorted.sort();

  return sorted;
}