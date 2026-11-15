# Module 08: CI/CD Pipeline

## Project Overview

This repository contains a CI/CD demonstration built around a Go-based Prometheus dummy exporter.

The project demonstrates automated code checks, Docker image building, container smoke testing, image publishing, vulnerability scanning, and a simulated manual deployment.

Two CI/CD implementations are included:

- **GitLab CI/CD:** `.gitlab-ci.yml`, the primary configuration required by the assignment.
- **GitHub Actions:** `.github/workflows/ci.yml`, an alternative implementation used to execute and verify the pipeline.

## Repository Structure

| Path | Purpose |
|---|---|
| `.gitlab-ci.yml` | GitLab CI/CD pipeline |
| `.github/workflows/ci.yml` | GitHub Actions pipeline |
| `Dockerfile` | Multi-stage Docker build |
| `scripts/smoke-test.sh` | Container functionality checks |
| `cicd-comparison.md` | Comparison of four CI/CD platforms |
| `dummy_exporter.go` | Go exporter application |
| `pkg/config/` | Application configuration code |
| `example/simple.yml` | Example exporter configuration |

## Requirements

For local execution:

- Docker Engine or Docker Desktop with Docker integration
- Bash for running the smoke test
- Go 1.23 for running code checks outside Docker

## Building and Running the Application

Build the image:

```bash
docker build -t dummy-exporter:local .
```

Run the exporter:

```bash
docker run --rm -p 9510:9510 dummy-exporter:local
```

The exporter exposes Prometheus metrics at:

```text
http://localhost:9510/metrics
```

In another terminal, inspect the metrics:

```bash
curl http://localhost:9510/metrics
```

Stop the container with `Ctrl+C`.

## Running the Smoke Test

Build the Docker image, then run:

```bash
bash scripts/smoke-test.sh dummy-exporter:local
```

The smoke test:

1. Starts a temporary container.
2. Waits for the `/metrics` endpoint to respond.
3. Verifies that the output contains the `dummy_foo` gauge and `dummy_bar` counter.
4. Removes the temporary container after execution.

The test fails if the exporter does not become ready or the expected metrics are missing.

## GitLab CI/CD Pipeline

The GitLab configuration defines five stages:

| Stage | Purpose |
|---|---|
| `lint` | Check Go formatting, run `go vet` and `go test` |
| `build` | Build the Docker image and push it to GitLab Container Registry |
| `test-image` | Pull the published image from the registry and run the smoke test |
| `security` | Scan the built image using Trivy |
| `deploy` | Provide a manual deployment simulation on the default branch |

### Image Tagging

The GitLab pipeline uses predefined CI variables.

Every published image receives a tag based on the full commit SHA:

```text
$CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
```

On the default branch, the build job also publishes:

```text
$CI_REGISTRY_IMAGE:latest
```

The `latest` tag is not published for other branches.

Registry authentication uses GitLab-provided variables, including `CI_REGISTRY_USER` and `CI_REGISTRY_PASSWORD`. Credentials are not stored in the repository.

### Merge Request Pipelines

The configuration includes workflow rules for branch and merge request pipelines. Once a branch has an open merge request, its redundant branch pipeline is suppressed.

### Docker-in-Docker

The Docker jobs use a Docker CLI image and a Docker-in-Docker service.

The GitLab Runner must support this execution model, including the necessary privileged configuration.

### Security Scanning

Trivy scans the Docker image for HIGH and CRITICAL vulnerabilities.

The current command uses `--exit-code 0`, so detected vulnerabilities are reported without failing the pipeline. This is an informational scan, not an enforced vulnerability policy.

### Manual Deployment

The `deploy` job is available only on the default branch and requires manual execution.

It prints a deployment message. It does not deploy the application to a production server.

## GitHub Actions Pipeline

The alternative GitHub Actions implementation contains six jobs:

| Job | Purpose |
|---|---|
| `lint` | Go formatting, vetting and test commands |
| `build` | Build and export a Docker image artifact |
| `test-image` | Load the artifact and run the smoke test |
| `security` | Run a Trivy vulnerability scan |
| `publish` | Publish the tested image to GitHub Container Registry |
| `deploy` | Simulate a manual deployment |

The GitHub workflow runs for pushes to `main` and `feature/**`, pull requests targeting `main`, and manual workflow dispatch events.

Publishing occurs on push events. Images receive a seven-character commit SHA tag, and `latest` is published only from `main`.

The registry location is:

```text
ghcr.io/l2e2v/module-08
```

The workflow authenticates using GitHub's automatically provided `GITHUB_TOKEN`.

The manual deployment job runs only when the workflow is manually dispatched from `main`.

## Verification Status

The GitHub Actions implementation has been executed successfully, including automated checks, image publication, and a manual deployment simulation.

The GitLab CI/CD configuration has been prepared according to the assignment requirements, but an end-to-end GitLab pipeline execution has not been verified. GitLab account verification restrictions prevented running the jobs.

Therefore, successful GitHub Actions runs demonstrate the operation of the application and the alternative CI/CD workflow, but they do not constitute proof of successful execution in GitLab.

The GitLab configuration still requires validation and execution in an eligible GitLab project with a properly configured Runner and Container Registry.

## Limitations

- Trivy vulnerability findings do not currently fail either pipeline.
- The deployment jobs are simulations, not production deployments.
- The repository does not currently provide dedicated Go unit-test coverage.
- GitLab pipeline execution remains unverified.

## CI/CD Platform Comparison

See [cicd-comparison.md](cicd-comparison.md) for a comparison of Jenkins, GitLab CI/CD, GitHub Actions, and TeamCity.

## References

- [GitLab CI/CD Documentation](https://docs.gitlab.com/ci/)
- [GitHub Actions Documentation](https://docs.github.com/actions)
- [Docker Documentation](https://docs.docker.com/)
- [Trivy Documentation](https://trivy.dev/)