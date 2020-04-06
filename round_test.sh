#!/bin/bash
for i in {1..5};
do
NUM=$[5 * $i]
./run.sh -t streaming_classify -m resnet50 -ns $NUM -g -c throughput -d $HOME/CK-TOOLS/dataset-imagenet-ilsvrc2012-val-min | cat >> log4.txt 

done
