#!/bin/bash
# Script to install all required dependencies into the local Maven repository

# Set up local repository path
REPO_PATH="./cqss-repo/repository"
mkdir -p $REPO_PATH

# Function to install a JAR file to the local repository
function install_jar() {
    local GROUP_ID=$1
    local ARTIFACT_ID=$2
    local VERSION=$3
    local JAR_PATH=$4
    
    echo "Installing $GROUP_ID:$ARTIFACT_ID:$VERSION from $JAR_PATH"
    
    mvn install:install-file \
        -Dfile=$JAR_PATH \
        -DgroupId=$GROUP_ID \
        -DartifactId=$ARTIFACT_ID \
        -Dversion=$VERSION \
        -Dpackaging=jar \
        -DlocalRepositoryPath=$REPO_PATH
}

echo "===== Installing Custom Libraries ====="

# Install WNB Core libraries
echo "Installing WNB Core libraries..."
CORE_LIB_PATH="../../../cbs/cbs/Deploy/Was9/Libraries/WnbCore/Core"
install_jar "com.custom" "app-core" "1.0" "$CORE_LIB_PATH/AppCore.jar"
install_jar "com.custom" "app-msg" "1.0" "$CORE_LIB_PATH/AppMsg.jar"
install_jar "com.custom" "app-util" "1.0" "$CORE_LIB_PATH/AppUtil.jar"

# Install WebSphere Core libraries
echo "Installing WebSphere Core libraries..."
WAS_CORE_LIB_PATH="../../../cbs/cbs/Deploy/Was9/Libraries/WnbWas/WasCore"
install_jar "com.custom" "ejb-common" "1.0" "$WAS_CORE_LIB_PATH/EjbCommon.jar"
install_jar "com.custom" "wnb-log" "1.0" "$WAS_CORE_LIB_PATH/WnbLog.jar"
install_jar "com.custom" "ejb-intra-web-common" "1.0" "$WAS_CORE_LIB_PATH/EjbIntraWebCommon.jar"
install_jar "com.custom" "ejb-web-common" "1.0" "$WAS_CORE_LIB_PATH/EjbWebCommon.jar"
install_jar "com.custom" "startup" "1.0" "$WAS_CORE_LIB_PATH/Startup.jar"

# Install SCS libraries
echo "Installing SCS libraries..."
SCS_LIB_PATH="../../../cbs/cbs/Deploy/Was9/Libraries/WnbWas/Scs"
install_jar "com.custom" "ejb-intra-common-scs" "1.0" "$SCS_LIB_PATH/EjbIntraCommonScs.jar"

# Install CyberUtil WAS libraries
echo "Installing CyberUtil WAS libraries..."
CYBER_UTIL_LIB_PATH="../../../btss/btss/Deploy/lib"
install_jar "com.custom" "cyber-util-common-for-was" "1.0" "$CYBER_UTIL_LIB_PATH/CyberUtilCommonForWas.jar"
install_jar "com.custom" "cyber-util-tools-for-was" "1.0" "$CYBER_UTIL_LIB_PATH/CyberUtilToolsForWas.jar"
install_jar "com.custom" "cyber-util-for-was" "1.0" "$CYBER_UTIL_LIB_PATH/CyberUtilForWas.jar"

# Install CyberUtil Standalone/Batch libraries
echo "Installing CyberUtil Standalone/Batch libraries..."
install_jar "com.custom" "cyber-util" "1.0" "$CYBER_UTIL_LIB_PATH/CyberUtil.jar"
install_jar "com.custom" "cyber-util-common" "1.0" "$CYBER_UTIL_LIB_PATH/CyberUtilCommon.jar"
install_jar "com.custom" "cyber-util-tools" "1.0" "$CYBER_UTIL_LIB_PATH/CyberUtilTools.jar"
install_jar "com.custom" "cyber-util-batch" "1.0" "$CYBER_UTIL_LIB_PATH/CyberUtilBatch.jar"
install_jar "com.custom" "cyber-util-batch-db" "1.0" "$CYBER_UTIL_LIB_PATH/CyberUtilBatchDB.jar"
install_jar "com.custom" "cyber-util-batch-vo" "1.0" "$CYBER_UTIL_LIB_PATH/CyberUtilBatchVo.jar"
install_jar "com.custom" "cyber-util-batch-job" "1.0" "$CYBER_UTIL_LIB_PATH/CyberUtilBatchJob.jar"
install_jar "com.custom" "cyber-util-batch-svr" "1.0" "$CYBER_UTIL_LIB_PATH/CyberUtilBatchSvr.jar"

# Install other custom libraries
echo "Installing other custom libraries..."
HSM_LIB_PATH="../Deploy/lib/external/hsm"
install_jar "com.custom" "hsm-common" "1.0" "$HSM_LIB_PATH/HsmCommon.jar"

JAWS_LIB_PATH="../Deploy/lib/external/applet"
install_jar "jaws" "jaws" "1.0" "$JAWS_LIB_PATH/jaws.jar"

echo "===== Installing External Libraries ====="

