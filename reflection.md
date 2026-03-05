# Reflection: Dart Fundamentals Assignment

This document contains my reflections on completing Tasks 1 and 2 of the 
Dart Fundamentals assignment. I've answered each conceptual question based 
on my experience implementing the code and understanding of Dart concepts.

## Task 1 – Number Analysis App (Q1–Q5)

## Q1.What is the difference between a List<int> and a List<dynamic> in Dart? Why is it usually better to use a typed list like List<int>?

A `List<int>` means the list can only store integers. 
In my code, I declared:
```dart
final List<int> numbers = [34, -7, 89, 12, -45, 67, 3, 100, -2, 55];
```
If I tried to add a string like `numbers.add('hello')`, Dart would give a compile error immediately. This caught my attention because in some languages these errors only appear when the program runs.

On the other hand, a `List<dynamic>` can store values of any type, such as integers, strings, booleans, or objects. While this is more flexible, it also makes the code less safe because type errors might only appear at runtime.

In most cases it is better to use a typed list like `List<int>` because it clearly shows what type of data the list should contain and helps avoid accidental bugs.

## Q2.  In your findMax() function, why is it important to initialize your 'running maximum' variable to the first element of the list rather than to 0 or to a very small number? What could go wrong with the other approaches?


In my `findMax()` function, I start the `max` variable with the first element of the list:
```dart
int max = numbers[0];  // Starting with actual list element

for (int i = 1; i < numbers.length; i++) {
  if (numbers[i] > max) {
    max = numbers[i];
  }
}
```
 This works because that value is guaranteed to actually exist in the list and it gives a valid starting point for comparisons.

If I started with `0`, it could give wrong results when all the numbers are negative. For example, if the list was `[-5, -10, -2]`, the function would incorrectly return `0`, even though `0` is not in the list.

Using a very small number could also work sometimes, but it's not a good idea because we don't always know what values might appear in the list. Starting with the first element avoids these problems and makes the logic simpler.

## Q3. Your calculateAverage() function calls calculateSum() internally. What software design principle does this demonstrate, and why is reusing existing functions preferable to duplicating code?

In my code, the `calculateAverage()` function calls `calculateSum()` instead of calculating the sum again.
Here's exactly how it looks in my code:

```dart
int calculateSum(List<int> numbers) {
  int sum = 0;
  for (int number in numbers) {
    sum += number;
  }
  return sum;
}

double calculateAverage(List<int> numbers) {
  int sum = calculateSum(numbers);  // Reusing the function
  return sum / numbers.length;
}
```
Instead of repeating the same logic in multiple places, I wrote one function to calculate the sum and reused it when calculating the average. This makes the program easier to maintain because if the sum logic ever needs to change, it only needs to be updated in one place.

Reusing functions also keeps the code cleaner and avoids duplication, which is generally considered good programming practice.

## Q4.  Describe in plain English what the for-in loop syntax does in Dart. How is it different from a traditional for loop with an index? When would you prefer one over the other?

A for-in loop goes through each element in a collection, like a list, one by one. Instead of using an index, it directly gives you the value of each item in the list.

In my `calculateSum()` function, I used a for-in loop because I only needed the values:
```dart
for (int number in numbers) {
  sum += number;  // Clean and direct - just adding each value
}
```
A traditional for loop uses an index to access elements. In my `findMax()` function, I needed the index position to start from the second element:

```dart
for (int i = 0; i < numbers.length; i++) {
  if (numbers[i] > max) {  // Need index to compare with stored max
    max = numbers[i];
  }
}
```
I would usually use a for-in loop when I only need the values in the list.
I would use a regular for loop when I need the index position or when I want more control over how the loop runs.

## Q5.If someone calls your findMax() function with an empty list, what happens? How could you modify the function to handle that case safely?
 
```markdown
In my `findMax()` function, I added a check at the beginning:
```dart
if (numbers.isEmpty) { 
  throw ArgumentError('List cannot be empty');  // 🛡️ Safety guard
}
 ```
 If someone calls the function with an empty list, the program throws an error and stops that operation. This prevents the code from trying to access `numbers[0]`, which would cause a crash.

 Another way to handle this safely would be to return null or provide a default value instead of throwing an error. For example, the function could return null and let the caller decide how to handle it. However, throwing an error is useful because it clearly signals that the function was used incorrectly.

```markdown
##  Bonus Features I Implemented

