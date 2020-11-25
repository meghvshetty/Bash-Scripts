#!/bin/sh

sudo apt-get install git -y
sudo apt-get install curl -y
sudo apt-get install golang-go -y
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
sudo apt-get install nodejs -y
sudo apt-get install npm -y
sudo apt-get install python -y
sudo apt-get install docker -y
sudo apt-get update
apt-cache policy docker-ce
sudo apt-get install -y docker-ce
sudo apt-get install docker-compose -y
sudo apt-get upgrade
