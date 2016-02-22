#!/bin/bash

calcReadableTime() {
  calculatedTime=$1
  sec=$(($calculatedTime/1000000000))
  #echo "sec=$sec"
  remainingNs=$(($calculatedTime-($sec*1000000000)))
  #echo "remaining ns=$remainingNs"
  milli=$(($remainingNs/1000000))
  #echo "milli=$milli"
  remainingNs=$(($remainingNs-($sec*1000000)))
  #echo "remaining ns=$remainingNs"
  micro=$(($remainingNs/1000))
  #echo "micro=$micro"
  remainingNs=$(($remainingNs-($micro*1000)))
  #echo "remaining ns=$remainingNs"
  #echo ""
  #echo "$2: $sec s $milli ms $micro mis $remainingNs ns"
  t=$(bc -l <<< "$1/1000000000")
  #echo "$2: $t"
  echo "$t"
  
  #return "$t"
}

printResult() {
  divider="======================================"
  printf "%20s | %30s | %20s \n" "LANGUAGE" "TIME" "MEMORY"
  printf "%s \n" $divider$divider
  printf "%20s | %30s | %20d \n" "PYTHON" $1 $2
  printf "%20s | %30s | %20d \n" "JAVA" $3 $4
  printf "%20s | %30s | %20d \n" "C++" $5 $6
  printf "%20s | %30s | %20d \n" "CYBOP" $7 $8
}

runTimes() {
  timePythonSum=0
  timeJavaSum=0
  timeCPlusPlusSum=0
  timeCybopSum=0
  
  memPythonSum=0
  memJavaSum=0
  memCPlusPlusSum=0
  memCybopSum=0
  
  for ((z=0;z<$1;z++))
  do
    echo "ROUND " $(($z+1))
    
    #------------#
    #   PYTHON   #
    #------------#
    #time
    timeStart=$(date +%s%N)
    python $HOME/Dokumente/CYBOP-Benchmark/python/main.py
    timeEnd=$(date +%s%N)
    timePython=$(($timeEnd-$timeStart))
    
    #memory
    memPython=$((/usr/bin/time -f%M python $HOME/Dokumente/CYBOP-Benchmark/python/main.py 1>/dev/null 1>/dev/null) 2>&1)
    
    #Convert time to human readable version
    #calcReadableTime $timePython "Current python time"
    #echo "MEM PYTON: $memPython"
    
    #------------#
    #   JAVA     #
    #------------#
    #time
    timeStart=$(date +%s%N)
    java -cp $HOME/Dokumente/CYBOP-Benchmark/java Main
    timeEnd=$(date +%s%N)
    timeJava=$(($timeEnd-$timeStart))
    
    #memory
    memJava=$((/usr/bin/time -f%M java -cp $HOME/Dokumente/CYBOP-Benchmark/java/ Main 1>/dev/null 1>/dev/null) 2>&1)
    
    #Convert time to human readable version
    #calcReadableTime $timeJava "Current java time"
    #echo "MEM JAVA: $memJava"
    
    #------------#
    #     C++    #
    #------------#
    #time
    timeStart=$(date +%s%N)
    $HOME/Dokumente/CYBOP-Benchmark/c++/main
    timeEnd=$(date +%s%N)
    timeCPlusPlus=$(($timeEnd-$timeStart))
    
    #memory
    memCPlusPlus=$((/usr/bin/time -f%M $HOME/Dokumente/CYBOP-Benchmark/c++/main 1>/dev/null 1>/dev/null) 2>&1)
    
    #Convert time to human readable version
    #calcReadableTime $timeCPlusPlus "Current c++ time"
    #echo "MEM C++ $memCPlusPlus"
    
    #------------#
    #   CYBOP    #
    #------------#
    #time
    timeStart=$(date +%s%N)
    cyboi $HOME/Dokumente/CYBOP-Benchmark/cybop/run.cybol
    timeEnd=$(date +%s%N)
    timeCybop=$(($timeEnd-$timeStart))
    
    #memory
    memCybop=$((/usr/bin/time -f%M cyboi $HOME/Dokumente/CYBOP-Benchmark/cybop/run.cybol 1>/dev/null 1>/dev/null) 2>&1)

    #Convert time to human readable version
    #calcReadableTime $timeCybop "Current cybop time"
    #echo "MEM Cybop $memCybop"
    
    #Add current time to the sum value
    timePythonSum=$(($timePythonSum+$timePython))
    timeJavaSum=$(($timeJavaSum+$timeJava))
    timeCPlusPlusSum=$(($timeCPlusPlusSum+$timeCPlusPlus))
    timeCybopSum=$(($timeCybopSum+$timeCybop))
    
    #Add current memory to the sum value
    memPythonSum=$(($memPythonSum+$memPython))
    memJavaSum=$(($memJavaSum+$memJava))
    memCPlusPlusSum=$(($memCPlusPlusSum+$memCPlusPlus))
    memCybopSum=$(($memCybopSum+$memCybop))
  
  done
  
  #---------------#
  #   AVG TIME    #
  #---------------#
  avgTimePython=$((timePythonSum/$1))
  avgTimeJava=$((timeJavaSum/$1))
  avgTimeCPlusPlus=$((timeCPlusPlusSum/$1))
  avgTimeCybop=$((timeCybopSum/$1))
  
  #---------------#
  #   AVG MEM     #
  #---------------#
  avgMemPython=$((memPythonSum/$1))
  avgMemJava=$((memJavaSum/$1))
  avgMemCPlusPlus=$((memCPlusPlusSum/$1))
  avgMemCybop=$((memCybopSum/$1))
  
  #-------------------#
  #   READABLE TIME   #
  #-------------------#
  readableTimePython=$(calcReadableTime $avgTimePython)
  readableTimeJava=$(calcReadableTime $avgTimeJava)
  readableTimeCPlusPlus=$(calcReadableTime $avgTimeCPlusPlus)
  readableTimeCybop=$(calcReadableTime $avgTimeCybop)
  
  #---------------#
  #   OUTPUT      #
  #---------------#
  printResult $readableTimePython $avgMemPython \
              $readableTimeJava $avgMemJava \
              $readableTimeCPlusPlus $avgMemCPlusPlus \
              $readableTimeCybop $avgMemCybop
}

runTimes 1
