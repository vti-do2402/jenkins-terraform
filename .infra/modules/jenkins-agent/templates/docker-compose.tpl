services:
  jenkins:
    container_name: jenkins
    image: bitnami/jenkins-agent:latest
    environment:
      - JENKINS_URL=${jenkins_url}
      - JENKINS_SECRET=${jenkins_secret}
      - JENKINS_NAME=${jenkins_name}
    ports:
      - "8080:8080"
      - "50000:50000"
    volumes:
      - "${jenkins_home}:/bitnami/jenkins"