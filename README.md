# stellar

>step1:auth
>>$chmod 777 stellar-core-set.sh

>step2: install psql
>>$echo 'Y' | sudo apt-get install postgresql postgresql-client

>step3: creat role db
>>$sudo su postgres 	 	 $psql postgres -f psql.dat

>step4: start stellar-core
>>$./stellar-core-set.sh

>step5 start horizon
>>$chmod 777 Horizon_env.sh 		$./Horizon_env.sh

# stellar

git clone https://github.com/co4524/stellar.git

# stellar
