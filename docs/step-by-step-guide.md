# CQSS Ant to Maven Migration - Step-by-Step Guide

Based on the MANIFEST.MF files shown and the dependency relationships between modules, I've created this comprehensive guide for migrating the CQSS project from Ant to Maven. The guide has been updated to include all the dependencies identified in the MANIFEST.MF files.

## Step 1: Create Local Maven Repository for Dependencies

Since the project cannot use Nexus, we need to create a local repository for all external dependencies. The updated script `install-dependencies.sh` now handles the installation of all required libraries based on the MANIFEST.MF files examined.

The dependencies can be categorized into several groups:

1. **Core Application Libraries**
   - AppCore.jar, AppMsg.jar, AppUtil.jar
   - EjbCommon.jar, WnbLog.jar, etc.

2. **CyberUtil Libraries**
   - CyberUtilCommonForWas.jar, CyberUtilToolsForWas.jar, CyberUtilForWas.jar
   - CyberUtil.jar, CyberUtilCommon.jar, CyberUtilTools.jar, etc.

3. **Apache Commons Libraries**
   - commons-beanutils.jar, commons-chain-1.2.jar, commons-codec-1.3.jar
   - commons-collections-3.2.1.jar, commons-configuration-1.5.zip, etc.

4. **Spring and Related Libraries**
   - spring-2.5.5.jar, aspectjrt.jar, aspectjweaver.jar, antlr-2.7.6.jar

5. **Database and ORM Libraries**
   - ibatis-2.3.0.677_cy.jar, ojdbc8.jar, c3p0-0.9.2.1.jar

6. **Logging Libraries**
   - log4j.jar, slf4j-api-1.6.1.jar, slf4j-log4j12-1.6.1.jar

7. **Other Libraries**
   - HsmCommon.jar, JAXB libraries, struts.jar, etc.

Run the `install-dependencies.sh` script to install all these dependencies to your local Maven repository.

## Step 2: Create Maven Project Structure

Create the following directory structure for your Maven-based project:

```
cqss/
├── pom.xml (parent)
├── cqss-common/
├── cqss-startup/
├── cqss-vo/
├── cqss-db/
├── cqss-ejb-util/
├── cqss-intra-ejb/
├── cqss-intranet-web/
├── cqss-applet/
├── cqss-batch-job-db/
├── cqss-security-admin/
├── cqss-svr/
└── cqss-ear/
```

Each module should follow Maven's standard directory structure:

```
module/
├── pom.xml
└── src/
    └── main/
        ├── java/
        ├── resources/
        └── webapp/ (for web modules only)
```

## Step 3: Create Parent POM

Create a parent POM file at the root of your project based on the updated template in `examples/pom.xml`. This POM now includes all the dependencies identified in the MANIFEST.MF files.

Key features of the parent POM:
- Defines all modules in the project
- Sets up properties for dependency versions
- Configures the local Maven repository
- Manages all dependencies with appropriate versions
- Sets up build plugins for JAR, WAR, EAR, etc.

## Step 4: Create Module-specific POMs

For each module, create a POM file that extends the parent POM. The dependencies should be added based on the Class-Path entries in each module's MANIFEST.MF file.

Here are some examples based on the MANIFEST.MF files:

### cqss-ejb-util/pom.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <parent>
        <groupId>com.cqss</groupId>
        <artifactId>cqss-parent</artifactId>
        <version>1.0.0</version>
    </parent>

    <artifactId>cqss-ejb-util</artifactId>

    <dependencies>
        <!-- CyberUtil Libraries -->
        <dependency>
            <groupId>com.custom</groupId>
            <artifactId>cyber-util-common-for-was</artifactId>
        </dependency>
        <dependency>
            <groupId>com.custom</groupId>
            <artifactId>cyber-util-tools-for-was</artifactId>
        </dependency>
        <dependency>
            <groupId>com.custom</groupId>
            <artifactId>cyber-util-for-was</artifactId>
        </dependency>
        
        <!-- Spring Libraries -->
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring</artifactId>
        </dependency>
        <dependency>
            <groupId>org.aspectj</groupId>
            <artifactId>aspectjrt</artifactId>
        </dependency>
        <dependency>
            <groupId>org.aspectj</groupId>
            <artifactId>aspectjweaver</artifactId>
        </dependency>
        <dependency>
            <groupId>antlr</groupId>
            <artifactId>antlr</artifactId>
        </dependency>
        
        <!-- Apache Commons Libraries -->
        <dependency>
            <groupId>commons-digester</groupId>
            <artifactId>commons-digester</artifactId>
        </dependency>
        <dependency>
            <groupId>commons-beanutils</groupId>
            <artifactId>commons-beanutils</artifactId>
        </dependency>
        <!-- Add other Apache Commons dependencies as needed -->
        
        <!-- iBatis -->
        <dependency>
            <groupId>org.apache.ibatis</groupId>
            <artifactId>ibatis</artifactId>
        </dependency>
        
        <!-- Other Dependencies -->
        <dependency>
            <groupId>log4j</groupId>
            <artifactId>log4j</artifactId>
        </dependency>
    </dependencies>
