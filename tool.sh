#!/bin/sh
sudo apt install -y nodejs
sudo apt install -y npm
sudo npm install -g pm2
sudo pm2 startup systemd

pm2 start node1.js
pm2 start node2.js

sudo service nginx stop
cp default /etc/nginx/site-available/default
sudo service nginx restart
