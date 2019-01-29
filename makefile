setup:
	chmod 777 stellar-core-set.sh
	chmod 777 Horizon_env.sh
	chmod 777 Createwallet.sh
	echo 'Y' | sudo apt-get install postgresql postgresql-client
	sudo su postgres

