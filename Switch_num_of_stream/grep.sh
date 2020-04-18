#!/bin/bash
mkdir result

for i in {1..5..1}; 
do
	grep 'Performance' log$i.txt | grep -o '\s[0-9]*\.[0-9]*\s' | cat >> result/result$i.txt
	mv timer_per_each_test$i.txt result/timer_per_each_test$i.txt 
done
