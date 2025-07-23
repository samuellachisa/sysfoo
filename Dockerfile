# ---- Build Stage ----
FROM maven:3.9.6-eclipse-temurin-17-alpine AS build

WORKDIR /build

# Copy your app code and pom.xml into the image
COPY . .

# Build the application (skipping tests)
RUN mvn package -DskipTests

# ---- Runtime Stage ----
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copy the jar file from the build stage
COPY --from=build /build/target/sysfoo*.jar /app/sysfoo.jar

EXPOSE 8080

CMD ["java", "-jar", "/app/sysfoo.jar"]

