FROM tomcat:9.0-jdk17
ENV JAVA_OPTS='-Xmx1g -Duser.timezone=Asia/Kolkata -Djava.locale.providers=COMPAT,CLDR,SPI'
RUN chmod 777 /tmp
ADD MyRestApp.war /usr/local/tomcat/webapps/
RUN unlink /etc/localtime
RUN ln -s /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
EXPOSE 8080
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
