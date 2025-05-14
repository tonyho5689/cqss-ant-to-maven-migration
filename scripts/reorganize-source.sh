#!/bin/bash

# Script to reorganize the CQSS project files from Ant to Maven structure
# This script assumes you're running it from the project root directory

# Create the basic Maven project structure
mkdir -p cqss-parent
mkdir -p cqss-common/src/main/java
mkdir -p cqss-common/src/main/resources
mkdir -p cqss-startup/src/main/java
mkdir -p cqss-startup/src/main/resources
mkdir -p cqss-vo/src/main/java
mkdir -p cqss-vo/src/main/resources
mkdir -p cqss-db/src/main/java
mkdir -p cqss-db/src/main/resources
mkdir -p cqss-ejb-util/src/main/java
mkdir -p cqss-ejb-util/src/main/resources
mkdir -p cqss-intra-ejb/src/main/java
mkdir -p cqss-intra-ejb/src/main/resources
mkdir -p cqss-intranet-web/src/main/java
mkdir -p cqss-intranet-web/src/main/resources
mkdir -p cqss-intranet-web/src/main/webapp/WEB-INF
mkdir -p cqss-applet/src/main/java
mkdir -p cqss-applet/src/main/resources
mkdir -p cqss-batch-job-db/src/main/java
mkdir -p cqss-batch-job-db/src/main/resources
mkdir -p cqss-security-admin/src/main/java
mkdir -p cqss-security-admin/src/main/resources
mkdir -p cqss-svr/src/main/java
mkdir -p cqss-svr/src/main/resources
mkdir -p cqss-ear/src/main/application

echo "Created basic Maven directory structure"

# Function to copy Java files and non-Java resources to Maven structure
copy_module_files() {
    MODULE_NAME=$1
    MAVEN_MODULE=$2
    
    echo "Processing module ${MODULE_NAME} -> ${MAVEN_MODULE}"
    
    # Copy Java source files
    if [ -d "Source/${MODULE_NAME}/src" ]; then
        find "Source/${MODULE_NAME}/src" -name "*.java" -exec cp --parents {} "${MAVEN_MODULE}/src/main/java/" \;
        echo "  Copied Java files from Source/${MODULE_NAME}/src to ${MAVEN_MODULE}/src/main/java/"
    elif [ -d "Source/${MODULE_NAME}/ejbModule" ]; then
        find "Source/${MODULE_NAME}/ejbModule" -name "*.java" -exec cp --parents {} "${MAVEN_MODULE}/src/main/java/" \;
        echo "  Copied Java files from Source/${MODULE_NAME}/ejbModule to ${MAVEN_MODULE}/src/main/java/"
    fi
    
    # Copy resource files (properties, xml, etc.)
    if [ -d "Source/${MODULE_NAME}/src" ]; then
        find "Source/${MODULE_NAME}/src" -name "*.properties" -o -name "*.xml" -o -name "*.txt" -o -name "*.config" -o -name "*.MF" \
        | grep -v ".java$" | xargs -I{} cp --parents {} "${MAVEN_MODULE}/src/main/resources/"
        echo "  Copied resource files from Source/${MODULE_NAME}/src to ${MAVEN_MODULE}/src/main/resources/"
    elif [ -d "Source/${MODULE_NAME}/ejbModule" ]; then
        find "Source/${MODULE_NAME}/ejbModule" -name "*.properties" -o -name "*.xml" -o -name "*.txt" -o -name "*.config" -o -name "*.MF" \
        | grep -v ".java$" | xargs -I{} cp --parents {} "${MAVEN_MODULE}/src/main/resources/"
        echo "  Copied resource files from Source/${MODULE_NAME}/ejbModule to ${MAVEN_MODULE}/src/main/resources/"
    fi
    
    # For Web module, copy web content
    if [ "${MODULE_NAME}" = "CqssIntranetWeb" ]; then
        if [ -d "Source/${MODULE_NAME}/WebContent" ]; then
            cp -r "Source/${MODULE_NAME}/WebContent/"* "${MAVEN_MODULE}/src/main/webapp/"
            # Move web.xml to WEB-INF
            mkdir -p "${MAVEN_MODULE}/src/main/webapp/WEB-INF"
            if [ -f "Source/${MODULE_NAME}/WebContent/Web-inf/web.xml" ]; then
                cp "Source/${MODULE_NAME}/WebContent/Web-inf/web.xml" "${MAVEN_MODULE}/src/main/webapp/WEB-INF/"
            fi
            echo "  Copied web content from Source/${MODULE_NAME}/WebContent to ${MAVEN_MODULE}/src/main/webapp/"
        fi
    fi
    
    # For EAR module, copy application.xml
    if [ "${MODULE_NAME}" = "CqssIntraEAR" ]; then
        if [ -d "Source/${MODULE_NAME}/meta-inf" ]; then
            mkdir -p "${MAVEN_MODULE}/src/main/application/META-INF"
            cp "Source/${MODULE_NAME}/meta-inf/application.xml" "${MAVEN_MODULE}/src/main/application/META-INF/"
            echo "  Copied application.xml from Source/${MODULE_NAME}/meta-inf to ${MAVEN_MODULE}/src/main/application/META-INF/"
        fi
    fi
}

# Copy each module's files to the Maven structure
copy_module_files "CqssCommon" "cqss-common"
copy_module_files "CqssStartup" "cqss-startup"
copy_module_files "CqssVo" "cqss-vo"
copy_module_files "CqssDB" "cqss-db"
copy_module_files "CqssEjbUtil" "cqss-ejb-util"
copy_module_files "CqssIntraEjb" "cqss-intra-ejb"
copy_module_files "CqssIntranetWeb" "cqss-intranet-web"
copy_module_files "CqssApplet" "cqss-applet"
copy_module_files "CqssBatchJobDB" "cqss-batch-job-db"
copy_module_files "CqssSecurityAdmin" "cqss-security-admin"
copy_module_files "CqssSvr" "cqss-svr"
copy_module_files "CqssIntraEAR" "cqss-ear"

echo "Finished copying module files to Maven structure"
echo "Please review the files and adjust package names if necessary"

# Now copy the POM files (these would be created separately)
cp pom.xml ./
cp cqss-common-pom.xml cqss-common/pom.xml
cp cqss-startup-pom.xml cqss-startup/pom.xml
cp cqss-vo-pom.xml cqss-vo/pom.xml
cp cqss-db-pom.xml cqss-db/pom.xml
cp cqss-ejb-util-pom.xml cqss-ejb-util/pom.xml
cp cqss-intra-ejb-pom.xml cqss-intra-ejb/pom.xml
cp cqss-intranet-web-pom.xml cqss-intranet-web/pom.xml
cp cqss-applet-pom.xml cqss-applet/pom.xml
cp cqss-batch-job-db-pom.xml cqss-batch-job-db/pom.xml
cp cqss-security-admin-pom.xml cqss-security-admin/pom.xml
cp cqss-svr-pom.xml cqss-svr/pom.xml
cp cqss-ear-pom.xml cqss-ear/pom.xml

echo "Copied POM files to each module"
echo "Source code reorganization complete"