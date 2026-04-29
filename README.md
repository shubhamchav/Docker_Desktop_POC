# Java vulnerable scan POC

Minimal Maven project used to **compare container vulnerability scanners** (Docker Scout, Trivy, Snyk). It ships a **known vulnerable library** in the shaded JAR:

- `org.apache.commons:commons-text:1.9` — affected by **CVE-2022-42889** (Text4Shell).

This is for **lab / training only**. Do not run in production.

## Local build

The Docker image copies the **prebuilt** shaded JAR from `target/`. Build the JAR first, then build the image.

```bash
mvn -ntp package -DskipTests
docker build -t java-vulnerable-scan-poc:local .
```

## Docker Scout (Docker Desktop / CLI)

After building the image:

```bash
docker scout quickview java-vulnerable-scan-poc:local
docker scout cves java-vulnerable-scan-poc:local
```

## Trivy (local)

```bash
trivy image --severity HIGH,CRITICAL java-vulnerable-scan-poc:local
```

## GitHub Actions

Workflow: `.github/workflows/ci.yml`

- Builds the image and runs **Trivy** (`aquasecurity/trivy-action@0.35.0`) with JSON + optional SARIF upload.
- **Snyk**: commented job template in the workflow — add `SNYK_TOKEN` and uncomment to run in CI.

## Comparing tools

Use the **same image digest** when comparing:

```bash
docker inspect --format='{{index .RepoDigests 0}}' java-vulnerable-scan-poc:local
```

Download the **Trivy JSON artifact** from the workflow run and compare CVE IDs and severities to Scout and Snyk outputs.