</project>
```

### cqss-intra-ejb/pom.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <parent>
        <groupId>com.cqss</groupId>
        <artifactId>cqss-parent</artifactId>
        <version>1.0.0</version>
    </parent>

    <artifactId>cqss-intra-ejb</artifactId>
    <packaging>ejb</packaging>

    <dependencies>
        <!-- CQSS Module Dependencies -->
        <dependency>
            <groupId>com.cqss</groupId>
            <artifactId>cqss-ejb-util</artifactId>
        </dependency>
        <dependency>
            <groupId>com.cqss</groupId>
            <artifactId>cqss-db</artifactId>
        </dependency>
        <dependency>
            <groupId>com.cqss</groupId>
            <artifactId>cqss-vo</artifactId>
        </dependency>
        
        <!-- WNB Core Libraries -->
        <dependency>
            <groupId>com.custom</groupId>
            <artifactId>app-core</artifactId>
        </dependency>
        <dependency>
            <groupId>com.custom</groupId>
            <artifactId>app-msg</artifactId>
        </dependency>
        <dependency>
            <groupId>com.custom</groupId>
            <artifactId>app-util</artifactId>
        </dependency>
        <dependency>
            <groupId>com.custom</groupId>
            <artifactId>ejb-common</artifactId>
        </dependency>
        <dependency>
            <groupId>com.custom</groupId>
            <artifactId>ejb-intra-common-scs</artifactId>
        </dependency>
        
        <!-- CyberUtil Libraries -->
        <dependency>
            <groupId>com.custom</groupId>
            <artifactId>cyber-util-common-for-was</artifactId>
        </dependency>
        <dependency>
            <groupId>com.custom</groupId>
            <artifactId>cyber-util-tools-for-was</artifactId>
        </dependency>
        <dependency>
            <groupId>com.custom</groupId>
            <artifactId>cyber-util-for-was</artifactId>
        </dependency>
        
        <!-- Apache Commons Libraries -->
        <!-- Include all required Apache Commons dependencies -->
        
        <!-- HSM Common -->
        <dependency>
            <groupId>com.custom</groupId>
            <artifactId>hsm-common</artifactId>
        </dependency>
        
        <!-- WebSphere API -->
        <dependency>
            <groupId>com.ibm.websphere</groupId>
            <artifactId>websphere-api</artifactId>
            <scope>provided</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-ejb-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
```

## Step 5: Migrate Source Files

Use the `reorganize-source.sh` script to help reorganize your source files according to Maven's directory structure. The script will:

1. Create the necessary directory structure for each module
2. Copy Java files to `src/main/java/`
3. Copy resource files to `src/main/resources/`
4. Copy web content to `src/main/webapp/` for web modules
5. Handle special cases like application.xml for EAR modules

## Step 6: Update Configurations for Maven

Update any configuration files to work with Maven's directory structure:

1. Update paths in property files
2. Modify log4j configuration
3. Update resource paths in Java code if necessary

## Step 7: Build with Maven

Once you have set up the project structure, you can build it with Maven:

```bash
# Build the entire project
mvn clean install

# Build a specific module
mvn clean install -pl cqss-common

# Skip tests
mvn clean install -DskipTests
```

## Step 8: Create EAR File

The cqss-ear module will create an EAR file that includes all the necessary modules and dependencies. The EAR configuration should match the original Ant-based build.

```xml
<!-- cqss-ear/pom.xml -->
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-ear-plugin</artifactId>
    <configuration>
        <version>7</version>
        <defaultLibBundleDir>lib</defaultLibBundleDir>
        <modules>
            <webModule>
                <groupId>com.cqss</groupId>
                <artifactId>cqss-intranet-web</artifactId>
                <contextRoot>/cqss</contextRoot>
            </webModule>
            <ejbModule>
                <groupId>com.cqss</groupId>
                <artifactId>cqss-intra-ejb</artifactId>
            </ejbModule>
            <!-- Add other modules as needed -->
        </modules>
    </configuration>
</plugin>
```

## Step 9: Testing

Test the migrated application thoroughly to ensure it works as expected:

1. Deploy the generated EAR file to WebSphere Application Server
2. Test all functionality to ensure it works as expected
3. Compare with the original Ant-based build to ensure all components are included

## Step 10: Cleanup and Documentation

Clean up any temporary files and document the migration process:

1. Remove any temporary directories or files
2. Document the new build process for your team
3. Update any deployment scripts to use the Maven-generated artifacts

## Conclusion

This guide provides a comprehensive approach to migrating the CQSS project from Ant to Maven. By following these steps, you should be able to successfully convert your build system while maintaining all the dependencies and functionality of the original project.

The most important aspect is properly managing the dependencies as identified in the MANIFEST.MF files. The provided scripts and templates should help you automate much of this process, but careful attention to detail is required to ensure all dependencies are correctly configured.
