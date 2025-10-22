FROM openjdk:17-jdk-alpine
VOLUME /tmp
ARG JAR_FILE=demo-0.0.1-SNAPSHOT.jar
COPY build/${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
