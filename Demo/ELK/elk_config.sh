#!/bin/bash
echo "Copying the SSH Key to ELK Server"
echo -e "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDEXtSHNDteXEuZk3gmHGYkO1hUOliUhlZoKH7Q6RnVBbejOc7NUu/9Kr3MXlvlBANlAlsd/qHXepqMZXXQXksWi1JetvaOrTcivOzD+1g4Ep3mk7JHcFriMaAK63+6QNMCOjqCKuSRNc9EoF8KXd/JXHIDiJ4R0LGyOXC0vzPmbgX708HemcRwk3AlMsKjBkrh9MQWENDCH73PX1I5uU09TJL9pt8QAoSv6nhKhLd7xCeUFAQzkITyqyhpnCoKCJiBuPJ9a72+oZ0EwIoUHiJkY29IjGvvzUqCCCwY/0DZCFFj+hcV/L2inWS2nKuY5cUNNAcNX5igaZVh/k1T744F gabrielrodriguez@QS-US-MB-GABE.local
" >> /home/.ssh/elk-key-pair.pub

echo "apt-get update & upgrade"
sudo su
apt-get update && apt-get upgrade -y

echo "install the java jre"
apt-get install default-jre -y 
java -version

echo "inport the elasticsearch PGP key"
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg

echo "installing from the APT repository"
sudo apt-get install apt-transport-https
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list
sudo apt-get update && sudo apt-get install elasticsearch

echo "configure elasticsearch to start automatically"
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service
systemctl status elasticsearch.service
curl http://localhost:9200

echo "installing logstash"
apt-get install logstash

echo "installing kibana"
apt-get install kibana
echo "server.host: \"0.0.0.0\"" >> /etc/kibana/kibana.yml
echo "elasticsearch.hosts: [\"http://localhost:9200\"]" >> /etc/kibana/kibana.yml
service kibana start
service kibana status