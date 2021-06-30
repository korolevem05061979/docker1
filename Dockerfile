# https://stackoverflow.com/questions/27767264/how-to-dockerize-maven-project-and-how-many-ways-to-accomplish-it


### get file from git

FROM ubuntu:16.04 as gitfile
RUN apt-get update
RUN apt-get install git -y
WORKDIR /root/
RUN git clone https://github.com/shephertz/App42PaaS-Java-MySQL-Sample.git
CMD /usr/local/bin/shell.sh ; sleep infinity



#### maven
FROM maven:3.6.0-jdk-11-slim AS mavenpmaker
WORKDIR /root/
COPY --from=gitfile /root/App42PaaS-Java-MySQL-Sample /root/App42PaaS-Java-MySQL-Sample/ 
RUN mvn -f /root/App42PaaS-Java-MySQL-Sample/pom.xml clean package
CMD /usr/local/bin/shell.sh ; sleep infinity




#### publish 
FROM tomcat:8.5.43-jdk8 
COPY --from=mavenpmaker /root/App42PaaS-Java-MySQL-Sample/target/App42PaaS-Java-MySQL-Sample.war /usr/local/tomcat/webapps/App42PaaS-Java-MySQL-Sample.war
EXPOSE 8080

#
#FROM openjdk:11-jre-slim
#COPY --from=mavenpmaker /root/mywebapplication/target/mywebapplication.war /var/lib/tomcat9/webapps/mywebapplication.war
#EXPOSE 8080
#ENTRYPOINT ["java","-war","/var/lib/tomcat9/webapps/mywebapplication.war"]
#CMD /usr/local/bin/shell.sh ; sleep infinity
