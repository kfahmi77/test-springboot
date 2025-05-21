# Build stage
FROM maven:3.9.8-eclipse-temurin-21 AS build

WORKDIR /app
COPY . .
RUN ./mvnw clean package -DskipTests

# Run stage
FROM eclipse-temurin:21-jdk
WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 4041
ENTRYPOINT ["java", "-jar", "app.jar"]
