IMAGE_NAME = crm/jenkins
CONTAINER_NAME = crm_jenkins
JENKINS_HOME = /var/jenkins_home
DOCKER_SOCK = /var/run/docker.sock

build:
	sudo docker build -t $(IMAGE_NAME) .
	if [ ! -d "$(JENKINS_HOME)" ]; then \
		sudo mkdir $(JENKINS_HOME); \
	fi
	sudo chown -R 1000:1000 /var/jenkins_home
	sudo docker run -d -p 10808:8080 -p 50000:50000 -v $(JENKINS_HOME):/var/jenkins_home -v $(DOCKER_SOCK):/var/run/docker.sock --name $(CONTAINER_NAME) $(IMAGE_NAME)

stop:
	sudo docker stop $(CONTAINER_NAME)

remove-all:
	sudo docker stop $(CONTAINER_NAME)
	sudo docker rm $(CONTAINER_NAME)
	sudo docker rmi $(IMAGE_NAME)
	sudo docker rmi jenkins