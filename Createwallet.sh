cp example.json wallet.json
a=$(node createAccount.js)
b='"'
public=$(echo $a | grep -o 'G[0-9A-Z]\{55\}')
private=$(echo $a | grep -o 'S[0-9A-Z]\{55\}')
sed -i "s/REPLACEPUBLIC/$public/g" wallet.json
sed -i "s/REPLACEPRIVATE/$private/g" wallet.json