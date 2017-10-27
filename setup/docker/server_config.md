### install in ubuntu

1. install docker-ce:
  https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu

2. set registry:
  ```
  curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s https://registry.docker-cn.com
  ```

3. grant user
`usermod -aG docker cf-stage`


4. install docker-compose:
  https://docs.docker.com/compose/install/#install-compose


5. install docker-machine
  https://docs.docker.com/machine/install-machine/


## create swarm :

https://docs.docker.com/engine/swarm/swarm-tutorial/create-swarm/
1. docker swarm init --advertise-addr <MANAGER-IP>

2. add worker node:
  - [change hostname](https://askubuntu.com/questions/87665/how-do-i-change-the-hostname-without-a-restart)
  - install
  - ufw allow from/to (both ways)
  - docker swarm join
  - docker login
  - set registry
3. login to aliyun registry


3. replace default ingress network
  ```docker network rm```

  ```docker network create -d overlay --ingress --subnet 100.0.0.0/24 my-ingress```


## monitor
1. daemon setup
   https://docs.docker.com/engine/admin/prometheus/#configure-docker

2. swarmprom
  https://github.com/stefanprodan/swarmprom
