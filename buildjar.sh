#!/bin/bash

# Create a Darcula version of the specified color scheme.
#
# Usage:
#        createDarculaVersion sourceFile targetFile
#
function createDarculaVersion {
  cp "${1}" "${2}"

  # Append " (Darcula)" to the name of the scheme
  sed -i'.orig' -e 's/\(<scheme name="[^"]*\)\(" .*\)/\1 \(Darcula\)\2/' "${2}"

  # Remove any existing FILESTATUS elements
  sed -i'.orig' -e '/<option name="FILESTATUS_/d' "${2}"

  # Replace the notification background
  sed -i'.orig' -e 's/<option name="NOTIFICATION_BACKGROUND.*$/<option name="NOTIFICATION_BACKGROUND" value="73642" \/>/' "${2}"

  # Use Darcula parent theme
  sed -i'.orig' -e '/<scheme\>/ s/\<\(parent_scheme\)="[^"]*"/\1="Darcula"/' "${2}"

  rm "${2}.orig"
}

# Create the "colors" directory for the scheme files
# and copy the .icls scheme files there
mkdir colors
cp Solarized\ Light.icls colors
cp Solarized\ Dark.icls colors

# Create Darcula versions of both schemes,
createDarculaVersion colors/Solarized\ Light.icls colors/Solarized\ Light\ \(Darcula\).icls
createDarculaVersion colors/Solarized\ Dark.icls colors/Solarized\ Dark\ \(Darcula\).icls

# Create .xml versions of all schemes for backwards compatibility
cp colors/Solarized\ Light.icls colors/Solarized\ Light.xml
cp colors/Solarized\ Dark.icls colors/Solarized\ Dark.xml
cp colors/Solarized\ Light\ \(Darcula\).icls colors/Solarized\ Light\ \(Darcula\).xml
cp colors/Solarized\ Dark\ \(Darcula\).icls colors/Solarized\ Dark\ \(Darcula\).xml

# Create an empty "IntelliJ IDEA Global Settings" file,
# needed to be able to import the JAR using "Import Settings..."
touch IntelliJ\ IDEA\ Global\ Settings

# Create the JAR file
jar cfM settings.jar IntelliJ\ IDEA\ Global\ Settings colors

# Cleanup
rm -r colors
rm IntelliJ\ IDEA\ Global\ Settings

echo "settings.jar generated"
