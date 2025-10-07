# Build stage
FROM maven:3.9.3-eclipse-temurin-17 AS build
WORKDIR /app

COPY produtoNet/produtoNet/pom.xml .
RUN mvn dependency:go-offline

COPY produtoNet/produtoNet/src ./src
RUN mvn clean package -DskipTests -Dmaven.toolchains.skip=true

# Run stage
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app

COPY --from=build /app/target/produtoNet-0.0.1-SNAPSHOT.jar app.jar

CMD ["java", "-jar", "app.jar"]
