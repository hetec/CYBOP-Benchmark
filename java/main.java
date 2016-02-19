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

  private static long printValue(long value, long inner) {
    if (value % 2 == 0) {
      inner++;
    }
    return inner;
  }

  private static long innerLoop(long counter, long limit) {
    long inner = 0;
    while (counter < limit) {
      counter++; 
      inner = printValue(counter, inner);
    }
    return inner;
  }


  public static void main(String[] args) {
    
    long test;
    long counter = 0;
    long limit = 10000;
    long result = 0;
    while (counter < limit) {
      
      test = (long) division(limit, 3);
      test = addition(test, test);
      test = substraction(test, limit);
      test = absolute(test);
      test = multiply(test, test);
      
      result += innerLoop(0, 10000);
      counter++;
    }

    //System.out.println("Result java: " + result);
  }
  
}