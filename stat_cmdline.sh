#!/bin/bash

#echo "Reading the number file and printing."

#echo ""

# create the array from the external file mentioned below
#digitArray=($(cat digit.txt))

#create the array from the standard input i.e from the keyboard input
#digitArray=($(cat <<EOF #
# Insert each item and hit enter
# Once you finish providing the desired hit <enter> or <return> key from the keyboard
# At the next line type in EOF and hit enter conclude with 2 closing parentheses as mentioned below
# )
# )

#echo "The total array is: ${digitArray[*]}"

#echo "The length of the array: ${#digitArray[*]}"


function SORT
{
	#echo "Sorting the array."
	
	if [ $# -eq 0 ]
		then echo 'Please provide the array as SORT "$(echo ${array_name[@]})"'
		return
	fi
	
	_RANGE_ARRAY=($(echo "$1"))	
	sorted=($(echo ${_RANGE_ARRAY[*]} | tr " " "\n" | sort -n))
	echo "Printing the sorted list:" ${sorted[*]}
}

function MAX
{
	
	if [ $# -eq 0 ]
		then echo 'Please provide the array as MAX "$(echo ${array_name[@]})"'
		return
	fi
    _RANGE_ARRAY=($(echo "$1"))
	sorted=($(echo ${_RANGE_ARRAY[*]} | tr " " "\n" | sort -n))
	echo "The MAXIMUM is: ${sorted[${#_RANGE_ARRAY[*]} - 1]}"
}

#MAX ${digitArray[*]}

function MIN
{
	if [ $# -eq 0 ]
		then echo 'Please provide the array as MIN "$(echo ${array_name[@]})"'
		return
	fi

    _RANGE_ARRAY=($(echo "$1"))
	sorted=($(echo ${_RANGE_ARRAY[*]} | tr " " "\n" | sort -n))
	echo "The MINIMUM is: ${sorted[0]}"
}

function SUM
{
	
	if [ $# -eq 0 ]
		then echo 'Please provide the array as SUM "$(echo ${array_name[@]})"'
		return
	fi
	
	_RANGE_ARRAY=($(echo "$1"))
	
	echo -n "Please select the PRECISION SCALE[0-9]:"
    read PREC_SCALE
	sum=0
	for i in ${_RANGE_ARRAY[*]}
	do
		sum=$(echo "scale=${PREC_SCALE};$sum + $i" | bc -l)
	done
	echo "The SUM is: $sum"
}


function AVERAGE
{ 
	if [ $# -eq 0 ]
		then echo 'Please provide the array as AVERAGE "$(echo ${array_name[@]})"'
		return
	fi
	
	_RANGE_ARRAY=($(echo "$1"))
	echo -n "Please select the PRECISION SCALE[0-9]:"
	read PREC_SCALE	

   	sum=0
	for i in ${_RANGE_ARRAY[*]}
   	do

		#sum=`expr $sum + $i`
		sum=$(echo "scale=${PREC_SCALE};$sum + $i" | bc -l)
   	done
   	mean=$(echo "scale=${PREC_SCALE}; $sum/${#_RANGE_ARRAY[*]}" | bc -l)
   	echo "The MEAN or AVERAGE is: $mean"
}

function MEDIAN
{
	if [ $# -eq 0 ]
		then echo 'Please provide the array as MEDIAN "$(echo ${array_name[@]})"'
		return
	fi
	echo "Finding the MEDIAN of the Array."


	_RANGE_ARRAY=($(echo "$1"))

	echo -n "Please select the PRECISION SCALE[0-9]:"
    read PREC_SCALE

	quotient=`expr ${#_RANGE_ARRAY[*]} / 2`
	mod_val=`expr ${#_RANGE_ARRAY[*]} % 2`


	sorted=($(echo ${_RANGE_ARRAY[*]} | tr " " "\n" | sort -n))
	if [ $mod_val -eq 0 ];then
		median1=${sorted[$quotient - 1]}
		median2=${sorted[$quotient]}
		median=$(echo "scale=${PREC_SCALE}; ($median1 + $median2)/2" | bc -l)
		echo "As the array length is even number: ${#sorted[*]} count of elements so median would be average of 2 mid level values of array: $median"
	else
		median=${sorted[$quotient]}
		echo "As the array length is odd number: ${#sorted[*]} count of elements so The Median value is: $median"
	fi
}

function VAR.P
{
	if [ $# -eq 0 ]
	then echo 'Please provide the array as VAR.P "$(echo ${array_name[@]})"'
		return
	fi

     _RANGE_ARRAY=($(echo "$1"))
	
	echo -n "Please select the PRECISION SCALE[0-9]:"
    read PREC_SCALE
	sum=0
	
        for i in ${_RANGE_ARRAY[*]}
        do
        
        	#sum=`expr $sum + $i`
                sum=$(echo "scale=${PREC_SCALE};$sum + $i" | bc -l)
        done
        mean=$(echo "scale=${PREC_SCALE}; $sum/${#_RANGE_ARRAY[*]}" | bc -l)	

	diffSqrSum=0
	for i in ${_RANGE_ARRAY[*]}
	do
        	diffSqrSum=$(echo "scale=${PREC_SCALE}; $diffSqrSum + ($i - $mean)^2" | bc -l)
	done

	pop_var=$(echo "scale=${PREC_SCALE}; $diffSqrSum/${#_RANGE_ARRAY[*]}" | bc -l)
	echo "The Population Variance: $pop_var"
}

function VAR.S
{
	if [ $# -eq 0 ]
		then echo 'Please provide the array as VAR.S "$(echo ${array_name[@]})"'
		return
	fi

	_RANGE_ARRAY=($(echo "$1"))
	
	echo -n "Please select the PRECISION SCALE[0-9]:"
    read PREC_SCALE
	sum=0
        for i in ${_RANGE_ARRAY[*]}
        do
        
        	#sum=`expr $sum + $i`
                sum=$(echo "scale=${PREC_SCALE};$sum + $i" | bc -l)
        done
        mean=$(echo "scale=${PREC_SCALE}; $sum/${#_RANGE_ARRAY[*]}" | bc -l)

        diffSqrSum=0
        for i in ${_RANGE_ARRAY[*]}
        do
                diffSqrSum=$(echo "scale=${PREC_SCALE}; $diffSqrSum + ($i - $mean)^2" | bc -l)
        done

	samp_var=$(echo "scale=${PREC_SCALE}; $diffSqrSum/(${#_RANGE_ARRAY[*]} - 1)" | bc -l)
	echo "The sample variance is: $samp_var"
	
}

function STDEV.P
{
	if [ $# -eq 0 ]
		then echo 'Please provide the array as STDEV.P "$(echo ${array_name[@]})"'
		return
	fi

    _RANGE_ARRAY=($(echo "$1"))

	echo -n "Please select the PRECISION SCALE[0-9]:"
    read PREC_SCALE
	sum=0 
        for i in ${_RANGE_ARRAY[*]}
        do
        
        	#sum=`expr $sum + $i`
                sum=$(echo "scale=${PREC_SCALE};$sum + $i" | bc -l)
        done
        mean=$(echo "scale=${PREC_SCALE}; $sum/${#_RANGE_ARRAY[*]}" | bc -l)
        
        diffSqrSum=0
        for i in ${_RANGE_ARRAY[*]}
        do      
                diffSqrSum=$(echo "scale=${PREC_SCALE}; $diffSqrSum + ($i - $mean)^2" | bc -l)
        done
        
        pop_var=$(echo "scale=${PREC_SCALE}; $diffSqrSum/${#_RANGE_ARRAY[*]}" | bc -l)	
	
	pop_std_dev=$(echo "scale=${PREC_SCALE}; sqrt($pop_var)" | bc)

	echo "The standard deviation of the Population is: $pop_std_dev"
}

function STDEV.S
{
	if [ $# -eq 0 ]
		then echo 'Please provide the array as STDEV.S "$(echo ${array_name[@]})"'
		return
	fi
    _RANGE_ARRAY=($(echo "$1"))

	echo -n "Please select the PRECISION SCALE[0-9]:"
    read PREC_SCALE
	sum=0 
        for i in ${_RANGE_ARRAY[*]}
        do
        
        	#sum=`expr $sum + $i`
                sum=$(echo "scale=${PREC_SCALE};$sum + $i" | bc -l)
        done
        mean=$(echo "scale=${PREC_SCALE}; $sum/${#_RANGE_ARRAY[*]}" | bc -l)
        
        diffSqrSum=0
        for i in ${_RANGE_ARRAY[*]}
        do      
                diffSqrSum=$(echo "scale=${PREC_SCALE}; $diffSqrSum + ($i - $mean)^2" | bc -l)
        done
        
        samp_var=$(echo "scale=${PREC_SCALE}; $diffSqrSum/(${#_RANGE_ARRAY[*]} - 1)" | bc -l)	
	
	samp_std_dev=$(echo "scale=${PREC_SCALE}; sqrt($samp_var)" | bc)

	echo "The standard deviation of the sample is: $samp_std_dev"
}

function COVARIANCE.P
{
	if [ $# -eq 0 ]
		then echo 'Please provide the array as COVARIANCE.P "$(echo ${array_name1[@]})" "$(echo ${array_name2[@]})"'
		return
	elif [ $# -eq 1 ]
		then echo "You had provided only one array. Please provide the other array too."
		return
	fi
	
	_RANGE_ARRAY_X=($(echo "$1"))
	_RANGE_ARRAY_Y=($(echo "$2"))

	if [ ${#_RANGE_ARRAY_X[@]} -lt ${#_RANGE_ARRAY_Y[@]} ]
			then echo "The 1st Array Count is lesser than the 2nd Array count. So Population Covariance is not possible"
			return
		elif [ ${#_RANGE_ARRAY_X[@]} -gt ${#_RANGE_ARRAY_Y[@]} ]
			then echo "The 2nd Array Count is lesser than the 1st Array count. So Population Covariance is not possible."
			return
		fi
	
	echo -n "Please select the PRECISION SCALE[0-9]:"
        read PREC_SCALE

	sumX=0
	for i in ${_RANGE_ARRAY_X[*]}
	do
		sumX=$(echo "scale=${PREC_SCALE}; $sumX + $i" | bc -l)
	done
	sumY=0
	for i in ${_RANGE_ARRAY_Y[*]}
	do
		sumY=$(echo "scale=${PREC_SCALE}; $sumY + $i" | bc -l)
	done

	meanX=$(echo "scale=${PREC_SCALE}; $sumX/${#_RANGE_ARRAY_X[*]}" | bc -l)
	meanY=$(echo "scale=${PREC_SCALE}; $sumY/${#_RANGE_ARRAY_Y[*]}" | bc -l)

	diffProdSum=0
	for (( i = 0, j = 0; i < ${#_RANGE_ARRAY_X[*]}, j < ${#_RANGE_ARRAY_Y[*]}; i++, j++  ))
	do
		diffProdSum=$(echo "scale=${PREC_SCALE}; $diffProdSum + ((${_RANGE_ARRAY_X[$i]} - $meanX) * (${_RANGE_ARRAY_Y[$j]} - $meanY))" | bc -l)
	done

	covarP=$(echo "scale=${PREC_SCALE}; $diffProdSum/${#_RANGE_ARRAY_X[*]}" | bc -l)

	echo "The Covariance of the Population: $covarP"
		
}

function COVARIANCE.S
{
	
		if [ $# -eq 0 ]
			then echo 'Please provide the arrays as COVARIANCE.S "$(echo ${array_name1[@]})" "$(echo ${array_name2[@]})"'
			return
		elif [ $# -eq 1 ]
			then echo "You have provided only one array. Please provide the other array too."
			return
		fi
		
		_RANGE_ARRAY_X=($(echo "$1"))
        _RANGE_ARRAY_Y=($(echo "$2"))

		if [ ${#_RANGE_ARRAY_X[@]} -lt ${#_RANGE_ARRAY_Y[@]} ]
			then echo "The 1st Array Count is lesser than the 2nd Array count. So Sample Covariance is not possible"
			return
		elif [ ${#_RANGE_ARRAY_X[@]} -gt ${#_RANGE_ARRAY_Y[@]} ]
			then echo "The 2nd Array Count is lesser than the 1st Array count. So Sample Covariance is not possible."
			return
		fi
		
        echo -n "Please select the PRECISION SCALE[0-9]:"
        read PREC_SCALE

        sumX=0
        for i in ${_RANGE_ARRAY_X[*]}
        do
                sumX=$(echo "scale=${PREC_SCALE}; $sumX + $i" | bc -l)
        done
        sumY=0
        for i in ${_RANGE_ARRAY_Y[*]}
        do
                sumY=$(echo "scale=${PREC_SCALE}; $sumY + $i" | bc -l)
        done

        meanX=$(echo "scale=${PREC_SCALE}; $sumX/${#_RANGE_ARRAY_X[*]}" | bc -l)
        meanY=$(echo "scale=${PREC_SCALE}; $sumY/${#_RANGE_ARRAY_Y[*]}" | bc -l)

        diffProdSum=0
        for (( i = 0, j = 0; i < ${#_RANGE_ARRAY_X[*]}, j < ${#_RANGE_ARRAY_Y[*]}; i++, j++  ))
	do
		diffProdSum=$(echo "scale=${PREC_SCALE}; $diffProdSum + ((${_RANGE_ARRAY_X[$i]} - $meanX) * (${_RANGE_ARRAY_Y[$j]} - $meanY))" | bc -l)
	done

	covarS=$(echo "scale=${PREC_SCALE}; $diffProdSum / (${#_RANGE_ARRAY_X[*]} - 1)" | bc -l)

	echo "The Covariance of the Sample: $covarS"
}

function CORREL.P
{
		if [ $# -eq 0 ]
			then echo 'Please provide the array as CORREL.P "$(echo ${array_name1[@]})" "$(echo ${array_name2[@]})"'
			return
		elif [ $# -eq 1 ]
			then echo "You have provided one array. Please provide the other array too."
			return
		fi
		_RANGE_ARRAY_X=($(echo "$1"))
        _RANGE_ARRAY_Y=($(echo "$2"))

		if [ ${#_RANGE_ARRAY_X[@]} -lt ${#_RANGE_ARRAY_Y[@]} ]
			then echo "The 1st Array Count is lesser than the 2nd Array count. So Population Correlation is not possible"
			return
		elif [ ${#_RANGE_ARRAY_X[@]} -gt ${#_RANGE_ARRAY_Y[@]} ]
			then echo "The 2nd Array Count is lesser than the 1st Array count. So Population Correlation is not possible."
			return
		fi
		
		
        echo -n "Please select the PRECISION SCALE[0-9]:"
        read PREC_SCALE

        sumX=0
        for i in ${_RANGE_ARRAY_X[*]}
        do
                sumX=$(echo "scale=${PREC_SCALE}; $sumX + $i" | bc -l)
        done
        sumY=0
        for i in ${_RANGE_ARRAY_Y[*]}
        do
                sumY=$(echo "scale=${PREC_SCALE}; $sumY + $i" | bc -l)
        done

        meanX=$(echo "scale=${PREC_SCALE}; $sumX/${#_RANGE_ARRAY_X[*]}" | bc -l)
        meanY=$(echo "scale=${PREC_SCALE}; $sumY/${#_RANGE_ARRAY_Y[*]}" | bc -l)

	diffSqrSumX=0
        for i in ${_RANGE_ARRAY_X[*]}
        do      
                diffSqrSumX=$(echo "scale=${PREC_SCALE}; $diffSqrSumX + ($i - $meanX)^2" | bc -l)
        done

        pop_varX=$(echo "scale=${PREC_SCALE}; $diffSqrSumX/${#_RANGE_ARRAY_X[*]}" | bc -l)  

        pop_std_devX=$(echo "scale=${PREC_SCALE}; sqrt($pop_varX)" | bc)

	diffSqrSumY=0
        for i in ${_RANGE_ARRAY_Y[*]}
        do      
                diffSqrSumY=$(echo "scale=${PREC_SCALE}; $diffSqrSumY + ($i - $meanY)^2" | bc -l)
        done

        pop_varY=$(echo "scale=${PREC_SCALE}; $diffSqrSumY/${#_RANGE_ARRAY_Y[*]}" | bc -l)  

        pop_std_devY=$(echo "scale=${PREC_SCALE}; sqrt($pop_varY)" | bc)

        diffProdSum=0
        for (( i = 0, j = 0; i < ${#_RANGE_ARRAY_X[*]}, j < ${#_RANGE_ARRAY_Y[*]}; i++, j++  ))
        do
                diffProdSum=$(echo "scale=${PREC_SCALE}; $diffProdSum + ((${_RANGE_ARRAY_X[$i]} - $meanX) * (${_RANGE_ARRAY_Y[$j]} - $meanY))" | bc -l)
        done

        covarP=$(echo "scale=${PREC_SCALE}; $diffProdSum / (${#_RANGE_ARRAY_X[*]})" | bc -l)

	correlP=$(echo "scale=${PREC_SCALE}; $covarP / ($pop_std_devX * $pop_std_devY)" | bc -l)

	echo "The Correlation Coefficient of the Population: $correlP"
}

function CORREL.S
{
		if [ $# -eq 0 ]
			then echo 'Please provide the array as CORREL.S "$(echo ${array_name1[@]})" "$(echo ${array_name2[@]})"'
			return
		elif [ $# -eq 1 ]
			then echo "You have provided one array. You have to provide the other array too."
			return
		fi
				
		_RANGE_ARRAY_X=($(echo "$1"))
        _RANGE_ARRAY_Y=($(echo "$2"))
		
		if [ ${#_RANGE_ARRAY_X[@]} -lt ${#_RANGE_ARRAY_Y[@]} ]
			then echo "The 1st Array Count is lesser than the 2nd Array count. So Sample Correlation is not possible"
			return
		elif [ ${#_RANGE_ARRAY_X[@]} -gt ${#_RANGE_ARRAY_Y[@]} ]
			then echo "The 2nd Array Count is lesser than the 1st Array count. So Sample Correlation is not possible."
			return
		fi

        echo -n "Please select the PRECISION SCALE[0-9]:"
        read PREC_SCALE

        sumX=0
        for i in ${_RANGE_ARRAY_X[*]}
        do
                sumX=$(echo "scale=${PREC_SCALE}; $sumX + $i" | bc -l)
        done
        sumY=0
        for i in ${_RANGE_ARRAY_Y[*]}
        do
                sumY=$(echo "scale=${PREC_SCALE}; $sumY + $i" | bc -l)
        done

        meanX=$(echo "scale=${PREC_SCALE}; $sumX/${#_RANGE_ARRAY_X[*]}" | bc -l)
        meanY=$(echo "scale=${PREC_SCALE}; $sumY/${#_RANGE_ARRAY_Y[*]}" | bc -l)

        diffSqrSumX=0
        for i in ${_RANGE_ARRAY_X[*]}
        do
                diffSqrSumX=$(echo "scale=${PREC_SCALE}; $diffSqrSumX + ($i - $meanX)^2" | bc -l)
        done

        samp_varX=$(echo "scale=${PREC_SCALE}; $diffSqrSumX/(${#_RANGE_ARRAY_X[*]} - 1)" | bc -l)

        samp_std_devX=$(echo "scale=${PREC_SCALE}; sqrt($samp_varX)" | bc)

        diffSqrSumY=0
        for i in ${_RANGE_ARRAY_Y[*]}
        do
                diffSqrSumY=$(echo "scale=${PREC_SCALE}; $diffSqrSumY + ($i - $meanY)^2" | bc -l)
        done

        samp_varY=$(echo "scale=${PREC_SCALE}; $diffSqrSumY/(${#_RANGE_ARRAY_Y[*]} - 1)" | bc -l)

        samp_std_devY=$(echo "scale=${PREC_SCALE}; sqrt($samp_varY)" | bc)

        diffProdSum=0
        for (( i = 0, j = 0; i < ${#_RANGE_ARRAY_X[*]}, j < ${#_RANGE_ARRAY_Y[*]}; i++, j++  ))
        do
                diffProdSum=$(echo "scale=${PREC_SCALE}; $diffProdSum + ((${_RANGE_ARRAY_X[$i]} - $meanX) * (${_RANGE_ARRAY_Y[$j]} - $meanY))" | bc -l)
        done

        covarS=$(echo "scale=${PREC_SCALE}; $diffProdSum / (${#_RANGE_ARRAY_X[*]} - 1)" | bc -l)

        correlS=$(echo "scale=${PREC_SCALE}; $covarS / ($samp_std_devX * $samp_std_devY)" | bc -l)

        echo "The Correlation Coefficient of the Population: $correlS"
}
