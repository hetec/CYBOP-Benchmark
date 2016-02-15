#include <iostream>

using namespace std;


long addition(long a, long b) {
  return (a + b);
}

long substraction(long a, double b) {
  return (a - b);
}

long multiply(long a, long b) {
  return (a * b);
}

double division(double a, double b) {
  return (b == 0.0 ? 0.0 : (a) / b);
}

long absolute(long a) {
  return a < 0 ? (a * -1) : a;
}

long printValue(long value, long inner) {
  if (value % 2 == 0) {
    (inner)++;
  }
  return inner;
}

long innerLoop(long counter, long limit) {
  long inner = 0;
  while (counter < limit) {
    counter++; 
    inner = printValue(counter, inner);
  }
  return inner;
}


int main() {
  long test;
  long counter = 0;
  double limit = 10000;
  long result = 0;
  while (counter < limit) {
    
    test = division(limit, 3);
    test = addition(test, test);
    test = substraction(test, limit);
    test = absolute(test);
    test = multiply(test, test);
    
    result += innerLoop(0, 10000);
    
    counter++;
    
  }
  
  cout << "Result c++: " << result << endl;

  return 0;
}
