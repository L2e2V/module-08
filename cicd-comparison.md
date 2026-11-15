
# CI/CD Systems Comparison

## Introduction

Continuous Integration and Continuous Delivery/Deployment (CI/CD) automate software integration, testing, building, and deployment.

This document compares four popular CI/CD platforms:

- Jenkins
- GitLab CI/CD
- GitHub Actions
- TeamCity

## 1. Jenkins

### Architecture

Jenkins uses a controller-agent architecture.

- Controller manages jobs, pipelines, credentials, and agents.
- Agents execute build and test tasks.
- Plugins extend functionality and integrate external tools.
- Pipelines are commonly described using a Jenkinsfile.

### Advantages

- Open-source and highly customizable.
- Large plugin ecosystem.
- Supports almost any programming language and build environment.
- Can run on-premises or in the cloud.
- Flexible agent configuration.

### Disadvantages

- Requires independent installation and maintenance.
- Plugin compatibility and updates can create operational issues.
- Security and access control require careful configuration.
- Complex pipelines may become difficult to maintain.

### Runners and execution

Jenkins uses agents connected to a controller.

Agents can run on virtual machines, physical servers, or containers. Execution can be distributed across multiple agents.

### Configuration format

Pipelines are defined using a Jenkinsfile, typically written in Groovy-based Declarative or Scripted Pipeline syntax.

### Learning curve

Medium to high. Basic pipelines are relatively simple, but administration, plugins, distributed execution, and security require additional knowledge.

### Ideal use cases

- Organizations requiring full control over CI/CD infrastructure.
- Complex and highly customized build workflows.
- Environments with many integrations and legacy systems.

## 2. GitLab CI/CD

### Architecture

GitLab CI/CD is integrated into the GitLab platform.

- GitLab manages repositories, pipelines, jobs, and artifacts.
- GitLab Runners execute pipeline jobs.
- Jobs are grouped into stages.
- Pipelines can be triggered by pushes, merge requests, schedules, tags, or manual actions.
- Container Registry provides integrated image storage.

### Advantages

- Native integration with GitLab repositories and merge requests.
- YAML-based pipeline configuration.
- Built-in artifacts, caching, environments, and container registry.
- Supports shared and self-managed runners.
- Integrated security scanning and deployment features.

### Disadvantages

- Advanced functionality may depend on the GitLab subscription tier.
- Runner administration is necessary for self-managed execution.
- Complex YAML configurations can become difficult to maintain.
- Pipeline execution depends on runner availability and capacity.

### Runners and execution

GitLab Runner is an independent application that executes jobs.

Supported executors include:

- Docker
- Shell
- Kubernetes
- Docker Machine (legacy executor)

Runners can be shared, group-level, or project-specific, depending on configuration and permissions.

### Configuration format

Pipelines are defined in `.gitlab-ci.yml` using YAML.

The configuration supports stages, jobs, variables, rules, artifacts, caches, services, and dependencies.

### Learning curve

Low to medium. Basic pipelines are easy to understand, while advanced runner configuration and pipeline optimization require additional experience.

### Ideal use cases

- Projects hosted on GitLab.
- Teams requiring integrated repository management and CI/CD.
- Container-based build and deployment workflows.
- Organizations using merge-request-driven development.

## 3. GitHub Actions

### Architecture

GitHub Actions is integrated into GitHub.

- Workflows are triggered by repository events.
- Jobs contain individual steps.
- Jobs execute on GitHub-hosted or self-hosted runners.
- Actions provide reusable workflow components.

### Advantages

- Native GitHub integration.
- Large ecosystem of reusable actions.
- YAML-based configuration.
- Supports Linux, Windows, and macOS runners.
- Matrix builds simplify testing across multiple environments.

### Disadvantages

- Usage limits and billing depend on the subscription and runner type.
- Third-party actions require security and maintenance review.
- Complex workflows can become difficult to debug.
- Some advanced workflows require self-hosted infrastructure.

### Runners and execution

GitHub-hosted runners are managed by GitHub.

Self-hosted runners can run on physical servers, virtual machines, or containers.

Jobs can execute in parallel or depend on other jobs.

### Configuration format

Workflows are defined using YAML files stored in `.github/workflows/`.

Workflows consist of events, jobs, steps, and actions.

### Learning curve

Low to medium. Simple workflows are straightforward, while reusable workflows, permissions, and complex dependencies require additional knowledge.

