#!/bin/bash
# Script to reorganize source files from Ant structure to Maven structure

set -e  # Exit on error

# Source and destination directories
SOURCE_BASE="../"
MAVEN_BASE="."

# Function to create Maven directories
create_maven_dirs() {
    local MODULE=$1
    mkdir -p $MAVEN_BASE/$MODULE/src/main/java
    mkdir -p $MAVEN_BASE/$MODULE/src/main/resources
    mkdir -p $MAVEN_BASE/$MODULE/src/test/java
    mkdir -p $MAVEN_BASE/$MODULE/src/test/resources
    
    # Create webapp directory for web modules
    if [[ "$MODULE" == "CqssIntranetWeb" ]]; then
        mkdir -p $MAVEN_BASE/$MODULE/src/main/webapp
    fi
}

# Function to copy Java files
copy_java_files() {
    local MODULE=$1
    local SRC_DIR=$2
    local DEST_DIR=$MAVEN_BASE/$MODULE/src/main/java
    
    echo "Copying Java files from $SRC_DIR to $DEST_DIR"
    
    # Find all Java files and copy them, preserving directory structure
    find $SRC_DIR -name "*.java" -type f | while read file; do
        # Get relative path from source directory
        rel_path=${file#$SRC_DIR/}
        dest_file=$DEST_DIR/$rel_path
        mkdir -p $(dirname $dest_file)
        cp $file $dest_file
    done
}

# Function to copy resource files
copy_resource_files() {
    local MODULE=$1
    local SRC_DIR=$2
    local DEST_DIR=$MAVEN_BASE/$MODULE/src/main/resources
    
    echo "Copying resource files from $SRC_DIR to $DEST_DIR"
    
    # Find all non-Java files except specific exclusions and copy them
    find $SRC_DIR -type f \( -not -name "*.java" -and -not -name "*.contrib" -and -not -name "*.keep" \
        -and -not -name "*.mkelem" -and -not -name "*.checkout" -and -not -name "*.unloaded" \
        -and -not -name "vssver.scc" \) | while read file; do
        # Get relative path from source directory
        rel_path=${file#$SRC_DIR/}
        dest_file=$DEST_DIR/$rel_path
        mkdir -p $(dirname $dest_file)
        cp $file $dest_file
    done
}

# Function to copy web content
copy_web_content() {
    local SRC_DIR=$1
    local DEST_DIR=$MAVEN_BASE/CqssIntranetWeb/src/main/webapp
    
    echo "Copying web content from $SRC_DIR to $DEST_DIR"
    
    # Find all web content files except specific exclusions and copy them
    find $SRC_DIR -type f \( -not -name "*.class" -and -not -name "*.contrib" -and -not -name "*.keep" \
        -and -not -name "*.mkelem" -and -not -name "*.checkout" -and -not -name "*.unloaded" \
        -and -not -name "vssver.scc" \) | while read file; do
        # Get relative path from source directory
        rel_path=${file#$SRC_DIR/}
        dest_file=$DEST_DIR/$rel_path
        mkdir -p $(dirname $dest_file)
        cp $file $dest_file
    done
    
    # Special handling for web.xml
    if [ -f "$SRC_DIR/Web-inf/web.xml" ]; then
        mkdir -p $DEST_DIR/WEB-INF
        cp $SRC_DIR/Web-inf/web.xml $DEST_DIR/WEB-INF/web.xml
    fi
}

# Function to copy EAR content
copy_ear_content() {
    local SRC_DIR=$1
    local DEST_DIR=$MAVEN_BASE/CqssIntraEAR/src/main/application
    
    echo "Copying EAR content from $SRC_DIR to $DEST_DIR"
    
    # Create destination directory
    mkdir -p $DEST_DIR/META-INF
    
    # Copy application.xml
    if [ -f "$SRC_DIR/meta-inf/application.xml" ]; then
        cp $SRC_DIR/meta-inf/application.xml $DEST_DIR/META-INF/application.xml
    fi
}

# Main script
echo "===== Reorganizing source files from Ant to Maven structure ====="

# Process CqssCommon
MODULE="CqssCommon"
echo "Processing $MODULE..."
create_maven_dirs $MODULE
copy_java_files $MODULE $SOURCE_BASE/Source/CqssCommon/src
copy_resource_files $MODULE $SOURCE_BASE/Source/CqssCommon/src

# Process CqssStartup
MODULE="CqssStartup"
echo "Processing $MODULE..."
create_maven_dirs $MODULE
copy_java_files $MODULE $SOURCE_BASE/Source/CqssStartup/src
copy_resource_files $MODULE $SOURCE_BASE/Source/CqssStartup/src

# Process CqssVo
MODULE="CqssVo"
echo "Processing $MODULE..."
create_maven_dirs $MODULE
copy_java_files $MODULE $SOURCE_BASE/Source/CqssVo/src
copy_resource_files $MODULE $SOURCE_BASE/Source/CqssVo/src

# Process CqssDB
MODULE="CqssDB"
echo "Processing $MODULE..."
create_maven_dirs $MODULE
copy_java_files $MODULE $SOURCE_BASE/Source/CqssDB/src
copy_resource_files $MODULE $SOURCE_BASE/Source/CqssDB/src

# Process CqssEjbUtil
MODULE="CqssEjbUtil"
echo "Processing $MODULE..."
create_maven_dirs $MODULE
copy_java_files $MODULE $SOURCE_BASE/Source/CqssEjbUtil/src
copy_resource_files $MODULE $SOURCE_BASE/Source/CqssEjbUtil/src

# Process CqssIntraEjb
MODULE="CqssIntraEjb"
echo "Processing $MODULE..."
create_maven_dirs $MODULE
copy_java_files $MODULE $SOURCE_BASE/Source/CqssIntraEjb/ejbModule
copy_resource_files $MODULE $SOURCE_BASE/Source/CqssIntraEjb/ejbModule

# Process CqssIntranetWeb
MODULE="CqssIntranetWeb"
echo "Processing $MODULE..."
create_maven_dirs $MODULE
copy_java_files $MODULE $SOURCE_BASE/Source/CqssIntranetWeb/src
copy_resource_files $MODULE $SOURCE_BASE/Source/CqssIntranetWeb/src
copy_web_content $SOURCE_BASE/Source/CqssIntranetWeb/WebContent $MAVEN_BASE/CqssIntranetWeb/src/main/webapp

# Process CqssApplet
MODULE="CqssApplet"
echo "Processing $MODULE..."
create_maven_dirs $MODULE
copy_java_files $MODULE $SOURCE_BASE/Source/CqssApplet/src
copy_resource_files $MODULE $SOURCE_BASE/Source/CqssApplet/src

# Process CqssBatchJobDB
MODULE="CqssBatchJobDB"
echo "Processing $MODULE..."
create_maven_dirs $MODULE
copy_java_files $MODULE $SOURCE_BASE/Source/CqssBatchJobDB/src
copy_resource_files $MODULE $SOURCE_BASE/Source/CqssBatchJobDB/src

# Process CqssSecurityAdmin
MODULE="CqssSecurityAdmin"
echo "Processing $MODULE..."
create_maven_dirs $MODULE
copy_java_files $MODULE $SOURCE_BASE/Source/CqssSecurityAdmin/src
copy_resource_files $MODULE $SOURCE_BASE/Source/CqssSecurityAdmin/src

# Process CqssSvr
MODULE="CqssSvr"
echo "Processing $MODULE..."
create_maven_dirs $MODULE
copy_java_files $MODULE $SOURCE_BASE/Source/CqssSvr/src
copy_resource_files $MODULE $SOURCE_BASE/Source/CqssSvr/src

# Process CqssEjbTestClient (if exists)
if [ -d "$SOURCE_BASE/Source/CqssEjbTestClient" ]; then
    MODULE="CqssEjbTestClient"
    echo "Processing $MODULE..."
    create_maven_dirs $MODULE
    copy_java_files $MODULE $SOURCE_BASE/Source/CqssEjbTestClient/src
    copy_resource_files $MODULE $SOURCE_BASE/Source/CqssEjbTestClient/src
fi

# Process Ibator (if exists)
if [ -d "$SOURCE_BASE/Source/Ibator" ]; then
    MODULE="Ibator"
    echo "Processing $MODULE..."
    create_maven_dirs $MODULE
    copy_java_files $MODULE $SOURCE_BASE/Source/Ibator/src
    copy_resource_files $MODULE $SOURCE_BASE/Source/Ibator/src
fi

# Process CqssIntraEAR
MODULE="CqssIntraEAR"
echo "Processing $MODULE..."
create_maven_dirs $MODULE
copy_ear_content $SOURCE_BASE/Source/CqssIntraEAR

echo "===== Source reorganization completed successfully! ====="