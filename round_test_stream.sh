#!/bin/bash

if [ "${1}" == "1" ]; then 
cond=Switch_batch_size

	if [ "${2}" == "1" ]; then
		mode1=streaming_classify
	elif [ "${2}" == "2" ]; then
		mode1=streaming_classify_fpgaonly
	else 
		echo "Please select a mode to run. (1 = streaming_classify, 2 = streaming_classify_fpgaonly)"
	fi

	if [ "${3}" == "1" ]; then
		mode2=autoAllOpt
	elif [ "${3}" == "2" ]; then 
		mode2=throughput
	elif [ "${3}" == "3" ]; then
		mode2=latency
	else 
		echo "Please select a mode to test.(1 = autoAllOpt, 2 = throughput, 3 = latency )"
	fi

	for a in {1..5..1};
	do 

		start=$SECONDS
		for i in {1..16..1};
		do
			NUM=$[1 * $i]
			./run.sh -t $mode1 -m resnet50 -s $NUM  -c $mode2 -d $HOME/CK-TOOLS/dataset-imagenet-ilsvrc2012-val-min | cat >> FNAL-Alveo-FPGA/$cond/$mode1/UCSD/$mode2/log$a.txt 
		done

		duration=$(( SECONDS - start ))
		echo $duration  >> FNAL-Alveo-FPGA/$cond/$mode1/UCSD/$mode2/timer$a.txt

		echo $duration
	done

elif [ "${1}" == "2" ]; then
	cond=Switch_num_of_stream

	if [ "${2}" == "1" ]; then
		mode1=streaming_classify
	elif [ "${2}" == "2" ]; then
		mode1=streaming_classify_fpgaonly
	else
		echo "Please select a mode to run. (1 = streaming_classify, 2 = streaming_classify_fpgaonly)"
	fi

	if [ "${3}" == "1" ]; then
		mode2=autoAllOpt
	elif [ "${3}" == "2" ]; then
		mode2=throughput
	elif [ "${3}" == "3" ]; then
		mode2=latency
	else
                echo "Please select a mode to test.(1 = autoAllOpt, 2 = throughput, 3 = latency )"
	fi

	for a in {1..5..1};
	do

		start=$SECONDS
		for i in {1..5};
		do
			NUM=$[4 * $i]
			./run.sh -t $mode1 -m resnet50 -ns $NUM  -c $mode2 -d $HOME/CK-TOOLS/dataset-imagenet-ilsvrc2012-val-min | cat >> FNAL-Alveo-FPGA/$cond/$mode1/UCSD/$mode2/log$a.txt
		done

		duration=$(( SECONDS - start ))
		echo $duration  >> FNAL-Alveo-FPGA/$cond/$mode1/UCSD/$mode2/timer$a.txt

		echo $duration
	done

elif [ "${1}" == "3"]; then
	cond=Switch_num_of_preprocess_process

        if [ "${2}" == "1" ]; then
                mode1=streaming_classify
        elif [ "${2}" == "2" ]; then
                mode1=streaming_classify_fpgaonly
        else
                echo "Please select a mode to run. (1 = streaming_classify, 2 = streaming_classify_fpgaonly)"
        fi

        if [ "${3}" == "1" ]; then
                mode2=autoAllOpt
        elif [ "${3}" == "2" ]; then
                mode2=throughput
        elif [ "${3}" == "3" ]; then
                mode2=latency
        else
                echo "Please select a mode to test.(1 = autoAllOpt, 2 = throughput, 3 = latency )"
        fi

        for a in {1..5..1};
        do

                start=$SECONDS
                for i in {1..5};
                do
                        NUM=$[4 * $i]
                        ./run.sh -t $mode1 -m resnet50 -y $NUM  -c $mode2 -d $HOME/CK-TOOLS/dataset-imagenet-ilsvrc2012-val-min | cat >> FNAL-Alveo-FPGA/$cond/$mode1/UCSD/$mode2/log$a.txt
                done

                duration=$(( SECONDS - start ))
                echo $duration  >> FNAL-Alveo-FPGA/$cond/$mode1/UCSD/$mode2/timer$a.txt

                echo $duration
        done

else
echo "Please select a condition to run. (1 = Switch_batch_size, 2 = Switch_num_of_stream, 3= Switch_num_of_preprocess_process.)"
fi

