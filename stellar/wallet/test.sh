balance=$(node Check_balance.js walletReceive.json | grep -o 'Balance: [0-9A-Z]*')
balance=$(echo $balance | grep -o '[0-9]*')
echo $balance

start_time=$( date +%s.%N )

for((i=1;i<$2;i++))
do
	a=$((i%$3))
	node Send_transaction.js walletReceive.json wallet$a.json &
	sleep $1 
done

b=$(($2%$3))
node Send_transaction.js walletReceive.json wallet$b.json
elapsed_time=$( date +%s.%N --date="$start_time seconds ago" )

echo "rate: $1" >> report.txt
echo $elapsed_time >> report.txt

balance_2=$(node Check_balance.js walletReceive.json | grep -o 'Balance: [0-9A-Z]*')
balance_2=$(echo $balance_2 | grep -o '[0-9]*')
echo $balance_2


balance=$(($balance+$2*100))

echo "init: $balance"
echo "result: $balance_2"


if [ "$balance" = "$balance_2" ]
then
        echo "same!!" >> report.txt
else
        echo "diff!!" >> report.txt
fi
