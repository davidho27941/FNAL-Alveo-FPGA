#!/bin/bash

read -p "Please input the main path you want to save: " logpath

if [ -d "${logpath}" ]; then 
	echo "Directory ${logpath} exists."
else
    echo "Directory ${logpath} does not exists."
    mkdir ${logpath}
    echo "Directory ${logpath} has been created!"
fi

if [ "${1}" == "1" ]; then 
	cond=Switch_batch_size
	if [ -d "${logpath}/${cond}" ]; then 
		echo -e "File ${logpath}/${cond} exist." 
	else
		mkdir ${logpath}/${cond}
		echo -e "File ${logpath}/${cond} has been created."
	fi

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
	
	if [ -d "${logpath}/${cond}/${mode1}" ]; then 
	
		echo "File {logpath}/${cond}/${mode1} exist."
	else 
		mkdir ${logpath}/${cond}/${mode1}
		echo "File ${logpath}/${cond}/${mode1} has been created."
	fi	
	
	if [ -d "${logpath}/${cond}/${mode1}/${mode2}" ]; then
		echo "File ${logpath}/${cond}/${mode1}/${mode2} exist."
	else	
		mkdir ${logpath}/${cond}/${mode1}/${mode2}
		echo "File ${logpath}/${cond}/${mode1}/${mode2} has been created."
	fi
	
	echo -e "+----------------------------------------------------------------+"
	echo -e "Test start: Testing deployment modes with ${mode1} and ${mode2}"

	for a in {1..5..1};
	do 
		echo -e "+----------------------------------------------------------------+"
		echo "Round $a start."
		start=$SECONDS
		for i in {2..8..2};
		do
			NUM=$[2 * $i]
			start_1=$SECONDS
			./run.sh -t $mode1 -m resnet50 -s $NUM -ns 1 -y 1 -c $mode2 -d $HOME/CK-TOOLS/dataset-imagenet-ilsvrc2012-val-min | cat >> ${logpath}/${cond}/${mode1}/${mode2}/log$a.txt 
			duration_1=$(( SECONDS - start_1 ))
			echo $duration_1  >> ${logpath}/${cond}/${mode1}/${mode2}/timer_per_each_test$a.txt
			echo "Druation: ${duration_1}s"
		done

		duration=$(( SECONDS - start ))
		echo $duration  >> ${logpath}/${cond}/${mode1}/${mode2}/timer_per_each_round_$a.txt
		echo "Round Duration: ${duration}s"
		echo -e "+----------------------------------------------------------------+"
	done
	echo "Finish! Log file has been sent to ${logpath}/${cond}/${mode1}/${mode2}."

elif [ "${1}" == "2" ]; then
	cond=Switch_num_of_stream
	if [ -d "${logpath}/${cond}" ]; then
                echo -e "File ${logpath}/${cond} exist." 
        else
                mkdir ${logpath}/${cond}
                echo -e "File ${logpath}/${cond} has been created."
        fi

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

	if [ -d "${logpath}/${cond}/${mode1}" ]; then
                echo "File ${logpath}/${cond}/${mode1} exist."
        else
                mkdir ${logpath}/${cond}/${mode1}
                echo "File ${logpath}/${cond}/${mode1} has been created."
	fi
        
        if [ -d "${logpath}/${cond}/${mode1}/${mode2}" ]; then
                echo "File ${logpath}/${cond}/${mode1}/${mode2} exist."
        else    
                mkdir ${logpath}/${cond}/${mode1}/${mode2}
                echo "File ${logpath}/${cond}/${mode1}/${mode2} has been created."
	fi

	echo -e "+----------------------------------------------------------------+"
	echo -e "Test start: Testing deployment modes with ${mode1} and ${mode2}"
	
	for a in {1..5..1};
	do

		echo -e "+----------------------------------------------------------------+"
		echo "Round $a start."
		start=$SECONDS
		for i in {1..5};
		do
			NUM=$[4 * $i]
			start_1=$SECONDS
			./run.sh -t $mode1 -m resnet50 -ns $NUM -s 1 -y 1 -c $mode2 -d $HOME/CK-TOOLS/dataset-imagenet-ilsvrc2012-val-min | cat >> ${logpath}/${cond}/${mode1}/${mode2}/log$a.txt
			duration_1=$(( SECONDS - start_1 ))
			echo $duration_1  >> ${logpath}/${cond}/${mode1}/${mode2}/timer_per_each_test$a.txt
			echo "Druation: ${duration_1}s"
		done

		duration=$(( SECONDS - start ))
		echo $duration  >> ${logpath}/${cond}/${mode1}/${mode2}/timer_per_each_round_$a.txt
		echo "Round Duration: ${duration}s"
		echo -e "+----------------------------------------------------------------+"

	done
	echo "Finish! Log file has been sent to ${logpath}/${cond}/${mode1}/${mode2}."

elif [ "${1}" == "3" ]; then
	cond=Switch_num_of_preprocess_process
	if [ -d "${logpath}/${cond}" ]; then
                echo -e "File ${logpath}/${cond} exist." 
        else
                mkdir ${logpath}/${cond}
                echo -e "File ${logpath}/${cond} has been created."
        fi

        
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

	if [ -d "${logpath}/${cond}/${mode1}" ]; then
                echo "File ${logpath}/${cond}/${mode1} exist."
        else
                mkdir ${logpath}/${cond}/${mode1}
                echo "File ${logpath}/${cond}/${mode1} has been created."
	fi
        
        if [ -d "${logpath}/${cond}/${mode1}/${mode2}" ]; then
                echo "File ${logpath}/${cond}/${mode1}/${mode2} exist."
        else    
                mkdir ${logpath}/${cond}/${mode1}/${mode2}
                echo "File ${logpath}/${cond}/${mode1}/${mode2} has been created."
	fi

	
	echo -e "+----------------------------------------------------------------+"
	echo -e "Test start: Testing deployment modes with ${mode1} and ${mode2}"

	for a in {1..5..1};
        do

		echo -e "+----------------------------------------------------------------+"
		echo "Round $a start."
                start=$SECONDS
                for i in {1..5};
                do
                        NUM=$[4 * $i]
			start_1=$SECONDS
                        ./run.sh -t $mode1 -m resnet50 -y $NUM -ns 1 -s 1 -c $mode2 -d $HOME/CK-TOOLS/dataset-imagenet-ilsvrc2012-val-min | cat >> ${logpath}/${cond}/${mode1}/${mode2}/log$a.txt
                	duration_1=$(( SECONDS - start_1 ))
			echo $duration_1  >> ${logpath}/${cond}/${mode1}/${mode2}/timer_per_each_test$a.txt
                        echo "Druation: ${duration_1}s"
		done

                duration=$(( SECONDS - start ))
                echo $duration  >> ${logpath}/${cond}/${mode1}/${mode2}/timer_per_each_round_$a.txt
		echo "Round Duration: ${duration}s"
		echo -e "+----------------------------------------------------------------+"
        done
	echo "Finish! Log file has been sent to ${logpath}/${cond}/${mode1}/${mode2}."
else
echo "Please select a condition to run. (1 = Switch_batch_size, 2 = Switch_num_of_stream, 3= Switch_num_of_preprocess_process.)"
fi

