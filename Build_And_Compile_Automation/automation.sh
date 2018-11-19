#!/bin/bash
cd
echo "Starting script...\n"

echo "Killing all processes running on ports 3306 and 8080...\n"
fuser -k 8080/tcp
fuser -k 3306/tcp

echo "Getting Java 8...\n"
sudo apt-get install openjdk-8-jre

echo "Getting MySQL...\n"
sudo apt-get install mysql-server-5.7

echo "Getting Maven...\n"
sudo apt-get install mvn 

echo "Cloning openmrs-core...\n"
git clone https://github.com/openmrs/openmrs-core.git

echo "Changing directory to openmrs-core...\n"
cd openmrs-core

echo "Compiling... (This may take a while)\n"
mvn clean install

echo "Changing directory to webapp subfolder...\n"
cd webapp

echo "Running Jetty server...\n"
mvn jetty:run

echo "Going to installation wizard...\n"
xdg-open http://localhost:8080/openmrs/initialsetup

echo "Completed setup!"
