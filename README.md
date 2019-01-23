Caideyi

echo 'Y' | sudo apt-get install postgresql postgresql-client
sudo su postgres
psql postgres -f psql.dat

./horizon db init
./horizon serve

# stellar
# stellar
