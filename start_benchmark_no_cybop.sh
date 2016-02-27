#!/bin/bash

localPath=$1

calcReadableTime() {
  calculatedTime=$1
  sec=$(($calculatedTime/1000000000))
  remainingNs=$(($calculatedTime-($sec*1000000000)))
  milli=$(($remainingNs/1000000))
  remainingNs=$(($remainingNs-($sec*1000000)))
  micro=$(($remainingNs/1000))
  remainingNs=$(($remainingNs-($micro*1000)))
  #echo "$2: $sec s $milli ms $micro mis $remainingNs ns"
  t=$(bc -l <<< "$1/1000000000")
  #echo "$2: $t"
  echo "$t"
}

printResultForViewer() {
  echo $1
  echo $2
  echo $3
  echo $4
  echo $5
  echo $6
  echo $7
  echo $8
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
  
  case "$OSTYPE" in
    solaris*) user_os="SOLARIS" ;;
    darwin*)  user_os="OSX" ;; 
    linux*)   user_os="LINUX" ;;
    bsd*)     user_os="BSD" ;;
    *)        user_os="unknown: $OSTYPE" ;;
  esac
  
  timePythonSum=0
  timeJavaSum=0
  timeCPlusPlusSum=0
  
  memPythonSum=0
  memJavaSum=0
  memCPlusPlusSum=0
  
  for ((z=0;z<$1;z++))
  do
    echo "ROUND " $(($z+1))
    
    #------------#
    #   PYTHON   #
    #------------#
    #time
    if [ $user_os == "LINUX" ]
    then
      timeStart=$(date +%s%N)
      python $localPath/python/main.py
      timeEnd=$(date +%s%N)
      timePython=$(($timeEnd-$timeStart))
    elif [ $user_os == "OSX" ]
    then
      timeStart=$(gdate +%s%N)
      python $localPath/python/main.py
      timeEnd=$(gdate +%s%N)
      timePython=$(($timeEnd-$timeStart))
    else
      echo "ToDo: PYTHON - Time - Add more OS Types"
    fi
      
    #memory
    if [ $user_os == "LINUX" ]
    then
      memPython=$((/usr/bin/time -f%M python $localPath/python/main.py 1>/dev/null 1>/dev/null) 2>&1)
    elif [ $user_os == "OSX" ]
    then
      memPython=$((gtime -f%M python $localPath/python/main.py 1>/dev/null 1>/dev/null) 2>&1)
    else
      echo "ToDo: PYTHON - Memory - Add more OS Types"
    fi
    
    
    #------------#
    #   JAVA     #
    #------------#
    #time
    if [ $user_os == "LINUX" ]
    then
      timeStart=$(date +%s%N)
      java -cp $localPath/java Main
      timeEnd=$(date +%s%N)
      timeJava=$(($timeEnd-$timeStart))
    elif [ $user_os == "OSX" ]
    then
      timeStart=$(gdate +%s%N)
      java -cp $localPath/java Main
      timeEnd=$(gdate +%s%N)
      timeJava=$(($timeEnd-$timeStart))
    else
      echo "ToDo: JAVA - Time - Add more OS Types"
    fi
    
    #memory
    if [ $user_os == "LINUX" ]
    then
      memJava=$((/usr/bin/time -f%M java -cp $localPath/java/ Main 1>/dev/null 1>/dev/null) 2>&1)
    elif [ $user_os == "OSX" ]
    then
      memJava=$((gtime -f%M java -cp $localPath/java/ Main 1>/dev/null 1>/dev/null) 2>&1)
    else
      echo "ToDo: JAVA - Memory - Add more OS Types"
    fi
    
    
    #------------#
    #     C++    #
    #------------#
    #time
    if [ $user_os == "LINUX" ]
    then
      timeStart=$(date +%s%N)
      $localPath/c++/main
      timeEnd=$(date +%s%N)
      timeCPlusPlus=$(($timeEnd-$timeStart))
    elif [ $user_os == "OSX" ]
    then
      timeStart=$(gdate +%s%N)
      $localPath/c++/main
      timeEnd=$(gdate +%s%N)
      timeCPlusPlus=$(($timeEnd-$timeStart))
    else
      echo "ToDo: C++ - Time - Add more OS Types"
    fi
      
    #memory
    if [ $user_os == "LINUX" ]
    then
      memCPlusPlus=$((/usr/bin/time -f%M $localPath/c++/main 1>/dev/null 1>/dev/null) 2>&1)
    elif [ $user_os == "OSX" ]
    then
      memCPlusPlus=$((gtime -f%M $localPath/c++/main 1>/dev/null 1>/dev/null) 2>&1)
    else
      echo "ToDo: C++ - Memory - Add more OS Types"
    fi
       
    
    #Add current time to the sum value
    timePythonSum=$(($timePythonSum+$timePython))
    timeJavaSum=$(($timeJavaSum+$timeJava))
    timeCPlusPlusSum=$(($timeCPlusPlusSum+$timeCPlusPlus))
    
    #Add current memory to the sum value
    memPythonSum=$(($memPythonSum+$memPython))
    memJavaSum=$(($memJavaSum+$memJava))
    memCPlusPlusSum=$(($memCPlusPlusSum+$memCPlusPlus))
  
  done
  
  #---------------#
  #   AVG TIME    #
  #---------------#
  avgTimePython=$((timePythonSum/$1))
  avgTimeJava=$((timeJavaSum/$1))
  avgTimeCPlusPlus=$((timeCPlusPlusSum/$1))
  
  #---------------#
  #   AVG MEM     #
  #---------------#
  avgMemPython=$((memPythonSum/$1))
  avgMemJava=$((memJavaSum/$1))
  avgMemCPlusPlus=$((memCPlusPlusSum/$1))
  
  #-------------------#
  #   READABLE TIME   #
  #-------------------#
  readableTimePython=$(calcReadableTime $avgTimePython)
  readableTimeJava=$(calcReadableTime $avgTimeJava)
  readableTimeCPlusPlus=$(calcReadableTime $avgTimeCPlusPlus)
  
  #---------------#
  #   OUTPUT      #
  #---------------#
  printResultForViewer $readableTimePython $readableTimeJava \
		       $readableTimeCPlusPlus -1 \
		       $avgMemPython $avgMemJava \
		       $avgMemCPlusPlus -1

  printResult $readableTimePython $avgMemPython \
              $readableTimeJava $avgMemJava \
              $readableTimeCPlusPlus $avgMemCPlusPlus \
              -1 -1
}

runTimes $2
