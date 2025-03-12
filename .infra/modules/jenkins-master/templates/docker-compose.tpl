services:
  jenkins-master:
    container_name: jenkins_master
    image: bitnami/jenkins:latest
    environment:
      - JENKINS_USERNAME=${jenkins_username}
      - JENKINS_PASSWORD=${jenkins_password}
    ports:
      - "8080:8080"
      - "50000:50000"
    volumes:
      - "${jenkins_home}:/bitnami/jenkins"
