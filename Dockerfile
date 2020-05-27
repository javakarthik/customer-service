FROM maven:3.5.2-jdk-8-alpine AS MAVEN_BUILD
MAINTAINER Karthik Gunasekaran
COPY pom.xml /build/
COPY src /build/src/
WORKDIR /build/
RUN mvn package

FROM openjdk:8-jdk-alpine
WORKDIR /app
COPY --from=MAVEN_BUILD /build/target/*.jar /app/app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
EXPOSE 8081


