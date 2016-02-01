#include <iostream>

using namespace std;


long addition(long a, long b) {
  return a + b;
}

long substraction(long a, long b) {
  return a - b;
}

long multiply(long a, long b) {
  return a * b;
}

double division(double a, double b) {
  return b == 0.0 ? 0.0 : a / b;
}

long absolute(long a) {
  return a < 0 ? (a * -1) : a;  
}

void printValue(long value) {
  if (value % 2 == 0) {
    cout << "Value i = " << value << endl;
  }
}

void innerLoop(long counter, long limit) {
  while (counter <= limit) {
    counter++; 
    printValue(counter);
  }
}


int main() {
  
  long test;
  long counter = 0;
  long limit = 10000;

  while (counter <= limit) {
    
    test = division(limit, 3);
    test = addition(test, test);
    test = substraction(test, limit);
    test = absolute(test);
    test = multiply(test, test);
    
    innerLoop(0, 10000);
    
    counter++;
    
  }
  
  return 0;
}
