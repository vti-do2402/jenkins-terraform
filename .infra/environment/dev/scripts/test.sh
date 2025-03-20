# curl -sO http://54.218.167.173:8080/jnlpJars/agent.jar
# java -jar agent.jar -url http://54.218.167.173:8080/ -secret 7466313ef12af05a7b2805a9d5ae17f442db444e2c4f87f23e8e4775e2f2b12a -name first -webSocket -workDir "/opt/jenkins"

# curl -sO http://10.0.1.201:8080/jnlpJars/agent.jar
java -jar agent.jar -url http://10.0.1.25:8080/ -secret ee95fe5034b0ad9becf85de3320b94a1c9105473fb2a1aaf61f2e478fcfcc102 -name terraform -workDir "/opt/jenkins/"