My Task 1 solution also includes these bonus features:

### 1. Count Negatives Function
```dart
int countNegatives(List<int> numbers) {
  int count = 0;
  for (int number in numbers) {
    if (number < 0) count++;
  }
  return count;
}
```
This counts how many numbers in the list are negative.

## 2. Sorting Without .sort()

```dart
List<int> sortList(List<int> numbers) {
  List<int> sorted = List.from(numbers);
  // Bubble sort implementation
  for (int i = 0; i < n - 1; i++) {
    for (int j = 0; j < n - i - 1; j++) {
      if (sorted[j] > sorted[j + 1]) {
        // Swap elements
      }
    }
  }
  return sorted;
}
```
## 3. Collection Methods Comparison
I also wrote versions using Dart's built-in methods:

`reduce()`for max/min

`fold()` for sum

`where()` for counting negatives

This helped me understand the trade-offs: manual loops are more explicit, while collection methods are shorter once you're familiar with them.

## Task 2 – Async Calculator App (Q6–Q10)

 ## Q6.What is the difference between a synchronous function and an asynchronous function in Dart? In your Calculator class, why is divide() synchronous while computeAsync() is asynchronous?

Synchronous functions run right away and block other code until they finish. Asynchronous functions, on the other hand, return a Future and allow the program to keep running while waiting for the operation to finish.

In My Calculator class:

`divide()` is synchronous because dividing two numbers is immediate and doesn’t involve waiting.

`computeAsync()` is asynchronous because it simulates a delay using `Future.delayed()`. This allows the program to stay responsive during that pause, just like it would if it were waiting for a slow network or database operation.

 ## Q7.Explain the purpose of the await keyword in Dart. What happens if you forget to use await when calling an async function that returns a Future? What does your program print instead of the result?

 The `await` keyword tells Dart to pause the current function until the Future completes and gives a result.

If you forget `await` when calling an async function, the function returns a `Future` object immediately, not the actual result. For example:
```dart
final result = calc.computeAsync(10, 4, 'add');
print(result); // Without await, prints: Instance of 'Future<double>'
```
So without `await`,my program would print the Future object instead of the actual number.

## Q8. What is the purpose of the try-catch block in your displayResult() method? What would happen if you removed it and then called displayResult(10, 0, 'divide')?

The try-catch block catches errors gracefully so the program doesn’t crash.

For example, if you call `displayResult(10, 0, 'divide')`:

`divide()throws` an `ArgumentError` for dividing by zero.

The `try-catch` captures it and prints a friendly message like:

```dart
⚠ Oops! Cannot divide by zero. That’s a no-go!
```
If we removed `try-catch`, the program would crash immediately with a red error, and the user wouldn’t get a clear message.
When I first tested my divide function without try-catch, the program crashed with a red error in DartPad. This really helped me understand why exception handling is crucial in real applications where users might inputinvalid data.

## Q9. Why is it good design to have divide() throw an ArgumentError rather than simply returning 0 or printing an error inside the divide() method itself? What principle of function design does this reflect?

Throwing an error keeps the function focused on its single job: performing division. It doesn’t decide how to handle problems.

This follows the Single Responsibility Principle: a function should either compute a result or handle errors, not both. By throwing an error, we let the calling function `(displayResult())` decide how to respond—print a message, log it, or show a UI alert. This makes the code more flexible and reusable.

## Q10.. What does the async keyword on main() allow you to do? Could this assignment have been written without making main() async? Explain your answer.
 
Marking `main()` as `async` allows us to use await inside it. This ensures that all asynchronous calculations complete before the program moves on.

Without `async` and `await`:

The program could start operations but finish before results are printed.

You would have to use `.then()` callbacks for every async call, which makes the code harder to read and maintain.

So, marking `main()` as `async` allows the program to appear to run synchronously (in order) while still properly handling the asynchronous nature of the operations. This makes the code much cleaner and easier to understand than using nested callbacks.


## Final Reflection

This assignment helped me better understand several core Dart concepts such as typed collections, iteration, error handling, and asynchronous programming with Future and async/await.

Implementing the algorithms manually (like finding the maximum value and sorting without built-in methods) helped reinforce how these operations work internally.

The async calculator task was especially useful because it showed how Dart handles operations that take time, and how await helps keep code readable while working with asynchronous results.