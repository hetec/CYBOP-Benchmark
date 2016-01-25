class Main {
  
  
  private static long addition(long a, long b) {
    return a + b;
  }

  private static long substraction(long a, long b) {
    return a - b;
  }

  private static long multiply(long a, long b) {
    return a * b;
  }

  private static double division(double a, double b) {
    return b == 0.0 ? 0.0 : a / b;
  }

  private static long absolute(long a) {
    return a < 0 ? (a * -1) : a;  
  }

  private static void printValue(long value) {
    if (value % 2 == 0) {
      System.out.println("Value i = " + value);
    }
  }

  private static void innerLoop(long counter, long limit) {
    while (counter <= limit) {
      counter++; 
      printValue(counter);
    }
  }


  public static void main(String[] args) {
    
    long test;
    long counter = 0;
    long limit = 10000;

    while (counter <= limit) {
      
      test = (long) division(limit, 3);
      test = addition(test, test);
      test = substraction(test, limit);
      test = absolute(test);
      test = multiply(test, test);
      
      innerLoop(0, 1000);
      
      counter++;
  
    }
  }
  
}