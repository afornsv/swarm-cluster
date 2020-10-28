#IP1=$(getent hosts maquina-1 | awk '{print $1}')

IP1=$0
IP2=$1
IP3=$2
export IP1 IP2 IP3
export REMOTE_MOUNT="/srv/docker/data"
echo Valor IP1: $IP1
echo Valor IP2: $IP2
echo Valor IP3: $IP3

cd /srv/docker/stacks
docker stack deploy -c traefik/stack.yaml traefik
docker stack deploy -c portainer/stack.yaml portainer
docker stack deploy -c wordpress/stack.yaml wordpress
#docker stack deploy -c consul-cluster/stack.yaml consul-cluster
#docker stack deploy -c comptador/stack.yaml comptador
