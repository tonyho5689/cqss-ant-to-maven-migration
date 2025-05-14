# CQSS Ant to Maven Migration

This repository contains guides and scripts to help migrate the CQSS project from an Ant-based build system to Maven.

## Contents

- [Migration Guide](docs/migration-guide.md): Comprehensive guide for migrating the CQSS project from Ant to Maven
- [Install Dependencies Script](scripts/install-dependencies.sh): Script to install all required JARs to a local Maven repository
- [Source Reorganization Script](scripts/reorganize-source.sh): Script to help reorganize the source files from Ant to Maven structure
- [GitHub Upload Script](scripts/github-upload.sh): Script to initialize Git and push the migrated code to GitHub

## Getting Started

1. Read the [Migration Guide](docs/migration-guide.md) for a complete understanding of the migration process
2. Use the scripts in the [scripts](scripts/) directory to help with the migration
3. Follow the step-by-step instructions in the guide to complete the migration

## Prerequisites

- Java 8 JDK
- Maven 3.6+
- Git
- Original CQSS Ant-based project files