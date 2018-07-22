#!/bin/ksh

echo -n "Please enter an Image directory:"
read dir_name

echo "You have entered the following value: $dir_name"

echo "Now we are switching to the entered directory"
cd $dir_name
echo "Check the present working directory using pwd"
pwd
#echo "Listing the content of the present working directory"
#ls -l

PARENT_DIR=`echo $dir_name | awk -F/ '{print $NF}'`

echo "PARENT DIRECTORY NAME: $PARENT_DIR"

#Setting current date and time

CURR_DATE_TIME=`date +"%d%m%Y%H%M%S"`

echo "Current date and time:$CURR_DATE_TIME"

#EXIF TOOL DIRECTORY
#EXIF_TOOL_DIR=/Users/rivthebest/Documents/TOOLS/Image-ExifTool-10.53

#EXIF TOOL EXECUTION OUTPUT DIRECTORY
EXIF_OUTPUT_DIR=/Users/rivthebest/Documents/Database/BULK_IMPORT

# creating file name with the current directory name and current date and time
FILE_NAME=$PARENT_DIR"_"$CURR_DATE_TIME

#type of the extension of the created file
echo "To set the type of the extension of the generated file"
echo ""
echo -n "Please enter the extension type:"
read EXT
echo ""
echo "Type of extension entered:$EXT"
echo ""

# creating the file
touch $EXIF_OUTPUT_DIR/$FILE_NAME.$EXT

EXIF_OUTPUT_TYPE=""

#echo "The file name goes like this: $FILE_NAME"

if [ "${EXT}" = "json" ]; then
	EXIF_OUTPUT_TYPE="j"
elif [ "${EXT}" = "csv" ]; then
	EXIF_OUTPUT_TYPE="csv"
elif [ "${EXT}" = "tsv" ]; then
	EXIF_OUTPUT_TYPE="tsv"
else
	echo "Unknown extension type."
	exit 1
fi

echo "EXIF OUTPUT TYPE is mentioned as: $EXIF_OUTPUT_TYPE"
#exit 0

# running the exif tool
echo "We are running the exif tool"
echo ""
#echo ""
for file in `ls -l | awk '{print $NF}' | grep [^0-9]`
	do
		exiftool $file -$EXIF_OUTPUT_TYPE >> $EXIF_OUTPUT_DIR/$FILE_NAME.$EXT
	done

#exit 0
# moving the file to the desired location
#mv $FILE_NAME.txt $EXIF_EXECUTE_DIR/$FILE_NAME.TXT

if [ "${EXT}" = "json" ]; then
 #editing the file per the requirement
	echo "Replacing all the opening square bracket with blank"
	echo "" 
	sed -i '' 's/\[//g' $EXIF_OUTPUT_DIR/$FILE_NAME.$EXT
	echo "Replacing all the interim closing square bracket with a comma"
	echo ""
	sed -i '' 's/\]/\,/g' $EXIF_OUTPUT_DIR/$FILE_NAME.$EXT
	echo "Replacing the last comma at the end of the file with a closing square bracket"
	echo ""
	sed -i '' '$s/\,/\]/' $EXIF_OUTPUT_DIR/$FILE_NAME.$EXT
	echo "Inserting Opening Square Bracket at the beginning of the file "
	echo ""
	sed -i '' '1s/^.*$/\[\{/' $EXIF_OUTPUT_DIR/$FILE_NAME.$EXT
	#mongoimport --db myImageContent --collection ${PARENT_DIR}_${CURR_DATE_TIME}_import --file ${EXIF_OUTPUT_DIR}/${FILE_NAME}.$EXT --type $EXT --maintainInsertionOrder

elif [ "${EXT}" = "csv" ]; then
	echo "Removing all the reoccurrance of the header line."
	awk 'FNR==1 {header = $0; print } $0 != header' $EXIF_OUTPUT_DIR/$FILE_NAME.$EXT > ${EXIF_OUTPUT_DIR}/${FILE_NAME}_MODIFIED.$EXT
	#mongoimport --db myImageContent --collection ${PARENT_DIR}_${CURR_DATE_TIME}_import --file ${EXIF_OUTPUT_DIR}/${FILE_NAME}_MODIFIED.$EXT --type $EXT --headerline --maintainInsertionOrder
fi

#importing the json output into the mongodb database
mongoimport --db myImageContent --collection ${PARENT_DIR}_import_${CURR_DATE_TIME} --file ${EXIF_OUTPUT_DIR}/${FILE_NAME}.$EXT --type $EXT --jsonArray --maintainInsertionOrder
