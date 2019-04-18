cp example.json wallet$1.json
a=$(node createAccount.js)
b='"'
public=$(echo $a | grep -o 'G[0-9A-Z]\{55\}')
private=$(echo $a | grep -o 'S[0-9A-Z]\{55\}')
Public=${public:0:56}
Private=${private:0:56}
echo "WalletSeed: $Public"
echo "WalletSeed: $Private"
sed -i "s/REPLACEPUBLIC/$Public/g" wallet$1.json
sed -i "s/REPLACEPRIVATE/$Private/g" wallet$1.json
mv wallet$1.json wallet/
