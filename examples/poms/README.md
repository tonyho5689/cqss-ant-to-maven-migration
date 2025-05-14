# CQSS Maven POM Files

This directory contains all the Maven POM files required to migrate the CQSS project from Ant to Maven.

## Parent POM

- [parent/pom.xml](pom.xml) - The main parent POM that defines common properties, dependency management, and plugin configuration

## Module POMs

- [CqssCommon/pom.xml](CqssCommon/pom.xml) - Common utilities and shared classes
- [CqssStartup/pom.xml](CqssStartup/pom.xml) - Application startup module
- [CqssVo/pom.xml](CqssVo/pom.xml) - Value Objects (VOs)
- [CqssDB/pom.xml](CqssDB/pom.xml) - Database access layer
- [CqssEjbUtil/pom.xml](CqssEjbUtil/pom.xml) - EJB utilities
- [CqssIntraEjb/pom.xml](CqssIntraEjb/pom.xml) - Intranet EJB module
- [CqssIntranetWeb/pom.xml](CqssIntranetWeb/pom.xml) - Intranet web application
- [CqssApplet/pom.xml](CqssApplet/pom.xml) - Java applet module
- [CqssBatchJobDB/pom.xml](CqssBatchJobDB/pom.xml) - Batch job database module
- [CqssSecurityAdmin/pom.xml](CqssSecurityAdmin/pom.xml) - Security administration module
- [CqssSvr/pom.xml](CqssSvr/pom.xml) - Server module
- [CqssEjbTestClient/pom.xml](CqssEjbTestClient/pom.xml) - EJB test client
- [CqssIntraEAR/pom.xml](CqssIntraEAR/pom.xml) - EAR packaging module for deployment
- [Ibator/pom.xml](Ibator/pom.xml) - iBATIS code generator module

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