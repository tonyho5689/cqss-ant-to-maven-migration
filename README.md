# CQSS Ant to Maven Migration

This repository contains guides and scripts to help migrate the CQSS project from an Ant-based build system to Maven.

## Contents

- [Comprehensive Migration Guide](docs/cqss-migration-guide.md): Complete step-by-step instructions for migrating the CQSS project
- [Install Dependencies Script](scripts/install-dependencies.sh): Script to install all required JARs to a local Maven repository
- [Source Reorganization Script](scripts/reorganize-source.sh): Script to help reorganize the source files from Ant to Maven structure
- [GitHub Upload Script](scripts/github-upload.sh): Script to initialize Git and push the migrated code to GitHub
- [Example POM Files](examples/poms/): Sample POM files for all modules in the CQSS project

## Getting Started

1. Read the [Comprehensive Migration Guide](docs/cqss-migration-guide.md) for complete instructions on the migration process
2. Use the scripts in the [scripts](scripts/) directory to help with the migration
3. Follow the step-by-step instructions in the guide to complete the migration

## Key Migration Steps

1. **Create Project Structure**: Set up the Maven directory structure for each module
2. **Create Local Maven Repository**: Install all dependencies to a local Maven repository
3. **Create POM Files**: Define the parent POM and module POMs with appropriate dependencies
4. **Reorganize Source Files**: Move source files to follow Maven's standard directory structure
5. **Update Configuration Files**: Ensure all configurations work with Maven's conventions
6. **Build with Maven**: Build the project using Maven
7. **Deploy the Application**: Deploy the generated EAR file to your server

## Prerequisites

- Java 8 JDK
- Maven 3.6+
- Git
- Original CQSS Ant-based project files

## Module Overview

The CQSS project consists of the following modules:

1. **cqss-common**: Common utilities and shared classes
2. **cqss-startup**: Application startup module
3. **cqss-vo**: Value Objects (VO)
4. **cqss-db**: Database access layer
5. **cqss-ejb-util**: EJB utility classes
6. **cqss-intra-ejb**: Intranet EJB module
7. **cqss-intranet-web**: Intranet web application
8. **cqss-applet**: Java applet module
9. **cqss-batch-job-db**: Batch job database module
10. **cqss-security-admin**: Security administration module
11. **cqss-svr**: Server module
12. **cqss-ear**: EAR packaging module

All POM templates for these modules are available in the [examples/poms](examples/poms/) directory.

## Dependency Management

The dependencies in this project are categorized into:

1. **Internal Dependencies**: Dependencies between CQSS modules
2. **Custom/Internal Libraries**: Application-specific libraries that must be installed to the local repository
3. **External Libraries**: Third-party libraries like Apache Commons, Spring, iBatis, etc.

All these dependencies are managed in the parent POM and installed to the local repository using the `install-dependencies.sh` script.
