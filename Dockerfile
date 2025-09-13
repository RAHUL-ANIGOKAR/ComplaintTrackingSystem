# Dockerfile
FROM tomcat:9
LABEL maintainer="rahul"
COPY build/ComplaintTrackingSystem.war /usr/local/tomcat/webapps/ComplaintTrackingSystem.war