# Install Apache Commons libraries
echo "Installing Apache Commons libraries..."
COMMONS_LIB_PATH="../Deploy/lib/external/apache/common"
install_jar "commons-logging" "commons-logging" "1.1.1" "$COMMONS_LIB_PATH/commons-logging-1.1.1.jar"
install_jar "commons-logging" "commons-logging-api" "1.1.1" "$COMMONS_LIB_PATH/commons-logging-api-1.1.1.jar"
install_jar "commons-logging" "commons-logging-adapters" "1.1.1" "$COMMONS_LIB_PATH/commons-logging-adapters-1.1.1.jar"
install_jar "commons-beanutils" "commons-beanutils" "1.8.0" "$COMMONS_LIB_PATH/commons-beanutils.jar"
install_jar "commons-digester" "commons-digester" "1.8" "$COMMONS_LIB_PATH/commons-digester-1.8.jar"
install_jar "commons-collections" "commons-collections" "3.2.1" "$COMMONS_LIB_PATH/commons-collections-3.2.1.jar"
install_jar "commons-lang" "commons-lang" "2.4" "$COMMONS_LIB_PATH/commons-lang-2.4.jar"
install_jar "commons-codec" "commons-codec" "1.3" "$COMMONS_LIB_PATH/commons-codec-1.3.jar"
install_jar "commons-chain" "commons-chain" "1.2" "$COMMONS_LIB_PATH/commons-chain-1.2.jar"
install_jar "commons-validator" "commons-validator" "1.3.1" "$COMMONS_LIB_PATH/commons-validator-1.3.1.jar"
install_jar "commons-httpclient" "commons-httpclient" "3.1" "$COMMONS_LIB_PATH/commons-httpclient-3.1.jar"
install_jar "commons-configuration" "commons-configuration" "1.5" "$COMMONS_LIB_PATH/commons-configuration-1.5.zip"

# Install Logging libraries
echo "Installing Logging libraries..."
LOGGING_LIB_PATH="../Deploy/lib/external/apache/logging"
install_jar "log4j" "log4j" "1.2.14" "$LOGGING_LIB_PATH/log4j.jar"
install_jar "org.slf4j" "slf4j-api" "1.6.1" "$LOGGING_LIB_PATH/slf4j-api-1.6.1.jar"
install_jar "org.slf4j" "slf4j-log4j12" "1.6.1" "$LOGGING_LIB_PATH/slf4j-log4j12-1.6.1.jar"

# Install Spring and related libraries
echo "Installing Spring and related libraries..."
SPRING_LIB_PATH="../Deploy/lib/external/spring"
install_jar "org.springframework" "spring" "2.5.5" "$SPRING_LIB_PATH/spring-2.5.5.jar"
install_jar "org.aspectj" "aspectjrt" "1.6.1" "$SPRING_LIB_PATH/aspectj/aspectjrt.jar"
install_jar "org.aspectj" "aspectjweaver" "1.6.1" "$SPRING_LIB_PATH/aspectj/aspectjweaver.jar"
install_jar "antlr" "antlr" "2.7.6" "$SPRING_LIB_PATH/antlr/antlr-2.7.6.jar"

# Install Database and ORM libraries
echo "Installing Database and ORM libraries..."
IBATIS_LIB_PATH="../Deploy/lib/external/ibatis"
install_jar "org.apache.ibatis" "ibatis" "2.3.0.677" "$IBATIS_LIB_PATH/ibatis-2.3.0.677_cv.jar"

DB_LIB_PATH="../Deploy/lib/external/db"
install_jar "com.oracle" "ojdbc8" "12.2.0.1" "$DB_LIB_PATH/ojdbc8.jar"
install_jar "com.mchange" "c3p0" "0.9.2.1" "$DB_LIB_PATH/c3p0-0.9.2.1.jar"
install_jar "com.mchange" "mchange-commons-java" "0.2.3.4" "$DB_LIB_PATH/mchange-commons-java-0.2.3.4.jar"

# Install Struts and related libraries
echo "Installing Struts and related libraries..."
STRUTS_LIB_PATH="../Deploy/lib/external/struts"
install_jar "struts" "struts" "1.2.9" "$STRUTS_LIB_PATH/struts.jar"
install_jar "jakarta-oro" "jakarta-oro" "2.0.8" "$STRUTS_LIB_PATH/jakarta-oro.jar"

# Install JAXB libraries
echo "Installing JAXB libraries..."
JAXB_LIB_PATH="../Deploy/lib/external/jaxb"
install_jar "javax.xml.bind" "jaxb-api" "2.3.0" "$JAXB_LIB_PATH/jaxb-api.jar"
install_jar "com.sun.xml.bind" "jaxb-impl" "2.3.0" "$JAXB_LIB_PATH/jaxb-impl.jar"
install_jar "javax.xml" "jsr173" "1.0" "$JAXB_LIB_PATH/jsr173.jar"
install_jar "javax.activation" "activation" "1.1.1" "$JAXB_LIB_PATH/activation.jar"

# Install other third-party libraries
echo "Installing other third-party libraries..."
JSCH_LIB_PATH="../Deploy/lib/external/jsch"
install_jar "com.jcraft" "jsch" "0.1.54" "$JSCH_LIB_PATH/jsch-0.1.54.jar"

echo "===== All dependencies installed successfully! ====="