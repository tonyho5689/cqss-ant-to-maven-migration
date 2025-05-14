# CQSS Ant to Maven Migration Guide

This document provides step-by-step instructions for migrating the CQSS project from Ant to Maven.

## Project Structure

Here's the proposed Maven structure:

```
cqss/
├── pom.xml (parent)
├── cqss-parent/ (dependency management)
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

## Step 1: Create Local Maven Repository for Dependencies

Since you cannot use Nexus, you'll need to create a local repository for external dependencies:

```bash
# Create a directory for the local repository
mkdir -p cqss-repo/repository

# Install external JARs to local repository
# Example:
mvn install:install-file -Dfile=path/to/commons-logging-1.1.1.jar -DgroupId=commons-logging -DartifactId=commons-logging -Dversion=1.1.1 -Dpackaging=jar -DlocalRepositoryPath=./cqss-repo/repository
```

Create a script to automate this for all required JARs.

## Step 2: Create Parent POM

Create a parent POM (pom.xml) in the root directory:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.cqss</groupId>
    <artifactId>cqss-parent</artifactId>
    <version>1.0.0</version>
    <packaging>pom</packaging>

    <modules>
        <module>cqss-common</module>
        <module>cqss-startup</module>
        <module>cqss-vo</module>
        <module>cqss-db</module>
        <module>cqss-ejb-util</module>
        <module>cqss-intra-ejb</module>
        <module>cqss-intranet-web</module>
        <module>cqss-applet</module>
        <module>cqss-batch-job-db</module>
        <module>cqss-security-admin</module>
        <module>cqss-svr</module>
        <module>cqss-ear</module>
    </modules>

    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <java.version>1.8</java.version>
        <maven.compiler.source>1.8</maven.compiler.source>
        <maven.compiler.target>1.8</maven.compiler.target>
        <commons.logging.version>1.1.1</commons.logging.version>
        <commons.beanutils.version>1.8.0</commons.beanutils.version>
        <commons.digester.version>1.8</commons.digester.version>
        <commons.codec.version>1.3</commons.codec.version>
        <commons.collections.version>3.2.1</commons.collections.version>
        <commons.lang.version>2.4</commons.lang.version>
        <commons.chain.version>1.2</commons.chain.version>
        <commons.validator.version>1.3.1</commons.validator.version>
        <log4j.version>1.2.14</log4j.version>
        <spring.version>2.5.5</spring.version>
        <aspectj.version>1.6.1</aspectj.version>
        <ibatis.version>2.3.0.677</ibatis.version>
        <was.version>9.0</was.version>
        <antlr.version>2.7.6</antlr.version>
    </properties>

    <repositories>
        <repository>
            <id>local-maven-repo</id>
            <url>file:///${project.basedir}/cqss-repo/repository</url>
        </repository>
    </repositories>

    <dependencyManagement>
        <dependencies>
            <!-- Internal Modules -->
            <dependency>
                <groupId>com.cqss</groupId>
                <artifactId>cqss-common</artifactId>
                <version>${project.version}</version>
            </dependency>
            <dependency>
                <groupId>com.cqss</groupId>
                <artifactId>cqss-startup</artifactId>
                <version>${project.version}</version>
            </dependency>
            <dependency>
                <groupId>com.cqss</groupId>
                <artifactId>cqss-vo</artifactId>
                <version>${project.version}</version>
            </dependency>
            <dependency>
                <groupId>com.cqss</groupId>
                <artifactId>cqss-db</artifactId>
                <version>${project.version}</version>
            </dependency>
            <dependency>
                <groupId>com.cqss</groupId>
                <artifactId>cqss-ejb-util</artifactId>
                <version>${project.version}</version>
            </dependency>
            <dependency>
                <groupId>com.cqss</groupId>
                <artifactId>cqss-intra-ejb</artifactId>
                <version>${project.version}</version>
            </dependency>
            <dependency>
                <groupId>com.cqss</groupId>
                <artifactId>cqss-intranet-web</artifactId>
                <version>${project.version}</version>
            </dependency>
            <dependency>
                <groupId>com.cqss</groupId>
                <artifactId>cqss-applet</artifactId>
                <version>${project.version}</version>
            </dependency>
            
            <!-- External Dependencies -->
            <dependency>
                <groupId>commons-logging</groupId>
                <artifactId>commons-logging</artifactId>
                <version>${commons.logging.version}</version>
            </dependency>
            <dependency>
                <groupId>commons-logging</groupId>
                <artifactId>commons-logging-api</artifactId>
                <version>${commons.logging.version}</version>
            </dependency>
            <dependency>
                <groupId>commons-logging</groupId>
                <artifactId>commons-logging-adapters</artifactId>
                <version>${commons.logging.version}</version>
            </dependency>
            <dependency>
                <groupId>commons-beanutils</groupId>
                <artifactId>commons-beanutils</artifactId>
                <version>${commons.beanutils.version}</version>
            </dependency>
            <dependency>
                <groupId>commons-digester</groupId>
                <artifactId>commons-digester</artifactId>
                <version>${commons.digester.version}</version>
            </dependency>
            <dependency>
                <groupId>commons-collections</groupId>
                <artifactId>commons-collections</artifactId>
                <version>${commons.collections.version}</version>
            </dependency>
            <dependency>
                <groupId>commons-lang</groupId>
                <artifactId>commons-lang</artifactId>
                <version>${commons.lang.version}</version>
            </dependency>
            <dependency>
                <groupId>commons-codec</groupId>
                <artifactId>commons-codec</artifactId>
                <version>${commons.codec.version}</version>
            </dependency>
            <dependency>
                <groupId>commons-chain</groupId>
                <artifactId>commons-chain</artifactId>
                <version>${commons.chain.version}</version>
            </dependency>
            <dependency>
                <groupId>commons-validator</groupId>
                <artifactId>commons-validator</artifactId>
                <version>${commons.validator.version}</version>
            </dependency>
            <dependency>
                <groupId>log4j</groupId>
                <artifactId>log4j</artifactId>
                <version>${log4j.version}</version>
            </dependency>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring</artifactId>
                <version>${spring.version}</version>
            </dependency>
            <dependency>
                <groupId>org.aspectj</groupId>
                <artifactId>aspectjrt</artifactId>
                <version>${aspectj.version}</version>
            </dependency>
            <dependency>
                <groupId>org.aspectj</groupId>
                <artifactId>aspectjweaver</artifactId>
                <version>${aspectj.version}</version>
            </dependency>
            <dependency>
                <groupId>org.apache.ibatis</groupId>
                <artifactId>ibatis</artifactId>
                <version>${ibatis.version}</version>
            </dependency>
            <dependency>
                <groupId>antlr</groupId>
                <artifactId>antlr</artifactId>
                <version>${antlr.version}</version>
            </dependency>
            
            <!-- Custom/Internal Libraries - Need to be installed to local repo -->
            <dependency>
                <groupId>com.custom</groupId>
                <artifactId>app-core</artifactId>
                <version>1.0</version>
            </dependency>
            <dependency>
                <groupId>com.custom</groupId>
                <artifactId>app-msg</artifactId>
                <version>1.0</version>
            </dependency>
            <dependency>
                <groupId>com.custom</groupId>
                <artifactId>app-util</artifactId>
                <version>1.0</version>
            </dependency>
            <dependency>
                <groupId>com.custom</groupId>
                <artifactId>ejb-common</artifactId>
                <version>1.0</version>
            </dependency>
            <dependency>
                <groupId>com.custom</groupId>
                <artifactId>wnb-log</artifactId>
                <version>1.0</version>
            </dependency>
            <dependency>
                <groupId>com.custom</groupId>
                <artifactId>cyber-util-common-for-was</artifactId>
                <version>1.0</version>
            </dependency>
            <dependency>
                <groupId>com.custom</groupId>
                <artifactId>cyber-util-tools-for-was</artifactId>
                <version>1.0</version>
            </dependency>
            <dependency>
                <groupId>com.custom</groupId>
                <artifactId>cyber-util-for-was</artifactId>
                <version>1.0</version>
            </dependency>
            <dependency>
                <groupId>com.custom</groupId>
                <artifactId>hsm-common</artifactId>
                <version>1.0</version>
            </dependency>
            
            <!-- WebSphere Dependencies -->
            <dependency>
                <groupId>com.ibm.websphere</groupId>
                <artifactId>websphere-api</artifactId>
                <version>${was.version}</version>
                <scope>provided</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>

    <build>
        <pluginManagement>
            <plugins>
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-compiler-plugin</artifactId>
                    <version>3.8.1</version>
                    <configuration>
                        <source>${java.version}</source>
                        <target>${java.version}</target>
                    </configuration>
                </plugin>
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-jar-plugin</artifactId>
                    <version>3.2.0</version>
                </plugin>
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-war-plugin</artifactId>
                    <version>3.3.1</version>
                </plugin>
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-ejb-plugin</artifactId>
                    <version>3.1.0</version>
                    <configuration>
                        <ejbVersion>3.0</ejbVersion>
                    </configuration>
                </plugin>
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-ear-plugin</artifactId>
                    <version>3.1.0</version>
                    <configuration>
                        <version>7</version>
                        <defaultLibBundleDir>lib</defaultLibBundleDir>
                    </configuration>
                </plugin>
            </plugins>
        </pluginManagement>
    </build>
</project>
```

