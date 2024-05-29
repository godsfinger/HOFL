#!/bin/bash

# Define the installation directory
INSTALL_DIR="/usr/local/bin"
PROGRAM_NAME="hofl"
SOURCE_FILE="hofl.cpp"

# Ensure the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Check if necessary tools are installed
if ! command -v qmake &> /dev/null || ! command -v g++ &> /dev/null; then
  echo "qmake and/or g++ could not be found. Please install Qt development tools and g++ compiler and try again."
  exit 1
fi

# Create a temporary directory for compilation
TEMP_DIR=$(mktemp -d)

# Copy the source file to the temporary directory
cp "$SOURCE_FILE" "$TEMP_DIR"

# Change to the temporary directory
cd "$TEMP_DIR"

# Create a basic Qt project file
echo "QT += widgets" > hofl.pro
echo "SOURCES += $SOURCE_FILE" >> hofl.pro

# Run qmake and make to build the application
qmake
make

# Move the compiled program to the installation directory
mv "$PROGRAM_NAME" "$INSTALL_DIR"

# Clean up
cd -
rm -rf "$TEMP_DIR"

echo "HOFL has been installed successfully!"
echo "You can run it by typing 'hofl' in your terminal."

# Create a desktop entry for easy access
DESKTOP_ENTRY="[Desktop Entry]
Name=HOFL
Exec=$INSTALL_DIR/$PROGRAM_NAME
Icon=utilities-terminal
Terminal=false
Type=Application
Categories=Utility;Application;"

echo "$DESKTOP_ENTRY" > /usr/share/applications/hofl.desktop

echo "Desktop entry created. You can find HOFL in your application menu."

# Exit the script
exit 0
