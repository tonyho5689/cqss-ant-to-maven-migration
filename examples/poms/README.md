# CQSS Maven POM Files

This directory contains all the Maven POM files required to migrate the CQSS project from Ant to Maven.

## Parent POM

- [parent/pom.xml](pom.xml) - The main parent POM that defines common properties, dependency management, and plugin configuration

## Module POMs

- [cqss-common/pom.xml](cqss-common/pom.xml) - Common utilities and shared classes
- [cqss-startup/pom.xml](cqss-startup/pom.xml) - Application startup module
- [cqss-vo/pom.xml](cqss-vo/pom.xml) - Value Objects (VOs)
- [cqss-db/pom.xml](cqss-db/pom.xml) - Database access layer
- [cqss-ejb-util/pom.xml](cqss-ejb-util/pom.xml) - EJB utilities
- [cqss-intra-ejb/pom.xml](cqss-intra-ejb/pom.xml) - Intranet EJB module
- [cqss-intranet-web/pom.xml](cqss-intranet-web/pom.xml) - Intranet web application
- [cqss-applet/pom.xml](cqss-applet/pom.xml) - Java applet module
- [cqss-batch-job-db/pom.xml](cqss-batch-job-db/pom.xml) - Batch job database module
- [cqss-security-admin/pom.xml](cqss-security-admin/pom.xml) - Security administration module
- [cqss-svr/pom.xml](cqss-svr/pom.xml) - Server module
- [cqss-ear/pom.xml](cqss-ear/pom.xml) - EAR packaging module for deployment

## Usage

1. Copy these POM files to their respective directories in your project structure
2. Run the install-dependencies.sh script to install all the required JARs to your local Maven repository
3. Use Maven to build the project: `mvn clean install`

## Dependencies

These POM files reference the following types of dependencies:

1. Internal modules (dependencies between CQSS modules)
2. Custom/Internal libraries (installed to local repo)
3. External libraries:
   - Apache Commons libraries
   - Spring Framework
   - iBatis
   - WebSphere libraries
   - Struts
   - Logging libraries
   - JAXB
   - Others

All dependencies are managed in the parent POM to ensure consistent versions across all modules.
