# Build the JAR first: mvn -ntp package -DskipTests
# Then: docker build -t java-vulnerable-scan-poc:local .
#
# Runtime-only image; Alpine variant is much smaller than Jammy.
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY target/java-vulnerable-scan-poc-1.0.0.jar /app/app.jar
# Keep non-root execution for security scanning best practices.
USER nobody
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
