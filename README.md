# Workshop: PowerShell / Automation

![Narnia](./Assets/narnia.webp)

## Hvem er jeg kort?

- Christian Pedersen
- CTO i Zentura A/S MSP med fokus på små / mellemstore kunder
- Volume game, mange kunder, mange opgaver
- Fra Amiga 500 til Azure og alt imellem
- Past - Nutanix Technology Champion
- AZ-* Certificeret (Azure - More less alle Cloud Only certificertinger)
- DevOps / Automation / Scripting
- En "Doven" IT-mand er den bedste IT-mand

## Powershell Swizz army knife!

![Swizz army knife](./Assets/powershell.webp)

***Det siger ChatGPT om PowerShell:***

PowerShell er et cross-platform (Windows, Linux og macOS) kommandolinjeværktøj og et skriptsprog, der er udviklet af Microsoft. Det giver administratorer mulighed for at udføre **automatiseret** administration og konfiguration af både lokale og fjernsystemer. PowerShell er bygget på .NET-frameworket, hvilket giver det adgang til en bred vifte af funktioner og gør det til et kraftfuldt værktøj til automatisering.

En af de primære grunde til, at PowerShell er stærkt til automatisering, er dens **objektbaserede** natur. I modsætning til traditionelle shell-sprog, der arbejder med tekstbaserede output, arbejder PowerShell med .NET-objekter. Dette betyder, at output fra et PowerShell-kommando kan manipuleres, filtreres og arbejdes med direkte som strukturerede data. Det gør det lettere at automatisere komplekse opgaver, da administratorer kan fokusere på at arbejde med dataene i stedet for at parse tekstoutput.

PowerShell indeholder også et stort antal cmdlets (udtalt command-lets), som er indbyggede kommandoer specifikt designet til at udføre almindelige systemadministration opgaver, såsom at administrere filsystemer, processer, tjenester og registreringsdatabasen. Brugerne kan også udvikle og dele deres egne cmdlets og scripts, hvilket gør PowerShell ekstremt fleksibelt og kraftfuldt.

Desuden understøtter PowerShell scripting, hvilket giver brugere mulighed for at skrive komplekse scripts, der udfører en række opgaver automatisk. Det er særligt nyttigt for at automatisere gentagne opgaver, som at udføre regelmæssige systemtjek, deployering af software, eller konfigurering af netværksindstillinger på flere computere samtidig.

Til sidst er PowerShell integreret med alle moderne versioner af Windows og er tilgængeligt på andre platforme, hvilket gør det til et ideelt værktøj for systemadministratorer, der arbejder i heterogene netværksmiljøer. Integrationen med .NET-frameworket, sammen med understøttelse af eksisterende scriptsprog som Python og Perl, gør det muligt for administratorer at udnytte eksisterende kode og ressourcer, yderligere styrke PowerShell's evne til at automatisere komplekse systemadministration opgaver.

## Tooling

![Tools](./Assets/dewalt.webp)

Håndværkere har typisk en præference indenfor specielt udstyr, samme for IT folk, vi har vores præferencer indenfor værktøjer, her er nogle af mine favoritter - og dem jeg vil bruge idag

### Visual Studio Code

I min optik den klart bedste IDE, er et standard værktøj der kan udbygges med extensions.

### PowerShell 5.1, 7.x

PowerShell 5.1 er den version der kommer med Windows 10, og er den version der er mest udbredt, dog kan PowerShell 7.x køre på alle platforme, og er den nyeste version, den er til en grad bagud kompatibel, mit take er man skal bruge den version der passer til den opgave man skal lave.

### Windows Terminal

En Genial terminal som erstatning til CMD.exe eller PWSH.exe, den kan køre PowerShell, CMD, WSL og meget mere.

### Git(hub)

Alt hvad jeg har af kode herunder dokumentation / eksempler / scripts lægger jeg i GIT og det jeg vil gemme eller udvikle videre på kommer også på GitHub, man kan sagtens bruge Git bare lokalt til at tracke udvikling på et projekt.

