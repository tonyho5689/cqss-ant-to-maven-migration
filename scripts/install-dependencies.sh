#!/bin/bash

# Script to install custom JARs to local Maven repository for the CQSS project
# This script assumes you're running it from the project root directory

# Create local repository directory
mkdir -p cqss-repo/repository
echo "Created local repository directory structure"

# Define paths
WAS_LIBS="../../../cbs/cbs/Deploy/Was9/Libraries"
DEPLOY_LIB="../Deploy/lib"
BTSS_LIB="../../../btss/btss/Deploy/lib"
LOCAL_REPO="./cqss-repo/repository"

echo "Installing WNB Core libraries..."
# WnbCore libraries
mvn install:install-file -Dfile="${WAS_LIBS}/WnbCore/Core/AppCore.jar" -DgroupId=com.custom -DartifactId=app-core -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${WAS_LIBS}/WnbCore/Core/AppMsg.jar" -DgroupId=com.custom -DartifactId=app-msg -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${WAS_LIBS}/WnbCore/Core/AppUtil.jar" -DgroupId=com.custom -DartifactId=app-util -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"

echo "Installing WebSphere libraries..."
# WebSphere libraries
mvn install:install-file -Dfile="${WAS_LIBS}/WnbWas/WasCore/EjbCommon.jar" -DgroupId=com.custom -DartifactId=ejb-common -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${WAS_LIBS}/WnbWas/WasCore/WnbLog.jar" -DgroupId=com.custom -DartifactId=wnb-log -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${WAS_LIBS}/WnbWas/WasCore/EjbIntraWebCommon.jar" -DgroupId=com.custom -DartifactId=ejb-intra-web-common -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${WAS_LIBS}/WnbWas/WasCore/EjbWebCommon.jar" -DgroupId=com.custom -DartifactId=ejb-web-common -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${WAS_LIBS}/WnbWas/Startup.jar" -DgroupId=com.custom -DartifactId=startup -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"

echo "Installing SCS libraries..."
# SCS libraries
mvn install:install-file -Dfile="${WAS_LIBS}/WnbWas/Scs/EjbIntraCommonScs.jar" -DgroupId=com.custom -DartifactId=ejb-intra-common-scs -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"

echo "Installing CyberUtil libraries..."
# CyberUtil libraries 
# WebSphere (WAS) versions
mvn install:install-file -Dfile="${BTSS_LIB}/CyberUtilCommonForWas.jar" -DgroupId=com.custom -DartifactId=cyber-util-common-for-was -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${BTSS_LIB}/CyberUtilToolsForWas.jar" -DgroupId=com.custom -DartifactId=cyber-util-tools-for-was -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${BTSS_LIB}/CyberUtilForWas.jar" -DgroupId=com.custom -DartifactId=cyber-util-for-was -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"

# Standalone/Batch versions
mvn install:install-file -Dfile="${BTSS_LIB}/CyberUtil.jar" -DgroupId=com.custom -DartifactId=cyber-util -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${BTSS_LIB}/CyberUtilCommon.jar" -DgroupId=com.custom -DartifactId=cyber-util-common -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${BTSS_LIB}/CyberUtilTools.jar" -DgroupId=com.custom -DartifactId=cyber-util-tools -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${BTSS_LIB}/CyberUtilBatch.jar" -DgroupId=com.custom -DartifactId=cyber-util-batch -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${BTSS_LIB}/CyberUtilBatchDB.jar" -DgroupId=com.custom -DartifactId=cyber-util-batch-db -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${BTSS_LIB}/CyberUtilBatchVo.jar" -DgroupId=com.custom -DartifactId=cyber-util-batch-vo -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${BTSS_LIB}/CyberUtilBatchJob.jar" -DgroupId=com.custom -DartifactId=cyber-util-batch-job -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"

echo "Installing HSM libraries..."
# HSM libraries
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/hsm/HsmCommon.jar" -DgroupId=com.custom -DartifactId=hsm-common -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"