## Step 3: Module POMs

For each module, create a POM file. Examples:

### cqss-common/pom.xml

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

    <artifactId>cqss-common</artifactId>

    <dependencies>
        <dependency>
            <groupId>commons-logging</groupId>
            <artifactId>commons-logging</artifactId>
        </dependency>
        <dependency>
            <groupId>log4j</groupId>
            <artifactId>log4j</artifactId>
        </dependency>
        <dependency>
            <groupId>com.custom</groupId>
            <artifactId>ejb-common</artifactId>
        </dependency>
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
            <artifactId>cyber-util-common-for-was</artifactId>
        </dependency>
        <dependency>
            <groupId>com.ibm.websphere</groupId>
            <artifactId>websphere-api</artifactId>
            <scope>provided</scope>
        </dependency>
    </dependencies>
</project>
```

### cqss-vo/pom.xml

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

    <artifactId>cqss-vo</artifactId>

    <dependencies>
        <dependency>
            <groupId>commons-beanutils</groupId>
            <artifactId>commons-beanutils</artifactId>
        </dependency>
        <dependency>
            <groupId>commons-logging</groupId>
            <artifactId>commons-logging</artifactId>
        </dependency>
        <dependency>
            <groupId>com.ibm.websphere</groupId>
            <artifactId>websphere-api</artifactId>
            <scope>provided</scope>
        </dependency>
    </dependencies>
</project>
```

