# https://stackoverflow.com/questions/27767264/how-to-dockerize-maven-project-and-how-many-ways-to-accomplish-it
FROM maven:3.6.0-jdk-11-slim AS build
WORKDIR /root/
RUN apt-get update
RUN apt-get install git -f
RUN git clone https://github.com/tarekkhoury/mywebapplication.git
RUN mvn -f /root/mywebapplication/pom.xml clean package

#### publish 
FROM openjdk:11-jre-slim
COPY --from=build /root/mywebapplication/target/mywebapplication.war /var/lib/tomcat9/webapps/mywebapplication.war
EXPOSE 8080
ENTRYPOINT ["java","-war","/var/lib/tomcat9/webapps/mywebapplication.war"]