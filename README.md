# Workshop: PowerShell / Automation

![Narnia](./Assets/narnia.webp)

## Hvem er jeg kort?

- Christian Pedersen
- CTO i Zentura A/S MSP med fokus på små / mellemstore kunder
- Volume game, mange kunder, mange opgaver
- Fra Amiga 500 til Azure og alt imellem
- AZ-* Certificeret
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

- [AzureADGraph.ps1](https://github.com/zenturacp/PSAutomationWorkshop/blob/main/AzureADGraph.ps1){:target="_blank"}
- [ExchangeOnline.ps1](https://github.com/zenturacp/PSAutomationWorkshop/blob/main/ExchangeOnline.ps1){:target="_blank"}
- [REST-API.ps1](https://github.com/zenturacp/PSAutomationWorkshop/blob/main/REST-API.ps1){:target="_blank"}
- [ObjektTyper.ps1](https://github.com/zenturacp/PSAutomationWorkshop/blob/main/ObjektTyper.ps1){:target="_blank"}

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

[Function App eksemple](https://portal.azure.com/#@advokat-jensen.dk/resource/subscriptions/caaf1a53-3a0a-42e4-9688-4aac8f95a2d7/resourceGroups/PSWorkshop/providers/Microsoft.Web/sites/psworkshop/appServices)

