#!/bin/sh

array=()

#array=(`sort -R digit10.txt`)
#echo ${array[*]}
#echo ${array[0]}
#echo ${array[*]} | tr -d '[:space:]'
#exit 0



for (( i=0; i < 3225600; i++ ))
do
	array=(`sort -R digit10.txt`)
	if [[ ${array[0]} -eq 1 ]]; then
		echo ${array[*]} | tr -d '[:space:]' >> digit_start_with_1.txt
		echo >> digit_start_with_1.txt
		#cat digit_start_with_1.txt
		array=()
		#exit 0
	elif [[ ${array[0]} -eq 2 ]]; then
		echo ${array[*]} | tr -d '[:space:]' >> digit_start_with_2.txt
		echo >> digit_start_with_2.txt
		#cat digit_start_with_2.txt
        array=()
		#exit 0
	elif [[ ${array[0]} -eq 3 ]]; then
        echo ${array[*]} | tr -d '[:space:]' >> digit_start_with_3.txt
		echo >> digit_start_with_3.txt
		#cat digit_start_with_3.txt
        array=()
		#exit 0
	elif [[ ${array[0]} -eq 4 ]]; then
        echo ${array[*]} | tr -d '[:space:]' >> digit_start_with_4.txt
		echo >> digit_start_with_4.txt
		#cat digit_start_with_1.txt
        array=()
		#exit 0
	elif [[ ${array[0]} -eq 5 ]]; then
        echo ${array[*]} | tr -d '[:space:]' >> digit_start_with_5.txt
		echo >> digit_start_with_5.txt
		#cat digit_start_with_1.txt
        array=()
		#exit 0
	elif [[ ${array[0]} -eq 6 ]]; then
        echo ${array[*]} | tr -d '[:space:]' >> digit_start_with_6.txt
		echo >> digit_start_with_6.txt
		#cat digit_start_with_6.txt
        array=()
		#exit 0
	elif [[ ${array[0]} -eq 7 ]]; then
        echo ${array[*]} | tr -d '[:space:]' >> digit_start_with_7.txt
		echo >> digit_start_with_7.txt
		#cat digit_start_with_7.txt
        array=()
		#exit 0
	elif [[ ${array[0]} -eq 8 ]]; then
        echo ${array[*]} | tr -d '[:space:]' >> digit_start_with_8.txt
		echo >> digit_start_with_8.txt
		#cat digit_start_with_8.txt
        array=()
		#exit 0
	elif [[ ${array[0]} -eq 9 ]]; then
        echo ${array[*]} | tr -d '[:space:]' >> digit_start_with_9.txt
		echo >> digit_start_with_9.txt
		#cat digit_start_with_9.txt
        array=()
		#exit 0
	else
		echo ${array[*]} | tr -d '[:space:]' >> digit_start_with_0.txt
		echo >> digit_start_with_0.txt
		#cat digit_start_with_0.txt
		array=()
		#exit 0
		
	fi
done
