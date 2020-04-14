#!/bin/bash

if [ "${1}" == "1" ]; then
mode1=streaming_classify
else
mode1=streaming_classify_fpgaonly
fi

if [ "${2}" == "1" ]; then
mode2=autoAllOpt
elif [ "${2}" == "2" ]; then 
mode2=throughput
else 
mode2=latency
fi

for a in {1..5..1};
do 

start=$SECONDS
for i in {10..60..10};
do
NUM=$[10 * $i]
./run.sh -t $mode1 -m resnet50 -s $NUM  -c $mode2 -d $HOME/CK-TOOLS/dataset-imagenet-ilsvrc2012-val-min | cat > FNAL-Alveo-FPGA/$mode1/UCSD/$mode2/log$a.txt 

done

duration=$(( SECONDS - start ))
echo $duration  >> FNAL-Alveo-FPGA/$mode1/UCSD/$mode2/timer$a.txt
echo $duration
done
