#!/bin/bash
for i in {1..600..10};
do
NUM=$[10 * $i]
./run.sh -t streaming_classify -m resnet50 -s $NUM -g -c throughput -d $HOME/CK-TOOLS/dataset-imagenet-ilsvrc2012-val-min | cat >> log4.txt 

done
