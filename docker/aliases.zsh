alias fig=docker-compose
alias dm=docker-machine
alias dc=docker-compose
alias dcl="docker-compose logs"
alias dclf="docker-compose logs -f --tail=10"

dm-up() {
  docker-machine start $1
  eval $(docker-machine env $1)
}

docker-clean() {
  docker rm $(docker ps -a -q)
  docker rmi $(docker images | grep "^<none>" | awk '{print $3}')
}

de() {
  docker exec -it $1 /bin/bash
}
