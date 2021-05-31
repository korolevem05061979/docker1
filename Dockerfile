# https://stackoverflow.com/questions/27767264/how-to-dockerize-maven-project-and-how-many-ways-to-accomplish-it


### get file from git

FROM ubuntu:16.04 as gitfile
RUN apt-get update
RUN apt-get install git -y
WORKDIR /root/
RUN git clone https://github.com/tarekkhoury/mywebapplication.git
CMD /usr/local/bin/shell.sh ; sleep infinity



#### maven
FROM maven:3.6.0-jdk-11-slim AS mavenpmaker
WORKDIR /root/
COPY --from=gitfile /root/mywebapplication ./ 
RUN mvn -f /root/mywebapplication/pom.xml clean package
CMD /usr/local/bin/shell.sh ; sleep infinity




#### publish 
### FROM openjdk:11-jre-slim
### COPY --from=build /root/mywebapplication/target/mywebapplication.war /var/lib/tomcat9/webapps/mywebapplication.war
### EXPOSE 8080
### ENTRYPOINT ["java","-war","/var/lib/tomcat9/webapps/mywebapplication.war"]ls
