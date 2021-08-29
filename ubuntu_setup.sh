#! /usr/bin/env bash

echo " "
echo "Making sure Ubuntu is up to date (this may take awhile)..."
{
apt update
apt upgrade -y
} &> /dev/null



echo " "
echo "Making sure user '$1' is setup..."

userFound=$(getent passwd $1)

if [ -f $userFound ];
then
    echo "  Adding user '$1'"

    {
        echo -e "password\npassword" | adduser "$1" 
        usermod -a -G sudo "$1"
    } &> /dev/null

else
   echo "  User '$1' already exists"
fi

echo " "
echo "Install PIP library..."
{
echo "deb http://ppa.launchpad.net/deadsnakes/ppa/ubuntu focal main " >> /etc/apt/sources.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv F23C5A6CF475977595C89F51BA6932366A755776 
apt update

apt install python3.8 python3-pip -y

} &> /dev/null


echo " "
echo "Install Ansible..."
{
apt install software-properties-common
echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu focal main" >> /etc/apt/sources.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367
apt update

apt install -y ansible
} &> /dev/null


echo " "
echo "Install Kerberos Library..."
{
apt-get install python-dev libkrb5-dev  -y 
export DEBIAN_FRONTEND=noninteractive 
# apt-get -yq krb5-user
apt-get install -y -qq krb5-user
pip3 install pywinrm[kerberos]
} &> /dev/null

