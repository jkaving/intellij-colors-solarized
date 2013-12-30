#!/bin/sh

mkdir colors
cp Solarized\ Light.icls colors
cp Solarized\ Dark.icls colors
cp Solarized\ Light.icls colors/Solarized\ Light.xml
cp Solarized\ Dark.icls colors/Solarized\ Dark.xml
touch IntelliJ\ IDEA\ Global\ Settings

jar cfM settings.jar IntelliJ\ IDEA\ Global\ Settings colors

rm -r colors
rm IntelliJ\ IDEA\ Global\ Settings
echo "Complete!"
