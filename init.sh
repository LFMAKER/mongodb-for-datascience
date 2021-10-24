#! /bin/sh 
cd /usr/local/bin/datasets
datasets=`ls *.csv`
for eachfile in $datasets
do
   mongoimport -d Datasets -c "${eachfile%.csv}" --type csv --file $eachfile --headerline
done

