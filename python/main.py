def addition(num1, num2):
    return num1 + num2
    
def substraction(num1, num2):
    return num1 - num2
    
def multiplication(num1, num2):
    return num1 * num2
    
def division(num1, num2):
    return 0 if (num2 == 0) else (num1 / num2)
    
def absolute(num):
    return num if num > 0 else num * -1
    
def loop(start, end):
    while start < end:
        start = start + 1;
        printEachSecondValue(start)
        
def printEachSecondValue(value):
    if value % 2 == 0:
        print "Value i = " + str(value) 

counter = 0
limit = 10000
while counter < limit:
    test = division(limit, 3)
    test = addition(test, test)
    test = substraction(test, limit)
    test = absolute(test)
    test = multiplication(test,test)
    loop(0, 1000)
    counter = counter + 1
    
    
    