### cqss-db/pom.xml

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

    <artifactId>cqss-db</artifactId>

    <dependencies>
        <dependency>
            <groupId>com.cqss</groupId>
            <artifactId>cqss-vo</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring</artifactId>
        </dependency>
        <dependency>
            <groupId>org.apache.ibatis</groupId>
            <artifactId>ibatis</artifactId>
        </dependency>
        <dependency>
            <groupId>com.ibm.websphere</groupId>
            <artifactId>websphere-api</artifactId>
            <scope>provided</scope>
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
        <dependency>
            <groupId>com.cqss</groupId>
            <artifactId>cqss-common</artifactId>
        </dependency>
        <dependency>
            <groupId>com.cqss</groupId>
            <artifactId>cqss-vo</artifactId>
        </dependency>
        <dependency>
            <groupId>com.cqss</groupId>
            <artifactId>cqss-db</artifactId>
        </dependency>
        <dependency>
            <groupId>com.cqss</groupId>
            <artifactId>cqss-ejb-util</artifactId>
        </dependency>
        <dependency>
            <groupId>commons-chain</groupId>
            <artifactId>commons-chain</artifactId>
        </dependency>
        <dependency>
            <groupId>commons-logging</groupId>
            <artifactId>commons-logging</artifactId>
        </dependency>
        <dependency>
            <groupId>commons-lang</groupId>
            <artifactId>commons-lang</artifactId>
        </dependency>
        <dependency>
            <groupId>commons-collections</groupId>
            <artifactId>commons-collections</artifactId>
        </dependency>
        <dependency>
            <groupId>commons-validator</groupId>
            <artifactId>commons-validator</artifactId>
        </dependency>
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
        <dependency>
            <groupId>com.custom</groupId>
            <artifactId>hsm-common</artifactId>
        </dependency>
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

