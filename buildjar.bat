mkdir .\colors
copy "Solarized Light.xml" .\colors
copy "Solarized Dark.xml" .\colors
copy /y nul .\"IntelliJ IDEA Global Settings"

jar cfM settings.jar "IntelliJ IDEA Global Settings" .\colors

rd /S /Q .\colors
del .\"IntelliJ IDEA Global Settings"
