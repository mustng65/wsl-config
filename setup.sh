#! /usr/bin/env bash

apt update
apt upgrade -y

echo "Add User: $1"

echo "password
password" | adduser "$1"

usermod -a -G sudo "$1"