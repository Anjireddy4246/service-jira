FROM openjdk:8-jre-alpine

LABEL maintainer="Andrei Varabyeu <andrei_varabyeu@epam.com>"
LABEL version="3.2.0-RC-1"
LABEL description="EPAM Report portal. Jira Integration"

ENV APP_FILE service-jira-3.2.0-RC-1
ENV APP_DOWNLOAD_URL https://dl.bintray.com/epam/reportportal/com/epam/reportportal/service-jira/3.2.0-RC-1/$APP_FILE.jar
ENV JAVA_OPTS="-Xmx256m -Djava.security.egd=file:/dev/./urandom"
ENV JAVA_APP=/app.jar

RUN sh -c "echo $'#!/bin/sh \n\
exec java $JAVA_OPTS -jar $JAVA_APP' > /start.sh && chmod +x /start.sh"

VOLUME /tmp

RUN apk add --update openssl
RUN wget -O $JAVA_APP $APP_DOWNLOAD_URL

EXPOSE 8080
ENTRYPOINT ["/start.sh"]