echo "Installing Apache Commons libraries..."
# Apache Commons libraries
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/apache/common/commons-logging-1.1.1.jar" -DgroupId=commons-logging -DartifactId=commons-logging -Dversion=1.1.1 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/apache/common/commons-logging-api-1.1.1.jar" -DgroupId=commons-logging -DartifactId=commons-logging-api -Dversion=1.1.1 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/apache/common/commons-logging-adapters-1.1.1.jar" -DgroupId=commons-logging -DartifactId=commons-logging-adapters -Dversion=1.1.1 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/apache/common/commons-beanutils.jar" -DgroupId=commons-beanutils -DartifactId=commons-beanutils -Dversion=1.8.0 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/apache/common/commons-digester-1.8.jar" -DgroupId=commons-digester -DartifactId=commons-digester -Dversion=1.8 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/apache/common/commons-collections-3.2.1.jar" -DgroupId=commons-collections -DartifactId=commons-collections -Dversion=3.2.1 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/apache/common/commons-lang-2.4.jar" -DgroupId=commons-lang -DartifactId=commons-lang -Dversion=2.4 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/apache/common/commons-codec-1.3.jar" -DgroupId=commons-codec -DartifactId=commons-codec -Dversion=1.3 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/apache/common/commons-chain-1.2.jar" -DgroupId=commons-chain -DartifactId=commons-chain -Dversion=1.2 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/apache/common/commons-validator-1.3.1.jar" -DgroupId=commons-validator -DartifactId=commons-validator -Dversion=1.3.1 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/apache/common/commons-httpclient-3.1.jar" -DgroupId=commons-httpclient -DartifactId=commons-httpclient -Dversion=3.1 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/apache/common/commons-configuration-1.5.zip" -DgroupId=commons-configuration -DartifactId=commons-configuration -Dversion=1.5 -Dpackaging=zip -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/apache/logging/log4j.jar" -DgroupId=log4j -DartifactId=log4j -Dversion=1.2.14 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"

echo "Installing Spring and related libraries..."
# Spring libraries
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/spring/spring-2.5.5.jar" -DgroupId=org.springframework -DartifactId=spring -Dversion=2.5.5 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/spring/aspectj/aspectjrt.jar" -DgroupId=org.aspectj -DartifactId=aspectjrt -Dversion=1.6.1 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/spring/aspectj/aspectjweaver.jar" -DgroupId=org.aspectj -DartifactId=aspectjweaver -Dversion=1.6.1 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/spring/antlr/antlr-2.7.6.jar" -DgroupId=antlr -DartifactId=antlr -Dversion=2.7.6 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"

echo "Installing Database libraries..."
# Database libraries
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/db/ojdbc8.jar" -DgroupId=com.oracle -DartifactId=ojdbc8 -Dversion=12.2.0.1 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/db/c3p0-0.9.2.1.jar" -DgroupId=com.mchange -DartifactId=c3p0 -Dversion=0.9.2.1 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/db/mchange-commons-java-0.2.3.4.jar" -DgroupId=com.mchange -DartifactId=mchange-commons-java -Dversion=0.2.3.4 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"

echo "Installing iBatis library..."
# iBatis library
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/ibatis/ibatis-2.3.0.677_cv.jar" -DgroupId=org.apache.ibatis -DartifactId=ibatis -Dversion=2.3.0.677 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"

echo "Installing SLF4J libraries..."
# SLF4J libraries
mvn install:install-file -Dfile="${WAS_LIBS}/other/slf4j-api-1.6.1.jar" -DgroupId=org.slf4j -DartifactId=slf4j-api -Dversion=1.6.1 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${WAS_LIBS}/other/slf4j-log4j12-1.6.1.jar" -DgroupId=org.slf4j -DartifactId=slf4j-log4j12 -Dversion=1.6.1 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"

echo "Installing Struts and related libraries..."
# Struts libraries
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/struts/struts.jar" -DgroupId=struts -DartifactId=struts -Dversion=1.2.9 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/struts/jakarta-oro.jar" -DgroupId=jakarta-oro -DartifactId=jakarta-oro -Dversion=2.0.8 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"

echo "Installing JAXB libraries..."
# JAXB libraries
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/jaxb/jaxb-api.jar" -DgroupId=javax.xml.bind -DartifactId=jaxb-api -Dversion=2.3.0 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/jaxb/jaxb-impl.jar" -DgroupId=com.sun.xml.bind -DartifactId=jaxb-impl -Dversion=2.3.0 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/jaxb/jsr173_1.0_api.jar" -DgroupId=javax.xml -DartifactId=jsr173 -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/jaxb/activation.jar" -DgroupId=javax.activation -DartifactId=activation -Dversion=1.1.1 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"

echo "Installing miscellaneous libraries..."
# Misc libraries
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/jsch/jsch-0.1.54.jar" -DgroupId=com.jcraft -DartifactId=jsch -Dversion=0.1.54 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"
mvn install:install-file -Dfile="${DEPLOY_LIB}/external/applet/jaws.jar" -DgroupId=jaws -DartifactId=jaws -Dversion=1.0 -Dpackaging=jar -DlocalRepositoryPath="${LOCAL_REPO}"

echo "All libraries installed successfully to local repository: ${LOCAL_REPO}"
echo "You can now build the CQSS project with Maven."