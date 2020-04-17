#!/bin/bash

for i in {1..5..1}; 
do
	grep 'Performance' log$i.txt | cat >> result$i.txt
done
