install:
	chmod 777 stellar-core-set.sh
	./stellar-core-set.sh


postgresql:
	echo 'Y' | sudo apt-get install postgresql postgresql-client
	sudo su postgres

horizon:
	chmod 777 Horizon_env.sh
	./Horizon_env.sh
