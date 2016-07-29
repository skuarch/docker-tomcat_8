FROM ubuntu:16.04

MAINTAINER Alfredo Bello <skuarch@yahoo.com.mx>

ADD ./jdk-8u91-linux-x64.tar.gz ./apache-tomcat-8.0.33.tar.gz ./tomcat-users.xml ./server.xml /tmp/

## install java
RUN mkdir /usr/lib/jvm && \    
    mv /tmp/jdk1.8.0_91 /usr/lib/jvm/ && \
    chmod 777 -R /usr/lib/jvm && \        
    update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.8.0_91/bin/java" 1 && \
    update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.8.0_91/bin/javac" 1 && \
    update-alternatives --install "/usr/bin/javah" "javah" "/usr/lib/jvm/jdk1.8.0_91/bin/javah" 1 && \
    JAVA_HOME=/usr/lib/jvm/jdk1.8.0_91 && \
    export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_91 && \
    export PATH=$PATH:/usr/lib/jvm/jdk1.8.0_91/bin/java && \

## install tomcat
    mv /tmp/apache-tomcat-8.0.33 /opt/tomcat && \
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
   rm -rf /tmp/*

WORKDIR /opt/tomcat
VOLUME /opt/tomcat/webapps

EXPOSE 3030

CMD /opt/tomcat/bin/catalina.sh run
