# CQSS Ant to Maven Migration

This repository contains guides and scripts to help migrate the CQSS project from an Ant-based build system to Maven.

## Contents

- [Migration Guide](docs/migration-guide.md): Comprehensive guide for migrating the CQSS project from Ant to Maven
- [Step-by-Step Guide](docs/step-by-step-guide.md): Detailed instructions based on examination of MANIFEST.MF files
- [Install Dependencies Script](scripts/install-dependencies.sh): Script to install all required JARs to a local Maven repository
- [Source Reorganization Script](scripts/reorganize-source.sh): Script to help reorganize the source files from Ant to Maven structure
- [GitHub Upload Script](scripts/github-upload.sh): Script to initialize Git and push the migrated code to GitHub
- [Example POM](examples/pom.xml): Sample parent POM file with comprehensive dependency management

## Getting Started

1. Read the [Step-by-Step Guide](docs/step-by-step-guide.md) for a complete understanding of the migration process
2. Examine the [Migration Guide](docs/migration-guide.md) for general principles and approach
3. Use the scripts in the [scripts](scripts/) directory to help with the migration
4. Use the [Example POM](examples/pom.xml) as a template for your parent POM

## Key Migration Steps

1. **Create Local Maven Repository**: Install all dependencies to a local Maven repository using the install-dependencies.sh script
2. **Create Maven Project Structure**: Set up the Maven directory structure for each module
3. **Create Parent POM**: Define the parent POM with all necessary dependencies and modules
4. **Create Module POMs**: Define module-specific POMs with appropriate dependencies
5. **Migrate Source Files**: Reorganize source files to follow Maven's standard directory structure
6. **Build with Maven**: Build the project using Maven
7. **Create EAR File**: Configure the ear module to generate the EAR file
8. **Test and Deploy**: Test the migrated application and deploy it to your server

## Prerequisites

- Java 8 JDK
- Maven 3.6+
- Git
- Original CQSS Ant-based project files

## Important Note about Dependencies

The dependencies identified in this migration are based on examining the MANIFEST.MF files of various modules. They include:

1. Core Application Libraries (AppCore.jar, AppMsg.jar, etc.)
2. CyberUtil Libraries (CyberUtilCommonForWas.jar, CyberUtilTools.jar, etc.)
3. Apache Commons Libraries (commons-beanutils.jar, commons-chain-1.2.jar, etc.)
4. Spring and Related Libraries (spring-2.5.5.jar, aspectjrt.jar, etc.)
5. Database Libraries (ibatis-2.3.0.677_cy.jar, ojdbc8.jar, etc.)
6. JAXB and Other Third-Party Libraries

All these dependencies are managed in the parent POM and installed to the local repository using the install-dependencies.sh script.
