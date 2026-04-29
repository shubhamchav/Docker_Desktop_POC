# Build the JAR first: mvn -ntp package -DskipTests
# Then: docker build -t java-vulnerable-scan-poc:local .
#
# Runtime-only image (smaller pull than JDK + in-container Maven).
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
COPY target/java-vulnerable-scan-poc-1.0.0.jar /app/app.jar
USER nobody
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
