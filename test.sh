s=$(stellar-core -genseed)
seed=${s:13:56}
echo $s
touch key.txt
echo $s >> /home/ubuntu/stellar/key.txt
cat stellar-core.cfg | sed "s/SAGQF56U7CUHUCBDAOJRNFH3AWBOUY4V3Z3AFRJ52LSZI3VHNCKXJOMX/$seed/g" > node.cfg
source .env.tmp
mv node.cfg /home/ubuntu/stellar/stellar-core/
cd /home/ubuntu/stellar/stellar-core
stellar-core new-db --conf node.cfg
stellar-core --forcescp --conf node.cfg
stellar-core -newhist local --conf node.cfg
stellar-core --conf node.cfg