mkdir .\colors
copy "Solarized Light.icls" .\colors
copy "Solarized Dark.icls" .\colors
copy "Solarized Light.icls" ".\colors\Solarized Light.xml"
copy "Solarized Dark.icls" ".\colors\Solarized Dark.xml"
copy /y nul .\"IntelliJ IDEA Global Settings"

jar cfM settings.jar "IntelliJ IDEA Global Settings" .\colors

rd /S /Q .\colors
del .\"IntelliJ IDEA Global Settings"
