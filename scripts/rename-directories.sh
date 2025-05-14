#!/bin/bash
# Script to rename directory names from kebab-case to CamelCase

set -e  # Exit on error

# Base directory
BASE_DIR="examples/poms"

# Directory name mappings (old -> new)
declare -A DIRS=(
  ["cqss-applet"]="CqssApplet"
  ["cqss-batch-job-db"]="CqssBatchJobDB"
  ["cqss-common"]="CqssCommon"
  ["cqss-db"]="CqssDB"
  ["cqss-ear"]="CqssIntraEAR"
  ["cqss-ejb-util"]="CqssEjbUtil"
  ["cqss-intra-ejb"]="CqssIntraEjb"
  ["cqss-intranet-web"]="CqssIntranetWeb"
  ["cqss-security-admin"]="CqssSecurityAdmin"
  ["cqss-startup"]="CqssStartup"
  ["cqss-svr"]="CqssSvr"
  ["cqss-vo"]="CqssVo"
)

# Create new directories and copy files
for old_dir in "${!DIRS[@]}"; do
  new_dir=${DIRS[$old_dir]}
  
  echo "Migrating $old_dir -> $new_dir"
  
  # Create new directory
  mkdir -p "$BASE_DIR/$new_dir"
  
  # Copy POM file
  if [ -f "$BASE_DIR/$old_dir/pom.xml" ]; then
    cp "$BASE_DIR/$old_dir/pom.xml" "$BASE_DIR/$new_dir/pom.xml"
  fi
  
  # Copy other files if they exist
  find "$BASE_DIR/$old_dir" -type f -not -name "pom.xml" -exec cp {} "$BASE_DIR/$new_dir/" \;
done

# Create new modules not in the current structure
mkdir -p "$BASE_DIR/CqssEjbTestClient"
mkdir -p "$BASE_DIR/Ibator"

echo "Directory migration complete. Please check the results and update any references."