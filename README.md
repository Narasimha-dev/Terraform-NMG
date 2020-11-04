# Terraform-NMG

Terraform Module :-
Procuring the EC2 box and installing the nginx to map the domain to node web server.
modules are created for VPC creation, CIDR block mapping to VPC , subnet creation, security group creation.
main.tf is calling the module and installing it.

TOOL.sh
Automated script created for installing the node, npm, pm2 utility.
Also it do the mapping of default nginx file which containes the server name based routing
To run the script :- bash ./tool.sh

Node1.js :- 
Instance with response “test1” 
created node script to give response "test1"

Node2.js:-
Instance with response “test2”
created node script to give response "test2"

Default :-
this file is Nginx configuration file which map the domain to node instance running on different port.

domain allocation :- 
- From route 53 , created record on test1.me.uk
- test1.test1.me.uk and test2.test1.me.uk is being routed to instance , which is created using terraform script.
- routing server name to instance port via nginx .
