FROM tomcat:8.0.51-jre8-alpine
RUN rm -Rf /usr/local/tomcat/webapps/ROOT
COPY target/tmbr-common-bff-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
ENV JAVA_OPTS="$JAVA_OPTS $JSSE_OPTS -Djava.security.egd=file:/dev/./urandom"
