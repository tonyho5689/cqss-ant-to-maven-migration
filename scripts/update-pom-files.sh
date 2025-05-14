#!/bin/bash
# Script to copy and update POM files from kebab-case to CamelCase directories

# Base directory
BASE_DIR="examples/poms"

# Mapping of kebab-case -> CamelCase directories
declare -A DIRS=(
  ["cqss-applet"]="CqssApplet"
  ["cqss-batch-job-db"]="CqssBatchJobDB"
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

# Mapping of old artifactIds -> new artifactIds
declare -A ARTIFACT_IDS=(
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

# Process each directory
for old_dir in "${!DIRS[@]}"; do
  new_dir=${DIRS[$old_dir]}
  old_artifact_id=$old_dir
  new_artifact_id=${ARTIFACT_IDS[$old_dir]}
  
  echo "Processing $old_dir -> $new_dir (artifactId: $old_artifact_id -> $new_artifact_id)"
  
  # Create new directory if it doesn't exist
  mkdir -p "$BASE_DIR/$new_dir"
  
  # Copy and modify POM file
  if [ -f "$BASE_DIR/$old_dir/pom.xml" ]; then
    # Read the POM file
    pom_content=$(cat "$BASE_DIR/$old_dir/pom.xml")
    
    # Replace the artifactId
    updated_pom=${pom_content//<artifactId>$old_artifact_id<\/artifactId>/<artifactId>$new_artifact_id<\/artifactId>}
    
    # Write the updated POM file
    echo "$updated_pom" > "$BASE_DIR/$new_dir/pom.xml"
    echo "  Updated $BASE_DIR/$new_dir/pom.xml"
  fi
  
  # Copy any other files (if they exist)
  find "$BASE_DIR/$old_dir" -type f -not -name "pom.xml" -exec cp {} "$BASE_DIR/$new_dir/" \;
done

echo "POM file updates complete!"