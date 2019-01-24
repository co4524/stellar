#stellar-core
sudo apt-get install software-properties-common
echo | sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update
echo 'Y' | sudo apt-get install git build-essential pkg-config autoconf automake libtool bison flex libpq-dev
echo 'Y' | sudo apt-get install clang-5.0
sudo apt-get install clang-format-5.0
echo 'Y' | sudo apt-get install pandoc
echo 'Y' | sudo apt-get install libc++-dev libc++abi-dev
export CC=clang-5.0
export CXX=clang++-5.0
export CFLAGS="-O3 -g1 -fno-omit-frame-pointer"
export CXXFLAGS="$CFLAGS -stdlib=libc++ -isystem /usr/include/libcxxabi"
git clone https://github.com/stellar/stellar-core.git
cd stellar-core/
./autogen.sh && ./configure && make –j8
sudo make install

#goinstall
cd
wget https://dl.google.com/go/go1.11.4.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.11.4.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin

##### Install Database
#echo 'Y' | sudo apt-get install postgresql postgresql-client


#### Install Horion (/home/ubuntu)
wget https://github.com/stellar/go/releases/download/horizon-v0.15.4/horizon-v0.15.4-linux-amd64.tar.gz
sudo tar -C /home/ubuntu -xzf horizon-v0.15.4-linux-amd64.tar.gz


#Write config,start stellar-core,setup horizon env
cd /home/ubuntu/stellar/
s=$(stellar-core -genseed)
seed=${s:13:56}
echo $s
touch key.txt
echo $s >> /home/ubuntu/stellar/key.txt
cat stellar-core.cfg | sed "s/SAGQF56U7CUHUCBDAOJRNFH3AWBOUY4V3Z3AFRJ52LSZI3VHNCKXJOMX/$seed/g" > node.cfg
#setup horizon env
#source .env.tmp
#setup horizon env
mv node.cfg /home/ubuntu/stellar/stellar-core/
#Get account private/public key to rootAccount.json
cd /home/ubuntu/stellar/stellar-core
Account_private=$(stellar-core new-db --conf node.cfg | grep -o ' S[0-9A-Z]*')
Account_public=$(echo $Account_private | stellar-core --sec2pub) 
echo $Account_private >> /home/ubuntu/stellar/key.txt
echo $Account_public >> /home/ubuntu/stellar/key.txt
#Change account private/public key to rootAccount.json
sed -i "s/GAJBXRI5PNUKTAMK5SYUPQN54VWNBMHABW5RCWSGCQ2DHXDFYPG4E2YL/$Account_public/g" /home/ubuntu/stellar/rootAccount.json
sed -i "s/SBW2NSLIUJNNEDU57ABVVAMFJY4RYD4VNGMATMCL4JIFEUNZEGOGYPEU/$Account_private/g" /home/ubuntu/stellar/rootAccount.json
#start stellar-core
cd /home/ubuntu/stellar/stellar-core
stellar-core --forcescp --conf node.cfg
stellar-core -newhist local --conf node.cfg
stellar-core --conf node.cfg