### cqss-intranet-web/pom.xml

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

    <artifactId>cqss-intranet-web</artifactId>
    <packaging>war</packaging>

    <dependencies>
        <dependency>
            <groupId>com.cqss</groupId>
            <artifactId>cqss-common</artifactId>
        </dependency>
        <dependency>
            <groupId>com.cqss</groupId>
            <artifactId>cqss-applet</artifactId>
        </dependency>
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
            <artifactId>ejb-intra-web-common</artifactId>
            <version>1.0</version>
        </dependency>
        <dependency>
            <groupId>com.custom</groupId>
            <artifactId>ejb-web-common</artifactId>
            <version>1.0</version>
        </dependency>
        <dependency>
            <groupId>com.custom</groupId>
            <artifactId>cyber-util-common-for-was</artifactId>
        </dependency>
        <dependency>
            <groupId>struts</groupId>
            <artifactId>struts</artifactId>
            <version>1.2.9</version>
        </dependency>
        <dependency>
            <groupId>commons-beanutils</groupId>
            <artifactId>commons-beanutils</artifactId>
        </dependency>
        <dependency>
            <groupId>commons-digester</groupId>
            <artifactId>commons-digester</artifactId>
        </dependency>
        <dependency>
            <groupId>commons-logging</groupId>
            <artifactId>commons-logging</artifactId>
        </dependency>
        <dependency>
            <groupId>commons-validator</groupId>
            <artifactId>commons-validator</artifactId>
        </dependency>
        <dependency>
            <groupId>jakarta-oro</groupId>
            <artifactId>jakarta-oro</artifactId>
            <version>2.0.8</version>
        </dependency>
        <dependency>
            <groupId>commons-fileupload</groupId>
            <artifactId>commons-fileupload</artifactId>
            <version>1.2.1</version>
        </dependency>
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
                <artifactId>maven-war-plugin</artifactId>
                <configuration>
                    <webXml>${basedir}/src/main/webapp/WEB-INF/web.xml</webXml>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
```

### cqss-ear/pom.xml

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

    <artifactId>cqss-ear</artifactId>
    <packaging>ear</packaging>

    <dependencies>
        <dependency>
            <groupId>com.cqss</groupId>
            <artifactId>cqss-intranet-web</artifactId>
            <type>war</type>
        </dependency>
        <dependency>
            <groupId>com.cqss</groupId>
            <artifactId>cqss-intra-ejb</artifactId>
            <type>ejb</type>
        </dependency>
        <dependency>
            <groupId>com.cqss</groupId>
            <artifactId>cqss-ejb-util</artifactId>
        </dependency>
        <dependency>
            <groupId>com.cqss</groupId>
            <artifactId>cqss-vo</artifactId>
        </dependency>
        <dependency>
            <groupId>com.cqss</groupId>
            <artifactId>cqss-db</artifactId>
        </dependency>
        <dependency>
            <groupId>com.cqss</groupId>
            <artifactId>cqss-common</artifactId>
        </dependency>
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
        <!-- Add all other dependencies required in the EAR -->
    </dependencies>

    <build>
        <plugins>
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
                    </modules>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
```

## Step 4: Directory Structure Migration

Follow these steps to migrate your source code into the Maven directory structure:

1. For each module, create the standard Maven directory structure:
   ```
   src/main/java/ - Java source files
   src/main/resources/ - Configuration files, properties, etc.
   src/main/webapp/ - For web modules only
   ```

2. Move source files:
   - Move Java files from Source/{Module}/src to src/main/java/
   - Move resources from Source/{Module}/src to src/main/resources/
   - For web modules, move web content from Source/{Module}/WebContent to src/main/webapp/

3. Make necessary adjustments:
   - Update package names if needed
   - Fix import statements
   - Update configuration files paths

## Step 5: Dependencies Installation Script

Create a script to install all dependencies to the local repository:

