FROM ubuntu:16.04

MAINTAINER Alfredo Bello <skuarch@yahoo.com.mx>

ADD ./tomcat-users.xml ./server.xml /tmp/

RUN apt-get update -y && \
    apt-get install unzip curl -y && \

## install java
    curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k "https://edelivery.oracle.com/otn-pub/java/jdk/8u91-b14/jdk-8u91-linux-x64.tar.gz" && \
    mkdir /usr/lib/jvm && \
    tar -xf /jdk-8u91-linux-x64.tar.gz && \
    mv /jdk1.8.0_91 /usr/lib/jvm/ && \
    chmod 777 -R /usr/lib/jvm && \
    update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.8.0_91/bin/java" 1 && \
    update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.8.0_91/bin/javac" 1 && \
    update-alternatives --install "/usr/bin/javah" "javah" "/usr/lib/jvm/jdk1.8.0_91/bin/javah" 1 && \
    JAVA_HOME=/usr/lib/jvm/jdk1.8.0_91 && \
    export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_91 && \
    export PATH=$PATH:/usr/lib/jvm/jdk1.8.0_91/bin/java && \

## install tomcat
    curl -L -O http://mirror.nexcess.net/apache/tomcat/tomcat-8/v8.0.36/bin/apache-tomcat-8.0.36.tar.gz && \
    tar -xf /apache-tomcat-8.0.36.tar.gz && \
    mkdir /opt/tomcat && \    
    mv /apache-tomcat-8.0.33 /opt/tomcat && \
    chmod 777 -R /opt/tomcat && \
    rm /opt/tomcat/conf/server.xml && \
    mv /tmp/server.xml /opt/tomcat/conf/ && \
    HUDSON_HOME=/opt/tomcat && \
    CATALINA_HOME=/opt/tomcat && \
    export HUDSON_HOME=/opt/tomcat && \
    export CATALINA_HOME=/opt/tomcat && \

## create user
   rm /opt/tomcat/conf/tomcat-users.xml && \    
   mv /tmp/tomcat-users.xml /opt/tomcat/conf/ && \       

## clean up    
   rm -rf /tmp/* && \
   rm /apache-tomcat-8.0.36.tar.gz && \
   rm /jdk-8u91-linux-x64.tar.gz

WORKDIR /opt/tomcat
VOLUME /opt/tomcat/webapps

EXPOSE 3030

CMD /opt/tomcat/bin/catalina.sh run
