FROM tomcat:8.5.43-jdk8
# tomact, default-jdk already installed. We need install maven
RUN apt-get install software-properties-common
RUN apt-add-repository universe
RUN apt-get update
RUN apt-get install maven -y
CMD ["mvn"]