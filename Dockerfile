# syntax=docker/dockerfile:1

# Stage 1: build the executable WAR with Maven on JDK 21 (tests run in CI, so they are skipped here)
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /build
COPY pom.xml .
RUN mvn -B -q dependency:go-offline
COPY src ./src
RUN mvn -B -q package -DskipTests

# Stage 2: slim Java 21 runtime with only the WAR (JSPs are compiled by embedded Tomcat at runtime)
FROM eclipse-temurin:21-jre
WORKDIR /app
RUN useradd --system --create-home appuser
COPY --from=build /build/target/*.war app.war
RUN chown -R appuser /app
USER appuser
# Fits the 512 MB free tier on Render: capped heap, small thread stacks, serial GC
ENV JAVA_TOOL_OPTIONS="-Xmx300m -Xss512k -XX:+UseSerialGC -XX:MaxMetaspaceSize=128m" \
    PORT=4545
EXPOSE 4545
# Database and admin settings come from environment variables (see .env.example).
# The server listens on $PORT (Render sets it automatically).
ENTRYPOINT ["java", "-jar", "/app/app.war"]
