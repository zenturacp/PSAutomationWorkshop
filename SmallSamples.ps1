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

# Gem data som Json
Get-Service | ConvertTo-Json -depth 3 | Set-Content -Path "Services.json"

# Gem data som CSV
Get-Service | Export-Csv -Path "Services.csv" -NoTypeInformation

# Gem data som XML (Objekter med type)
Get-Service | Export-Clixml -Path "Services.xml"

# Gem data som Excel
Get-Service | Export-Excel -Path "Services.xlsx" -Show
