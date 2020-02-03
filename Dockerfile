FROM maven:3.3.9-jdk-8-alpine AS build
WORKDIR /usr/src/app
ADD . /usr/src/app/
RUN apk add --no-cache procps &&  mvn  clean package
FROM openjdk:8-jre-alpine
WORKDIR /usr/src/app/
COPY --from=build /usr/src/app/target/jb-hello-world-maven-0.1.0.jar /usr/app/jb-hello-world-maven-0.1.0.jar
ADD ./appoptics-java.sh /usr/src/app/appoptics-java.sh
RUN /bin/sh /usr/src/app/appoptics-java.sh --service-key=-qA1Qb8-aDQm1egEDESl-SK8fD4_jYpr1Q_mwVPyYTPbkYgZGjpfJ_mFqni-fi2-P-ndpnE:backend
ENTRYPOINT ["java", "-jar", "/usr/app/jb-hello-world-maven-0.1.0.jar"]