### Github Copilot

En AI der hjælper med at skrive kode, den er bygget på OpenAI's GPT-3, og er en del af Visual Studio Code. (FANTASTISK)

## Eksempler

Herunder er nogle hands-on eksempler vi kan gennemgå, meget af det er lavet med CoPilot.

### AzureADGraph

Nogle moduler er bare "wrappere" til API'er f.eks. Microsoft.Graph modulet, det laver "OnTheFly" funktioner i PowerShell på baggrund af det API Microsoft har, det giver den fordel at man ikke skal bygge funktioner ind i modulet heletiden, men det giver den udfordring at der ikke er særlig god validering og dokumentation så man er lidt på egen hånd.

```powershell
# Connect to Microsoft Graph API using Azure AD
Connect-MGGraph -Scopes "User.Read.All", "AuditLog.Read.All"

# Show my current scope
$context = Get-MGContext
$context.Scopes

# Get all users
$allUsers = Get-MGUser
$allUsers[0] | Format-List

# Ikke alt kommer med - ?!?
$allUsers | Out-GridView

# Get Properties
# https://learn.microsoft.com/en-us/graph/api/resources/user?view=graph-rest-1.0#properties

$properties = @(
    "usageLocation",
    "department",
    "userPrincipalName",
    "id",
    "displayName",
    "jobTitle",
    "mail",
    "licenseAssignmentStates",
    "lastPasswordChangeDateTime",
    "assignedLicenses",
    "assignedPlans"
)

$allUsers = Get-MgUser -Property $properties

# Hent alle brugere og vis i gridview
$allUsers | Select-Object -Property $properties | Out-GridView

# Hent signin logs ind i en variabel
$signInLogs = Get-MgAuditLogSignIn

# Hent signin logs ind i en variabel
$signInLogs = Get-MgAuditLogSignIn

# Parse og find kun de steder hvor det ikke direkte er gået godt
$FailedLogins = @()
$signInLogs | ForEach-Object {

    if($_.Status.ErrorCode -ne "0"){
        $_object = [PSCustomObject]@{
            UserDisplayName = $_.UserDisplayName
            UserPrincipalName = $_.UserPrincipalName
            AppDisplayName = $_.AppDisplayName
            CreatedDateTime = $_.CreatedDateTime
            StatusCode = $_.Status.ErrorCode
            StatusReason = $_.Status.AdditionalDetails + " " + $_.Status.FailureReason
        }
        $FailedLogins += $_object 
        $_object
    }

} | Format-Table -AutoSize

# Gem failed logins i Excel
$FailedLogins | Export-Excel -Path ".\FailedLogins.xlsx" -WorksheetName "FailedLogins" -AutoSize -AutoFilter -FreezeTopRow -BoldTopRow -Show
```

