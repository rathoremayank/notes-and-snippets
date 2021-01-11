#!/bin/bash

mkdir /home/douser
groupadd devops
useradd -g devops -d /home/douser -s /bin/bash douser
usermod -aG sudo douser
chown -R douser:devops /home/douser

su - douser
