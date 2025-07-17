# Stage 1: Build with Maven
FROM maven:3.9.3-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run with Tomcat
FROM tomcat:10.1.14-jdk17-temurin

# Remove default webapps (optional but cleaner)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR into the webapps folder
COPY --from=build /app/target/webscrapping-1-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/demo1.war

EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
