#!/bin/bash/
sudo apt-get -y update 
sudo apt-get -y install python3-pip
sudo git clone xxxx
cd ~/Try_on/api
sudo pip install -r requirements.txt 
sudo python3 manage.py runserver 
