# Etapa de build: usar Maven para compilar o projeto
FROM maven:3.9.3-eclipse-temurin-17 AS build
WORKDIR /app

# Copiar pom.xml e baixar dependências
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copiar código-fonte e construir o jar
COPY src ./src
RUN mvn clean package -DskipTests

# Etapa de runtime: usar JDK leve para rodar o jar
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Rodar a aplicação
ENTRYPOINT ["java", "-jar", "app.jar"]
