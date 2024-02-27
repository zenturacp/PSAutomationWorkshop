# Hent filer i mappen
Get-ChildItem

# Hent filer i mappen men gem dem i en variable
$files = Get-ChildItem

# Skriv filerne i objektet ud
$files

# Skriv filerne ud i Liste form
$files | Format-List

# Skriv filerne ud i GridView
$files | Out-GridView

# Vælge filer ud fra Gridview
$chosenFiles = $files | Out-GridView -PassThru

# Vise de valgte filer
$chosenFiles

