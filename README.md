# stellar

>step1:auth
>>$chmod 777 stellar-core-set.sh

>step2: install psql
>>$echo 'Y' | sudo apt-get install postgresql postgresql-client

>step3: creat role db
>>1:$sudo su postgres 	 	 
>>2:$psql postgres -f psql.dat

>step4: start stellar-core
>>$./stellar-core-set.sh

>step5 start horizon
>>1:$./horizon db init 		
>>2:$./horizon serve

# stellar
# stellar
