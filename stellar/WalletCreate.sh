for((i=0;i<=$1;i++))
do
./Createwallet.sh $i      
echo "create wallet$i!!"
done
./Createwallet.sh Receive