### Ideal use cases

- Projects hosted on GitHub.
- Open-source software development.
- Automated testing and release workflows.
- Teams using reusable community actions.

## 4. TeamCity

### Architecture

TeamCity uses a server-agent architecture.

- TeamCity Server manages projects, configurations, and build queues.
- Build agents execute build steps.
- Build configurations define individual pipelines.
- Extensions and integrations provide additional functionality.

### Advantages

- Comprehensive build configuration and reporting.
- Strong integration with JetBrains development tools.
- Supports complex build chains and dependencies.
- Provides detailed build history and test reporting.
- Supports on-premises and cloud deployments.

### Disadvantages

- Requires infrastructure and server administration.
- Some advanced capabilities depend on licensing.
- Configuration can be more complex than simple hosted CI solutions.
- Build agents and server capacity require management.

### Runners and execution

TeamCity uses build agents connected to a TeamCity Server.

Agents can run on separate machines or in containers. Build agents can be assigned requirements and capabilities.

### Configuration format

Build configurations can be managed through the web interface or stored as versioned settings.

TeamCity Kotlin DSL allows configuration as code using Kotlin.

### Learning curve

Medium. Basic configurations are accessible, but build chains, agents, and Kotlin DSL require additional experience.

### Ideal use cases

- Organizations using JetBrains development tools.
- Enterprise projects with complex build chains.
- Teams requiring detailed build and test reporting.
- On-premises CI/CD environments.

## 5. Comparison Table

| Criterion | Jenkins | GitLab CI/CD | GitHub Actions | TeamCity |
|---|---|---|---|---|
| Architecture | Controller-agent | GitLab + Runner | Workflow + Runner | Server-agent |
| Advantages | Highly customizable; extensive plugin ecosystem; full infrastructure control | Integrated repository, CI/CD, Container Registry, and merge requests | Native GitHub integration; reusable actions; managed runners | Detailed reporting; complex build chains; JetBrains integration |
| Disadvantages | Requires maintenance; plugin compatibility issues; complex administration | Self-managed runners require administration; some features depend on subscription tier | Usage limits; third-party action risks; complex workflow debugging | Licensing considerations; infrastructure overhead; configuration complexity |
| Learning curve | Medium-high | Low-medium | Low-medium | Medium |
| Runner management | Self-managed agents connected to a controller | GitLab-hosted or self-managed runners | GitHub-hosted or self-hosted runners | Self-managed or cloud build agents |
| Configuration format | Jenkinsfile / Groovy | YAML (`.gitlab-ci.yml`) | YAML (`.github/workflows/`) | Web UI / Kotlin DSL |
| Ideal use case | Complex workflows requiring maximum customization and infrastructure control | GitLab-hosted projects requiring integrated CI/CD and container workflows | GitHub-hosted projects using automated testing and reusable actions | Enterprise projects requiring detailed build management and JetBrains integration |
| Hosting | Self-managed | SaaS / Self-managed | GitHub-hosted service / Self-hosted runners | Cloud / Self-managed |
| Extensibility | Plugins | Templates and integrations | Marketplace Actions | Plugins and integrations |
| Container support | Yes | Yes | Yes | Yes |
| Best integration | Broad ecosystem | GitLab | GitHub | JetBrains |

## 6. Final Conclusions

There is no universally best CI/CD platform. The appropriate choice depends on infrastructure, development workflows, security requirements, and budget.

- Jenkins is suitable when maximum flexibility and infrastructure control are required.
- GitLab CI/CD is a strong choice for teams using GitLab as their primary development platform.
- GitHub Actions is convenient for GitHub-hosted projects and workflows relying on reusable communiыty actions.
- TeamCity is suitable for organizations requiring detailed build management and integration with JetBrains.

For this assignment, GitLab CI/CD was selected as the primary target because it integrates repository management, merge requests, container registry, and pipeline execution within one platform.

Due to GitLab account verification restrictions, the GitLab pipeline could not be executed end-to-end. GitHub Actions was therefore implemented as an alternative CI/CD workflow and successfully used to verify the application build, container tests, security scanning, and image publication.


## References

- Jenkins: https://www.jenkins.io/doc/
- GitLab CI/CD: https://docs.gitlab.com/ci/
- GitHub Actions: https://docs.github.com/actions
- TeamCity: https://www.jetbrains.com/help/teamcity/