[Link til AzureADGraph.ps1](https://github.com/zenturacp/PSAutomationWorkshop/blob/main/AzureADGraph.ps1){:target="_blank"}

### Exchange Online rapport

![ExchangeOnline](./Assets/exchangereport.webp)

I dette eksemple samler vi en masse viden fra forskellige powershell snippets og ender med at eksportere i Excel format til videre gennemgang.

```powershell
# Installer Exchange Online PowerShell Module
Install-Module -Name ExchangeOnlineManagement -Scope AllUsers

# Import Module
Import-Module ExchangeOnlineManagement

# Connect to Exchange Online
Connect-ExchangeOnline -Device

# Get All Mailboxes
$AllMailboxes = Get-EXOMailbox
$AllMailboxes | Select-Object -Property "DisplayName", "UserPrincipalName", "PrimarySmtpAddress"

$items = @()

# Get mailbox sizes
foreach($mailbox in $AllMailboxes){
    $mailboxSize = Get-EXOMailboxStatistics -Identity $mailbox.UserPrincipalName
    $items += $mailboxSize | Select-Object -Property "DisplayName", "TotalItemSize", "ItemCount"
}

# Class til rapport
class Mailbox{
    [string]$DisplayName
    [string]$UserPrincipalName
    [Int64]$TotalItemSizeBytes
    [int]$ItemCount
    [bool]$IsSharedMailbox = $false
    [string]$EmailAddresses
    [string]$MailboxLanguage
}

$items = @()

foreach($mailbox in $AllMailboxes){
    $mailboxSize = Get-EXOMailboxStatistics -Identity $mailbox.UserPrincipalName
    $item = [Mailbox]::new()
    $item.DisplayName = $mailbox.DisplayName
    $item.UserPrincipalName = $mailbox.UserPrincipalName
    $item.TotalItemSizeBytes = $mailboxSize.TotalItemSize.Value.ToBytes()
    $item.ItemCount = $mailboxSize.ItemCount
    if($mailbox.RecipientTypeDetails -eq "SharedMailbox"){
        $item.IsSharedMailbox = $true
    }
    # Change email addresses from object and strip SMTP: from the string
    $item.EmailAddresses = ($mailbox.EmailAddresses | ForEach-Object { $_ -ireplace "SMTP:" }) -join ","
    # Get Regional Settings
    $mailboxSettings = Get-MailboxRegionalConfiguration -Identity $mailbox.UserPrincipalName
    if($mailboxSettings.Language){
        $item.MailboxLanguage = $mailboxSettings.Language
    } else {
        $item.MailboxLanguage = "Unset"
    }
    $items += $item
}

# Permission Report

foreach($mailbox in $AllMailboxes){
    $mailboxPermissions = Get-EXOMailboxPermission -Identity $mailbox.UserPrincipalName
    $permissions = $mailboxPermissions | Select-Object -Property "User", "AccessRights", "IsInherited", "Deny" | Where-Object { $_.User -notlike "NT AUTHORITY\SELF" }
    if($permissions){
        $customObject = [PSCustomObject]@{
            Mailbox = $mailbox.DisplayName
            AccessGrantedTo = $permissions.User
            AccessRights = $permissions.AccessRights
            IsInherited = $permissions.IsInherited
            Deny = $permissions.Deny
        }
        $customObject    
    }
}

# Gem rapport som JSON
$items | ConvertTo-Json | Out-File -FilePath ".\MailboxReport.json" -Force

# Gem som Excel
$items | Export-Excel -Path ".\MailboxReport.xlsx" -WorksheetName "MailboxReport" -AutoSize -AutoFilter -FreezeTopRow -BoldTopRow

# Sæt regional settings på mailbox
foreach($mailbox in $items){
    if($mailbox.MailboxLanguage -eq "Unset"){
        Set-MailboxRegionalConfiguration -Identity $mailbox.UserPrincipalName -Language da-DK -LocalizeDefaultFolderName:$true
    }
}
```

[Link til ExchangeOnline.ps1](https://github.com/zenturacp/PSAutomationWorkshop/blob/main/ExchangeOnline.ps1){:target="_blank"}

### Rest API

I dette eksemple forbinder vi til Chuck Norris API og henter en joke og efterfølgende udbygger med kategorier

```powershell
# Chuck Norris API

$randomJoke = Invoke-RestMethod -Uri "https://api.chucknorris.io/jokes/random"
$randomJoke

# Selve joken
$randomJoke.value

# Kategorier
$categories = Invoke-RestMethod -Uri "https://api.chucknorris.io/jokes/categories"

# List kategoier
$categories

$categories | Out-GridView -PassThru | ForEach-Object {
    $joke = Invoke-RestMethod -Uri "https://api.chucknorris.io/jokes/random?category=$_"
    $joke.value
}
```

[Link til REST-API.ps1](https://github.com/zenturacp/PSAutomationWorkshop/blob/main/REST-API.ps1){:target="_blank"}

### Objekt typer

Objekter er typisk brugt til at strukturere / samle data fra forskellige sources og lave dine egne objekter, det kan være fra en SQL database, en API, eller en CSV fil.

```powershell
# Custom Object
$CustomObject = [PSCustomObject]@{
    Name = "John Doe"
    Age = 25
    City = "New York"
}
$CustomObject

# Class
class Person{
    [string]$Name
    [int]$Age
    [string]$City
}
$ClassObject = [Person]::new()
$ClassObject.Name = "John Doe"
$ClassObject.Age = 25
$ClassObject.City = "New York"
$ClassObject

# Class med metoder
class PersonExtended{
    [string]$Name
    [int]$Age
    [string]$City

    [string] GetInfo(){
        return "Name: $($this.Name), Age: $($this.Age), City: $($this.City)"
    }
}
$ClassObject = [PersonExtended]::new()
$ClassObject.Name = "John Doe"
$ClassObject.Age = 25
$ClassObject.City = "New York"
$ClassObject.GetInfo()
```

[Link til ObjektTyper.ps1](https://github.com/zenturacp/PSAutomationWorkshop/blob/main/ObjektTyper.ps1){:target="_blank"}


### Andre små eksempler

Her er bare nogle små eksempler på at hente ting og gemme som variabler og gemme indhold til senere beregninger eller rapporter.

```powershell
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
Get-Service | Export-Excel -Path "Services.xlsx" -Show -AutoSize -AutoFilter -FreezeTopRow -BoldTopRow
```

[Link til SmallSamples.ps1](https://github.com/zenturacp/PSAutomationWorkshop/blob/main/SmallSamples.ps1){:target="_blank"}

## Excel modul

Import Excel er et modul til at arbejde med Excel filer, det er et modul der er bygget på .NET og er derfor meget hurtigt, det kan bruges til at læse og skrive til Excel filer, og kan også bruges til at lave grafer og diagrammer.

Link til projekt: https://github.com/dfinke/ImportExcel

```powershell
Install-Module ImportExcel -Scope AllUsers
```

## Sæt strøm til det hele

Det er så fint man har fået lavet en masse "interaktive" scripts, men nogle gange vil man gerne have at de køre igen og igen for at løfte en opgave mere automatiseret.

### Kør scripts på en PC eller Server

Man kan godt køre scripts lokalt eller som scheduled tasks på en VM eller ligende, det er godt til test / udvikling, eller hvis der ikke er mulighed for andet

### Azure Automation

Azure Automation er en service i Azure der kan køre scripts, det kan være **PowerShell**, Python, Bash eller Runbooks, det kan også køre på en planlagt opgave, eller på en trigger, det kan også køre på en Hybrid Worker, så det kan køre på en VM i Azure eller On-Premise.

### Azure Function Apps

Azure Function Apps er en service i Azure der kan køre kode, det kan være **PowerShell**, Python, C#, Java, Node.js, eller Custom Handler, det kan også køre på en planlagt opgave, eller på en trigger (HTTP, Blob, Queue, EventGrid, EventHub, ServiceBus, Timer, IoT Hub, CosmosDB, Durable Functions, SignalR Service, og Webhooks)

[Function App eksemple](https://portal.azure.com/#@advokat-jensen.dk/resource/subscriptions/caaf1a53-3a0a-42e4-9688-4aac8f95a2d7/resourceGroups/PSWorkshop/providers/Microsoft.Web/sites/psworkshop/appServices){:target="_blank"}

[Link til Chuck API](https://psworkshop.azurewebsites.net/api/chuck){:target="_blank"}

[Link til Chuck API med kategori Food](https://psworkshop.azurewebsites.net/api/chuck?category=food){:target="_blank"}

[Link til GetVMs API](https://psworkshop.azurewebsites.net/api/getvms){:target="_blank"}

## Bare rolig - AI Brain fart!

I bliver ikke arbejdsløse forløbig fordi AI er opfundet!

![AIGoneWrong](./Assets/barerolig.png)

# Spørgsmål?