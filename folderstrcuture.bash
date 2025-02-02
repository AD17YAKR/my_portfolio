# !/bin/bash

# Create main directory structure
mkdir -p lib/sections lib/widgets lib/assets/{images,fonts}

# Create main files
touch lib/main.dart
touch lib/config.dart

# Create section files
cd lib/sections
touch homesection.dart
touch aboutsection.dart
touch experiencesection.dart
touch projectsection.dart
touch contactsection.dart
touch crazysection.dart

# Create widgets directory and sample widget
cd ../widgets
touch section_title.dart

# Create web directory and files
cd ../../
mkdir -p web/icons
touch web/index.html
touch web/manifest.json

# Create README if it doesn't exist
touch README.md

# Print success message
echo "Portfolio website structure created successfully!"

# List the created structure
tree
