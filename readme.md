docker build --no-cache=true -t skuarch/tomcat:8 .

docker run --name tomcat -i -t -d -p 3030:3030 skuarch/tomcat:8

docker start tomcat