#!/bin/bash

# Script to initialize Git repository and push the migrated CQSS project to GitHub
# This script assumes you're running it from the project root directory

# Initialize Git repository
git init
echo "Initialized Git repository"

# Create .gitignore file
cat > .gitignore << EOL
# Maven
target/
pom.xml.tag
pom.xml.releaseBackup
pom.xml.versionsBackup
pom.xml.next
release.properties
dependency-reduced-pom.xml
buildNumber.properties
.mvn/timing.properties
.mvn/wrapper/maven-wrapper.jar

# Eclipse
.settings/
.classpath
.project
.metadata

# IntelliJ IDEA
.idea/
*.iml
*.iws
*.ipr

# NetBeans
nbproject/private/
build/
nbbuild/
dist/
nbdist/
.nb-gradle/

# VSCode
.vscode/

# Windows
Thumbs.db
ehthumbs.db
Desktop.ini

# macOS
.DS_Store

# Log files
*.log

# Binary files and libraries
*.jar
*.war
*.ear
*.class

# Original Ant build files (kept for reference but not part of Maven build)
/Source/
/Binary/
build.xml
*.bat
*.xml.bak

# Exclude local Maven repository (it should be built on demand)
cqss-repo/

# Temporary files
*.tmp
*.bak
*.swp
*~.nib
EOL

echo "Created .gitignore file"

# Add all files to Git
git add .
echo "Added files to Git"

# Make initial commit
git commit -m "Initial commit - Migrated CQSS from Ant to Maven"
echo "Made initial commit"

# Add GitHub repository as remote
read -p "Enter GitHub username: " GITHUB_USERNAME
read -p "Enter GitHub repository name: " GITHUB_REPO

git remote add origin "https://github.com/${GITHUB_USERNAME}/${GITHUB_REPO}.git"
echo "Added GitHub repository as remote"

# Push to GitHub
echo "Pushing to GitHub..."
git push -u origin master

echo "Migration complete and code pushed to GitHub!"
echo "Repository URL: https://github.com/${GITHUB_USERNAME}/${GITHUB_REPO}"