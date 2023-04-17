#!/bin/bash
printf "\n"
link=$1
if [ ! -d $link ];then
   echo "The input link does not exist!"
   exit 
fi

defe_count=`ls -1q $link/*efinition.pl | wc -l`
case $defe_count in 
   0)
      echo "There is no file Definition in folder $link"
      exit;;
   1)
      for file in `ls $link/*efinition.pl`;do
         if [ $file ];then
            echo "File ${file##*/} is detected."
         fi
      done ;;
   [2-9])
      echo "There are more than 1 file Definition.pl in folder $link. Please remove all the unnecessary files!"
      exit;;
esac

suite=`ls -1q $link/*List.pl | wc -l`
case $suite in 
   0)
      echo "There is no file testsuiteList.pl in folder $link"
      exit;;
   1)
      for file in `ls $link/*List.pl`;do
         if [ $file ];then
            echo "File ${file##*/} is detected."
         fi
      done ;;
   [2-9])
      echo "There are more than 1 file testsuiteList.pl in folder $link. Please remove all the unnecessary files!"
      exit;;
esac

user=${HOME:6}
password=$2
command="/home/$user/ats_repos/lib/perl/SonusQA/startAutomation -def $link/*efinition.pl -test $link/*suiteList.pl"
if [ $password ];then
     yes $password | $command
else
     $ yes | $command
fi
