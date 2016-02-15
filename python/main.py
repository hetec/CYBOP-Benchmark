import os

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
    inner = 0
    while start < end:
        start = start + 1;
        inner = printEachSecondValue(start, inner)

    return inner
        
def printEachSecondValue(value, inner):
    if value % 2 == 0:
        inner += 1
    return inner

counter = 0
limit = 10000
result = 0
while counter < limit:
    test = division(limit, 3)
    test = addition(test, test)
    test = substraction(test, limit)
    test = absolute(test)
    test = multiplication(test,test)
    result += loop(0, 10000)
    counter = counter + 1
    
print "Result python: " + str(result) + os.linesep
    
    
