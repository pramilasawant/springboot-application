FROM openjdk:17-jdk

WORKDIR /app1

ADD target/app1-0.0.1-SNAPSHOT.jar app1.jar

EXPOSE 8050

ENTRYPOINT ["java", "-jar", "app1.jar"]
