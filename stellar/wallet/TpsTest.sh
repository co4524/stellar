rm report.txt
touch report.txt
INDEX=0
while [ $INDEX -le 10 ]
do
	c=$(echo "1-0.05*($INDEX)"|bc)
	echo $c
	./test.sh $c $1 $2	
	((INDEX ++))
done
