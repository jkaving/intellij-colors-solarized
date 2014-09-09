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

  # Insert the FILESTATUS colors from the original Darcula scheme
  sed -i'.orig' -e '/<option name="CONSOLE_BACKGROUND_KEY/a\
\    <option name="FILESTATUS_ADDED" value="629755" />\
\    <option name="FILESTATUS_DELETED" value="6c6c6c" />\
\    <option name="FILESTATUS_IDEA_FILESTATUS_DELETED_FROM_FILE_SYSTEM" value="6c6c6c" />\
\    <option name="FILESTATUS_IDEA_FILESTATUS_IGNORED" value="848504" />\
\    <option name="FILESTATUS_IDEA_FILESTATUS_MERGED_WITH_BOTH_CONFLICTS" value="d5756c" />\
\    <option name="FILESTATUS_IDEA_FILESTATUS_MERGED_WITH_CONFLICTS" value="d5756c" />\
\    <option name="FILESTATUS_IDEA_FILESTATUS_MERGED_WITH_PROPERTY_CONFLICTS" value="d5756c" />\
\    <option name="FILESTATUS_MERGED" value="9876aa" />\
\    <option name="FILESTATUS_MODIFIED" value="6897bb" />\
\    <option name="FILESTATUS_NOT_CHANGED" value="" />\
\    <option name="FILESTATUS_NOT_CHANGED_IMMEDIATE" value="6897bb" />\
\    <option name="FILESTATUS_NOT_CHANGED_RECURSIVE" value="6897bb" />\
\    <option name="FILESTATUS_UNKNOWN" value="d1675a" />\
\    <option name="FILESTATUS_addedOutside" value="629755" />\
\    <option name="FILESTATUS_changelistConflict" value="d5756c" />\
\    <option name="FILESTATUS_modifiedOutside" value="6897bb" />\
' "${2}"
  
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
