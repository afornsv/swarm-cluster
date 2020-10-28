curl https://get.docker.com | sudo bash

mkdir -p /srv/nfs
mkdir -p /srv/docker

# Crear diretoris on s'emmagatzemaran els stack.yaml de cada servei
mkdir -p /srv/docker/stacks/portainer
mkdir -p /srv/docker/stacks/traefik
mkdir -p /srv/docker/stacks/wordpress
mkdir -p /srv/docker/stacks/comptador
mkdir -p /srv/docker/stacks/consul-cluster
mkdir -p /srv/docker/stacks/elasticsearch

# Crear diretoris on s'emmagatzemaran les dates de cada servei
mkdir -p /srv/docker/data/portainer/portainer/data
mkdir -p /srv/docker/data/traefik/traefik/data
mkdir -p /srv/docker/data/wordpress/wordpress/data
mkdir -p /srv/docker/data/wordpress/mysql/data
mkdir -p /srv/docker/data/comptador/comptador/data
mkdir -p /srv/docker/data/consul-cluster/consul-cluster/data
mkdir -p /srv/docker/data/elasticsearch/elasticsearch/data
mkdir -p /srv/docker/data/elasticsearch/logstash/config

# Copia els yamls del repo als directoris creats
cp portainer/stack.yaml /srv/docker/stacks/portainer/stack.yaml
cp traefik/stack.yaml /srv/docker/stacks/traefik/stack.yaml
cp wordpress/stack.yaml /srv/docker/stacks/wordpress/stack.yaml
# cp comptador/stack.yaml /srv/docker/stacks/comptador/stack.yaml
# cp consul-cluster/stack.yaml /srv/docker/stacks/consul-cluster/stack.yaml
cp elasticsearch/stack.yaml /srv/docker/stacks/elasticsearch/stack.yaml
cp elasticsearch/files/logstash.conf /srv/docker/data/elasticsearch/logstash/config

#	Configurar NFS
echo 'maquina-1:/srv/nfs /srv/docker nfs defaults,nfsvers=3 0 0' >> /etc/fstab
apt install -y nfs-kernel-server
echo '/srv/nfs 10.132.0.0/24(rw,no_root_squash,no_subtree_check)' >> /etc/exports
systemctl start nfs-kernel-server
mount -a

docker swarm init 
docker swarm join-token manager|grep join  > /srv/docker/join.sh
chmod +x !$

cd /srv/docker

docker network create proxy -d overlay
docker network create portainer_agent -d overlay
docker network create backend -d overlay
docker network create frontend -d overlay
docker network create logstash -d overlay
docker network create elasticsearch -d overlay

##ULL! Fer un systemctl restart nfs-kernel-server i assegurar-se que el servei xuta bé
