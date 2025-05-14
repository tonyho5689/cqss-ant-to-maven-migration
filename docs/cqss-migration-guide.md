# CQSS Ant to Maven Migration - Comprehensive Guide

This guide provides detailed, step-by-step instructions for migrating the CQSS project from Ant to Maven, based on the analysis of the project structure and MANIFEST.MF files.

## Overview

The CQSS project consists of multiple modules with dependencies on both internal and external libraries. This migration will:

1. Create a Maven project structure
2. Set up a local Maven repository for dependencies
3. Configure POM files for each module
4. Reorganize source files according to Maven conventions
5. Build the project with Maven

## Project Modules

Based on the project analysis, CQSS consists of the following modules:

1. **cqss-common** - Common utilities and shared classes
2. **cqss-startup** - Application startup module
3. **cqss-vo** - Value Objects (VO)
4. **cqss-db** - Database access layer
5. **cqss-ejb-util** - EJB utility classes
6. **cqss-intra-ejb** - Intranet EJB module
7. **cqss-intranet-web** - Intranet web application
8. **cqss-applet** - Java applet module
9. **cqss-batch-job-db** - Batch job database module
10. **cqss-security-admin** - Security administration module
11. **cqss-svr** - Server module
12. **cqss-ear** - EAR packaging module

## Step 1: Create Project Structure

Create the following directory structure for your Maven project:

```
cqss/
├── pom.xml                 # Parent POM
├── cqss-common/
│   └── pom.xml
├── cqss-startup/
│   └── pom.xml
├── cqss-vo/
│   └── pom.xml
├── cqss-db/
│   └── pom.xml
├── cqss-ejb-util/
│   └── pom.xml
├── cqss-intra-ejb/
│   └── pom.xml
├── cqss-intranet-web/
│   └── pom.xml
├── cqss-applet/
│   └── pom.xml
├── cqss-batch-job-db/
│   └── pom.xml
├── cqss-security-admin/
│   └── pom.xml
├── cqss-svr/
│   └── pom.xml
└── cqss-ear/
    └── pom.xml
```

Each module should follow Maven's standard directory structure:

```
module/
├── pom.xml
└── src/
    └── main/
        ├── java/       # Java source files
        ├── resources/  # Configuration files, properties, etc.
        └── webapp/     # For web modules only
```

## Step 2: Create Local Maven Repository for Dependencies

Since the project cannot use Nexus, create a local repository for dependencies using the provided `install-dependencies.sh` script:

```bash
# Create the script directory
mkdir -p scripts

# Copy the install-dependencies.sh script to the scripts directory
# Execute the script to install all required dependencies
cd scripts
chmod +x install-dependencies.sh
./install-dependencies.sh
```

The script will install the following types of dependencies:

1. **WNB Core Libraries**: AppCore.jar, AppMsg.jar, AppUtil.jar
2. **WebSphere Libraries**: EjbCommon.jar, WnbLog.jar, etc.
3. **SCS Libraries**: EjbIntraCommonScs.jar
4. **CyberUtil Libraries**: Both WebSphere and standalone versions
5. **Apache Commons Libraries**: Various Commons components
6. **Spring and Related Libraries**: Spring, AspectJ, ANTLR
7. **Database Libraries**: iBatis, Oracle JDBC
8. **Other Third-Party Libraries**: JAXB, Struts, etc.

## Step 3: Create POM Files

### Parent POM

Create a parent POM file in the root directory (pom.xml) that:
- Defines all modules
- Sets up common properties for versions
- Configures the local Maven repository
- Manages dependencies with consistent versions
- Sets up build plugins

You can use the provided example parent POM as a template.

### Module POMs

Create individual POM files for each module, based on their dependencies seen in the MANIFEST.MF files. Here's what each module generally requires:

1. **cqss-common**: Logging, WebSphere Core, CyberUtil
2. **cqss-startup**: Logging, WebSphere libraries
3. **cqss-vo**: Apache Commons, WebSphere API
4. **cqss-db**: cqss-vo, Spring, iBatis
5. **cqss-ejb-util**: cqss-common, Apache Commons, Spring, CyberUtil
6. **cqss-intra-ejb**: Multiple CQSS modules, core libraries, Spring
7. **cqss-intranet-web**: CQSS modules, Struts, WebSphere libraries
8. **cqss-applet**: JAWS library
9. **cqss-batch-job-db**: CQSS modules, CyberUtil Batch libraries
10. **cqss-security-admin**: CyberUtil, database access
11. **cqss-svr**: CQSS modules, CyberUtil, Spring
12. **cqss-ear**: All modules and libraries needed for the EAR package

All the necessary POM files have been created and are available in the examples/poms directory. Copy these to their respective locations in your project.

## Step 4: Reorganize Source Files

Use the provided `reorganize-source.sh` script to help move your source files to follow Maven's directory structure:

```bash
# Copy the reorganize-source.sh script to the scripts directory
chmod +x reorganize-source.sh
./reorganize-source.sh
```

This script will:
1. Create the necessary directory structure for each module
2. Copy Java files to `src/main/java/`
3. Copy resource files to `src/main/resources/`
4. Copy web content to `src/main/webapp/` for web modules
5. Handle special cases like application.xml for the EAR module

## Step 5: Update Configuration Files

Review and update any configuration files to ensure they work with Maven's directory structure:

1. Update paths in properties files
2. Modify log4j configuration if needed
3. Check for hardcoded paths that may need to be changed

## Step 6: Build with Maven

Once everything is set up, build the project with Maven:

```bash
# Build the entire project
mvn clean install

# Build a specific module
mvn clean install -pl cqss-common

# Skip tests
mvn clean install -DskipTests
```

The build output should be similar to the original Ant build, but with a standardized Maven structure.

## Step 7: Deploy the Application

After building, you can find the EAR file in `cqss-ear/target/cqss-ear-1.0.0.ear`. Deploy this to your WebSphere Application Server.

## Module-Specific Configuration Notes

### cqss-applet

The applet module requires JAR signing. The POM includes the Maven Jarsigner Plugin with configuration for signing the JAR file.

### cqss-intra-ejb

This EJB module needs specific EJB configuration. The POM includes the Maven EJB Plugin with the appropriate settings.

### cqss-intranet-web

The web module requires specific configuration for the web application. The POM includes the Maven WAR Plugin with appropriate settings.

### cqss-ear

The EAR module configuration requires special attention to include all necessary modules and libraries. The POM includes the Maven EAR Plugin with settings for modules, context roots, etc.

## Handling Dependencies

All dependencies are categorized into:

1. **Internal Dependencies**: Dependencies between CQSS modules
2. **Custom/Internal Libraries**: Application-specific libraries installed to the local repository
3. **External Libraries**: Third-party libraries like Apache Commons, Spring, etc.

All versions are managed in the parent POM to ensure consistency across all modules.

## Troubleshooting

If you encounter issues during the migration:

1. **Missing Dependencies**: Make sure all JARs are properly installed in the local repository
2. **Path Issues**: Verify that the directory structure matches Maven's conventions
3. **Build Errors**: Check for specific module dependencies or configuration issues
4. **EAR Packaging**: Verify that all required libraries are included in the EAR module

## Conclusion

Following these steps should successfully migrate your CQSS project from Ant to Maven. The resulting build system will be more standardized, easier to maintain, and provide better dependency management.

All necessary files, including POM templates and scripts, are available in the repository to assist with this migration.
