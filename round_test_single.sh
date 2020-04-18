#!/bin/bash

echo -e "Please select a model to run single image classification.\n"
echo -e "Option: resnet50 and googlenet_v1."

read -p "The model you want to test: " model
read -p "Please input the path of log file: " logpath 

echo -e "Using ${model} doing round test job."
for i in {1..5..1}; 
do
	start_1=$SECONDS
	./run.sh -t test_classify ${model} | cat >>  ${logpath}/log.txt
	duration_1=$(( SECONDS - start_1))
	echo $duration_1  >> ${logpath}/timer_per_each_test$a.txt
	echo -e "Duration: ${duration_1}s"
done
echo "Log file has been sent to ${logpath}/"
echo -e "Finish! \a"
