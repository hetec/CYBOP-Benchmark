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
	echo ""
	echo "$2: $sec s $milli ms $micro mis $remainingNs ns"
	t=$(bc -l <<< "$1/1000000000")
	echo "$2: $t"
	echo ""
}

runTimes(){
	timeSumPython=0
	timeSumJava=0
	timeSumC=0
	timeSumCybop=0
	for ((z=0;z<10;z++))
	do
		echo "ROUND $z"

	    # call python script
		timeStart=$(gdate +%s%N)
		python python/main.py
		timeEnd=$(gdate +%s%N)
		timePython=$(($timeEnd-$timeStart))

		calcReadableTime $timePython "Current python time"

		cd java
		timeStart=$(gdate +%s%N)
		java Main
		timeEnd=$(gdate +%s%N)
		timeJava=$(($timeEnd-$timeStart))

		calcReadableTime $timeJava "Current java time"

		cd ../c++
		timeStart=$(gdate +%s%N)
		./main
		timeEnd=$(gdate +%s%N)
		timeCPlusPlus=$(($timeEnd-$timeStart))

		calcReadableTime $timeCPlusPlus "Current c++ time"

		cd ..
		timeStart=$(gdate +%s%N)
		cyboi cybop/run.cybol
		timeEnd=$(gdate +%s%N)
		timeCybop=$(($timeEnd-$timeStart))


		timeSumPython=$(($timeSumPython+timePython))
		timeSumJava=$(($timeSumJava+timeJava))
		timeSumC=$(($timeSumC+timeCPlusPlus))
		timeSumCybop=$(($timeSumCybop+timeCybop))
	done
	avgTimePython=$((timeSumPython/$1))
	avgTimeJava=$((timeSumJava/$1))
	avgTimeC=$((timeSumC/$1))
	avgTimeCybop=$((timeSumCybop/$1))

	calcReadableTime $avgTimePython "PYTHON"
	calcReadableTime $avgTimeJava "JAVA"
	calcReadableTime $avgTimeC "C++"
	calcReadableTime $avgTimeCybop "CYBOP"

}

runTenTimes 5