```bash
#!/bin/bash

# Directory where JAR files are stored
LIBS_DIR="../Deploy/Was9/Libraries"

# Local repository path
LOCAL_REPO="./cqss-repo/repository"

# Install core libraries
mvn install:install-file -Dfile="$LIBS_DIR/WnbCore/Core/AppCore.jar" -DgroupId=com.custom -DartifactId=app-core -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="$LOCAL_REPO"
mvn install:install-file -Dfile="$LIBS_DIR/WnbCore/Core/AppMsg.jar" -DgroupId=com.custom -DartifactId=app-msg -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="$LOCAL_REPO"
mvn install:install-file -Dfile="$LIBS_DIR/WnbCore/Core/AppUtil.jar" -DgroupId=com.custom -DartifactId=app-util -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="$LOCAL_REPO"

# Install WebSphere libraries
mvn install:install-file -Dfile="$LIBS_DIR/WnbWas/WasCore/EjbCommon.jar" -DgroupId=com.custom -DartifactId=ejb-common -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="$LOCAL_REPO"
mvn install:install-file -Dfile="$LIBS_DIR/WnbWas/WasCore/WnbLog.jar" -DgroupId=com.custom -DartifactId=wnb-log -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="$LOCAL_REPO"
mvn install:install-file -Dfile="$LIBS_DIR/WnbWas/WasCore/EjbIntraWebCommon.jar" -DgroupId=com.custom -DartifactId=ejb-intra-web-common -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="$LOCAL_REPO"
mvn install:install-file -Dfile="$LIBS_DIR/WnbWas/WasCore/EjbWebCommon.jar" -DgroupId=com.custom -DartifactId=ejb-web-common -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="$LOCAL_REPO"

# Install SCS libraries
mvn install:install-file -Dfile="$LIBS_DIR/WnbWas/Scs/EjbIntraCommonScs.jar" -DgroupId=com.custom -DartifactId=ejb-intra-common-scs -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="$LOCAL_REPO"

# Install CyberUtil libraries
mvn install:install-file -Dfile="../../../btss/btss/Deploy/lib/CyberUtilCommonForWas.jar" -DgroupId=com.custom -DartifactId=cyber-util-common-for-was -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="$LOCAL_REPO"
mvn install:install-file -Dfile="../../../btss/btss/Deploy/lib/CyberUtilToolsForWas.jar" -DgroupId=com.custom -DartifactId=cyber-util-tools-for-was -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="$LOCAL_REPO"
mvn install:install-file -Dfile="../../../btss/btss/Deploy/lib/CyberUtilForWas.jar" -DgroupId=com.custom -DartifactId=cyber-util-for-was -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="$LOCAL_REPO"

# Install HSM libraries
mvn install:install-file -Dfile="../Deploy/lib/external/hsm/HsmCommon.jar" -DgroupId=com.custom -DartifactId=hsm-common -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="$LOCAL_REPO"

# Install Apache Commons libraries
mvn install:install-file -Dfile="../Deploy/lib/external/apache/common/commons-logging-1.1.1.jar" -DgroupId=commons-logging -DartifactId=commons-logging -Dversion=1.1.1 -Dpackaging=jar -DlocalRepositoryPath="$LOCAL_REPO"
# ... add all other libraries

# Install WebSphere API (mock it if not available)
# It's usually better to use the provided scope and reference the real JAR during build
mvn install:install-file -Dfile="path/to/websphere/api.jar" -DgroupId=com.ibm.websphere -DartifactId=websphere-api -Dversion=9.0 -Dpackaging=jar -DlocalRepositoryPath="$LOCAL_REPO"
```

## Step 6: Build Scripts

Create a main build script that replaces the original Ant scripts:

```bash
#!/bin/bash

# Clean and build all modules
mvn clean install
```

## Step 7: Testing the Migration

1. Build individual modules:
   ```bash
   mvn clean install -pl cqss-common
   mvn clean install -pl cqss-vo
   ```

2. Build the entire project:
   ```bash
   mvn clean install
   ```

3. Check the output EAR file:
   ```bash
   ls -l cqss-ear/target/cqss-ear-1.0.0.ear
   ```

## Step 8: GitHub Upload Instructions

1. Initialize Git repository:
   ```bash
   git init
   git add .
   git commit -m "Initial commit - Migrated from Ant to Maven"
   ```

2. Create GitHub repository and push:
   ```bash
   git remote add origin https://github.com/username/cqss.git
   git push -u origin master
   ```

## Step 9: Additional Tips

1. Use Maven plugins to further customize the build process
2. Consider setting up a CI/CD pipeline
3. Add unit tests and use the Maven Surefire plugin
4. Consider migrating to more recent library versions where applicable