yum -v repolist

x='echo $?'

if [ $x == 0 ]
then 
   echo "command is good"
else 
   echo "command is bad"
fi


