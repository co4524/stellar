#stellar-core
#--------------------#
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
#---------------------#
cd
wget https://dl.google.com/go/go1.11.4.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.11.4.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin

#client
echo 'Y' | sudo apt-get install postgresql postgresql-client

#horizon install
#---------------------#
wget https://github.com/stellar/go/releases/download/horizon-v0.15.4/horizon-v0.15.4-linux-amd64.tar.gz
sudo tar -C /home/ubuntu -xzf horizon-v0.15.4-linux-amd64.tar.gz

