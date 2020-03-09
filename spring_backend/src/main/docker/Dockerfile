FROM adoptopenjdk/openjdk11:alpine
MAINTAINER Jihun Heo <ktsr11@naver.com>

# Add the service itself
ARG JAR_FILE
ADD target/${JAR_FILE} /usr/share/backend.jar

ENTRYPOINT ["java", "-jar", "/usr/share/backend.jar"]
