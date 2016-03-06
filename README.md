# CYBOP-Benchmark

Simple benchmark to compare CYBOL with other programming languages.

## **Pseudocode**
-----------------

```
loop from 0 to x:
  var test;
  test = Addition
  test = Substraction
  test = Division
  test = Multiplication
  Absolute value of test
  innerLoop();
end loop
  
innerLoop():
  outerResult = 0
  loop from 0 to y:
    i++;
    if(i % 2 == 0):
      innerResultCounter++
  
  outerResult += innerResultCounter
end loop
```

## Prerequisites

- Installed CYBOI (Interpreter)
- Appropriately adjust the paths of the runner script to fit your environment:
  - programpath: The absolute path of the CYBOP-Benchmark directory
  - scriptpath:  The absolut path of the start-benchmark.sh script
  - runtimes:    The number of loops the benchmark will execute the particular programms

## **How to run**
-----------------

- navigate to CYBOB-Benchmark directory
- run ./runner.sh loops
- press start button of the GUI
- Wait for the results

_!Results are average values of all loops_

## **Source Code**
------------------

- [Cybop-Benchmark](https://github.com/hetec/CYBOP-Benchmark)
- [Cybop-Benchmark-Viewer](https://github.com/hetec/CybopBenchmarkViewer)
