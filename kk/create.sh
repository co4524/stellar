cp example.json wallet$1.json
a=$(node Create_account.js)
b='"'
public=$(echo $a | grep -o 'G[0-9A-Z]\{55\}')
private=$(echo $a | grep -o 'S[0-9A-Z]\{55\}')
sed -i "s/REPLACEPUBLIC/$public/g" wallet$1.json
sed -i "s/REPLACEPRIVATE/$private/g" wallet$1.json


