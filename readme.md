docker build --no-cache=true -f Dockerfile_tomcat_8.0.36 -t skuarch/tomcat:8 .

docker run --name tomcat -i -t -d -p 3030:3030 --net=host skuarch/tomcat:8

docker start tomcat
