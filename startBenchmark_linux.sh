#!/bin/bash

calcReadableTime(){
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
}

runTimes(){
	timeSumPython=0
	timeSumJava=0
	timeSumC=0
	timeSumCybop=0
	
	memPythonSum=0
	memJavaSum=0
	memCSum=0
	memCybopSum=0
	
	for ((z=0;z<$1;z++))
	do
		#echo "ROUND $z"
		#PYTHON
		#time
		timeStart=$(date +%s%N)
        #python /Users/patrick/Documents/projects/CYBOP-Benchmark/python/main.py
		timeEnd=$(date +%s%N)
		timePython=$(($timeEnd-$timeStart))
		
		#memory
        #memPython=$((/usr/bin/time -f%M python python/main.py 1>/dev/null 1>/dev/null) 2>&1)
		
		#Convert time to human readable version
		#calcReadableTime $timePython "Current python time"
		
        #echo "MEM PYTON: $memPython"

		#JAVA
		#time
		#go to the java directory
        #cd java
		timeStart=$(date +%s%N)
		java -cp /Users/patrick/Documents/projects/CYBOP-Benchmark/java/ Main
		timeEnd=$(date +%s%N)
		timeJava=$(($timeEnd-$timeStart))

		#memory
        memJava=$((/usr/bin/time -f%M java -cp /Users/patrick/Documents/projects/CYBOP-Benchmark/java/ Main 1>/dev/null 1>/dev/null) 2>&1)
		#Convert time to human readable version
		#calcReadableTime $timeJava "Current java time"
		
        #echo "MEM JAVA: $memJava"
		
		#C++
		#time
		#go to the c++ directory
		#cd ../c++
		timeStart=$(date +%s%N)
		/Users/patrick/Documents/projects/CYBOP-Benchmark/c++/main
		timeEnd=$(date +%s%N)
		timeCPlusPlus=$(($timeEnd-$timeStart))

		#memory
        memC=$((/usr/bin/time -f%M /Users/patrick/Documents/projects/CYBOP-Benchmark/c++/main 1>/dev/null 1>/dev/null) 2>&1)

		#Convert time to human readable version
		#calcReadableTime $timeCPlusPlus "Current c++ time"
		
        #echo "MEM C++ $memC"
		 
		#CYBOP
		#time
		#go to CYBOP-BENCHMARK directory
        #cd ..
        #timeStart=$(date +%s%N)
        #cyboi cybop/run.cybol
        #timeEnd=$(date +%s%N)
        #timeCybop=$(($timeEnd-$timeStart))
		
		#memory
        #memCybop=$((/usr/bin/time -f%M cyboi cybop/run.cybol 1>/dev/null 1>/dev/null) 2>&1)

		#Convert time to human readable version
        #calcReadableTime $timeCybop "Current cybop time"

        #echo "MEM Cybop $memCybop"
		
		#Add current time to the sum value
		timeSumPython=$(($timeSumPython+$timePython))
		timeSumJava=$(($timeSumJava+$timeJava))
		timeSumC=$(($timeSumC+$timeCPlusPlus))
        #timeSumCybop=$(($timeSumCybop+$timeCybop))
		
		#Add current memory to the sum value
		#memPythonSum=$(($memPythonSum+$memPython))
		memJavaSum=$(($memJavaSum+$memJava))
		memCSum=$(($memCSum+$memC))
        #memCybopSum=$(($memCybopSum+$memCybop))
	done
	avgTimePython=$((timeSumPython/$1))
	avgTimeJava=$((timeSumJava/$1))
	avgTimeC=$((timeSumC/$1))
    avgTimeCybop=$((timeSumCybop/$1))

    avgMemPython=$((memPythonSum/$1))
    avgMemJava=$((memJavaSum/$1))
    avgMemC=$((memCSum/$1))
    avgMemPython=$((memCybopSum/$1))

	
	calcReadableTime $avgTimeJava "JAVA"
	calcReadableTime $avgTimeC "C++"
	calcReadableTime $avgTimePython "PYTHON"
    calcReadableTime $avgTimeCybop "CYBOP"
    echo $avgMemJava
    echo $avgMemC
    echo $avgTimeCybop

}

runTimes 1

