# AGENTS.md

This repository contains a Kon-Tiki static site project following a unified
standard for tooling, build automation, and coding conventions. All projects
share the same conventions to keep sites consistent and maintainable.

The key components of the standard include:

- Build automation (Knut Haugland)
- Site generation (Bob)
- Infrastructure management (Terraform)
- Deployment (AWS S3)
- Data validation (JSON linting)

This document outlines the common conventions that apply across the Kon-Tiki
static site projects.

## Runtime & Dependencies

- **Node.js Version**: 22+
- **Dependency Manager**: npm
- **Infrastructure Tools**: Terraform + AWS CLI
- **Configuration Tooling**: yq

### Adding Dependencies

```bash
npm install package_name          # Add runtime dependency
npm install --save-dev pkg_name   # Add development dependency
make deps                         # Install all deps and stage dependencies
```

## Project Structure

```text
project/
├── config/                  # Infrastructure/backend configuration
├── data/                    # Site data files (JSON)
├── layouts/                 # Site layout templates
├── pages/                   # Page content
├── partials/                # Shared template partials
├── static/                  # Static assets
├── .bob.json                # Bob build tool configuration
├── .github/                 # GitHub workflows
├── buildspec.yml            # Build pipeline config
├── infrastructure.tf        # Terraform infrastructure definition
├── knut-haugland.yml        # Knut Haugland project configuration
├── Makefile                 # Build automation (Knut Haugland)
├── package.json             # npm package definition
└── README.md                # Project README
```

## Build Automation (Knut Haugland)

This project uses **Knut Haugland** as a standard build automation tool for
Kon-Tiki static site projects.

### Common Commands

```bash
make ci                 # Run lint + build + infra init checks
make all                # Full flow with infra apply/destroy and deploy
make clean              # Remove staged/generated/cache files
make deps               # Install dependencies and stage infra sources
make lint               # Validate JSON data files
make build              # Build site output
make deploy             # Deploy built site to S3
make infra-init         # Terraform init
make infra-plan         # Terraform plan
make infra-apply        # Terraform apply
make infra-destroy      # Terraform destroy
```

### Update Targets

```bash
make update-to-latest   # Update Makefile to latest Knut Haugland release
make update-to-main     # Update Makefile to Knut Haugland main branch
make update-to-version  # Update Makefile to a specific version
```

## Development Environment

This project is designed to be developed in a consistent environment via Docker
image `cliffano/studio`.

You can run the container using: `docker run --rm --workdir /opt/workspace -v /var/run/docker.sock:/var/run/docker.sock -v $PWD:/opt/workspace -i -t cliffano/studio` and then run the build commands inside the container.

## Code Style and Linting

- JSON data files are validated via `make lint`
- Workflow and build config changes should remain deterministic and minimal

### Kon-Tiki Code Guidelines

Applies to: `.github/workflows/**/*.yml`, `.github/workflows/**/*.yaml`, `buildspec.yml`, `data/**/*.json`, `knut-haugland.yml`, `params.js`, `infrastructure.tf`, `layouts/**/*.html`, `pages/**/*.md`, `partials/**/*.html`

#### Style & Formatting

##### Workflow and Build Config

All workflow and build configuration changes should stay explicit, readable, and
reproducible.

Guidelines:

- Use two-space indentation in YAML files
- Keep workflow/job/step names descriptive
- Avoid compact one-liners that hide intent in CI definitions
- Keep shell snippets readable and fail fast

##### Data Files

Data files should remain valid JSON:

```bash
make lint
```

Guidelines:

- Keep JSON keys stable and descriptive
- Prefer explicit objects over ambiguous arrays when feasible
- Keep data formatting consistent to reduce noisy diffs

#### Site Structure Conventions

- Keep reusable markup in `partials/`
- Keep high-level page composition in `layouts/` and `pages/`
- Keep configuration values in `knut-haugland.yml`
- Keep infrastructure changes in `infrastructure.tf` focused and reviewable

#### Infrastructure Conventions

- Keep Terraform changes small and composable
- Prefer explicit variable usage over hardcoded region/bucket values
- Ensure infra changes are validated with `make infra-plan` before apply

#### Validation

- Treat lint failures as build failures
- Validate site and infra flow with `make ci` before merging
- Keep workflow changes aligned with Makefile targets

## Testing

- This template emphasizes deterministic lint/build/infra checks
- Run validation with `make ci`

### Testing Guidelines

Applies to: `.github/workflows/**/*.yml`, `.github/workflows/**/*.yaml`

#### Validation Strategy

This template currently relies on deterministic validation via lint/build/infra
checks rather than dedicated unit test suites.

Primary validation command:

```bash
make ci
```

#### What to Validate

- JSON data integrity (`make lint`)
- Site build success (`make build`)
- Infrastructure initialization and planning (`make infra-init`, `make infra-plan`)
- Workflow execution consistency for CI and deployment flows

#### Workflow Test Practices

- Keep CI steps deterministic and idempotent
- Avoid network-dependent checks unless required by deployment behavior
- Fail fast on missing configuration values

#### Regression Prevention

When changing site generation, data model, or infrastructure behavior:

1. Run `make ci`
2. Run `make infra-plan` to inspect Terraform deltas
3. Run `make build` and verify generated output paths
