# CQSS Ant to Maven Migration - Memory Bank

This document serves as a reference for key information about the CQSS project and its migration from Ant to Maven.

## Original Ant Project Structure

```
CqssApplet
CqssBatchJobDB
CqssCommon
CqssDB
CqssEjbTestClient
CqssEjbUtil
CqssIntraEAR
CqssIntraEjb
CqssIntranetWeb
CqssSecurityAdmin
CqssStartup
CqssSvr
CqssVo
Ibator
```

## Maven Project Structure

The Maven project structure uses the exact same naming convention as the original Ant modules:

```
cqss/
├── pom.xml                # Parent POM
├── CqssApplet/            # Java applet module
├── CqssBatchJobDB/        # Batch job database module
├── CqssCommon/            # Common utilities and shared classes
├── CqssDB/                # Database access layer
├── CqssEjbTestClient/     # EJB test client module
├── CqssEjbUtil/           # EJB utility classes
├── CqssIntraEjb/          # Intranet EJB module
├── CqssIntranetWeb/       # Intranet web application
├── CqssSecurityAdmin/     # Security administration module
├── CqssStartup/           # Application startup module
├── CqssSvr/               # Server module
├── CqssVo/                # Value Objects (VO)
├── CqssIntraEAR/          # EAR packaging module
└── Ibator/                # iBatis code generator (optional)
```

## Module Dependencies

- **CqssCommon**: Depends on logging libraries, WebSphere Core, CyberUtil
- **CqssStartup**: Depends on logging libraries, WebSphere Core
- **CqssVo**: Depends on Apache Commons, WebSphere API
- **CqssDB**: Depends on CqssVo, Spring, iBatis
- **CqssEjbUtil**: Depends on CqssCommon, Apache Commons, Spring, CyberUtil
- **CqssIntraEjb**: Depends on multiple CQSS modules, core libraries, Spring
- **CqssIntranetWeb**: Depends on CQSS modules, Struts, WebSphere libraries
- **CqssApplet**: Depends on JAWS library
- **CqssBatchJobDB**: Depends on CQSS modules, CyberUtil Batch libraries
- **CqssSecurityAdmin**: Depends on CyberUtil, database access libraries
- **CqssSvr**: Depends on CQSS modules, CyberUtil, Spring
- **CqssEjbTestClient**: Depends on EJB modules and test frameworks
- **CqssIntraEAR**: Depends on all modules and libraries for EAR packaging
- **Ibator**: Configuration for iBatis code generator (if needed)

## Key External Dependencies and Versions

- **Apache Commons**
  - commons-logging: 1.1.1
  - commons-beanutils: 1.8.0
  - commons-digester: 1.8
  - commons-codec: 1.3
  - commons-collections: 3.2.1
  - commons-lang: 2.4
  - commons-chain: 1.2
  - commons-validator: 1.3.1
  - commons-httpclient: 3.1
  - commons-configuration: 1.5
  - commons-fileupload: 1.2.1

- **Logging**
  - log4j: 1.2.14
  - slf4j: 1.6.1

- **Spring and Related**
  - spring: 2.5.5
  - aspectj: 1.6.1
  - antlr: 2.7.6

- **Database and ORM**
  - ibatis: 2.3.0.677
  - oracle (ojdbc8): 12.2.0.1
  - c3p0: 0.9.2.1

- **Other Third-Party**
  - jaxb: 2.3.0
  - jsr173: 1.0
  - activation: 1.1.1
  - jsch: 0.1.54
  - struts: 1.2.9
  - jakarta-oro: 2.0.8

## Custom/Internal Libraries (Version 1.0)

- **WNB Core**
  - app-core
  - app-msg
  - app-util

- **WebSphere Core**
  - ejb-common
  - wnb-log
  - ejb-intra-web-common
  - ejb-web-common
  - ejb-intra-common-scs
  - startup

- **CyberUtil WAS**
  - cyber-util-common-for-was
  - cyber-util-tools-for-was
  - cyber-util-for-was

- **CyberUtil Standalone/Batch**
  - cyber-util
  - cyber-util-common
  - cyber-util-tools
  - cyber-util-batch
  - cyber-util-batch-db
  - cyber-util-batch-vo
  - cyber-util-batch-job
  - cyber-util-batch-svr

- **Other**
  - hsm-common
  - jaws

## Migration Steps Summary

1. **Create Project Structure**: Set up Maven directory structure
2. **Install Dependencies**: Set up local Maven repository with all required JARs
3. **Create POM Files**: Define parent POM and module POMs
4. **Reorganize Source Files**: Move to Maven's standard directory structure
5. **Update Configuration Files**: Adapt configurations for Maven
6. **Build with Maven**: Use Maven to build the project
7. **Deploy Application**: Deploy the generated EAR file

## GitHub Repository Resources

- **Comprehensive Guide**: docs/cqss-migration-guide.md
- **Scripts**:
  - scripts/install-dependencies.sh
  - scripts/reorganize-source.sh
  - scripts/github-upload.sh
- **POM Examples**: examples/poms/
  - Parent POM: examples/poms/pom.xml
  - Module POMs: examples/poms/[module-name]/pom.xml

## Maven Command Reference

```bash
# Install a JAR to local repository
mvn install:install-file -Dfile=path/to/file.jar -DgroupId=group-id -DartifactId=artifact-id -Dversion=version -Dpackaging=jar -DlocalRepositoryPath=./cqss-repo/repository

# Build entire project
mvn clean install

# Build specific module
mvn clean install -pl module-name

# Skip tests
mvn clean install -DskipTests

# Build EAR only
mvn clean install -pl CqssIntraEAR
```