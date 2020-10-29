#IP1=$(getent hosts maquina-1 | awk '{print $1}')

# Per quan s'indiquen les IPs de les diferents màquines
# IP1=$1
# IP2=$2
# IP3=$3
# export IP1 IP2 IP3
# export REMOTE_MOUNT="/srv/docker/data"
# echo Valor IP1: $IP1
# echo Valor IP2: $IP2
# echo Valor IP3: $IP3

# Per quan es passa per un balancer
IP1=$1
# IP2=$2
# IP3=$3
# export IP1 IP2 IP3
export REMOTE_MOUNT="/srv/docker/data"
echo Valor IP1 del balancer: $IP1
# echo Valor IP2: $IP2
# echo Valor IP3: $IP3

cd /srv/docker/stacks
docker stack deploy -c traefik/stack.yaml traefik
docker stack deploy -c portainer/stack.yaml portainer
docker stack deploy -c wordpress/stack.yaml wordpress
#docker stack deploy -c consul-cluster/stack.yaml consul-cluster
docker stack deploy -c comptador/stack.yaml comptador
docker stack deploy -c elasticsearch/stack.yaml elasticsearch
docker stack deploy -c monitor/stack.yaml monitor