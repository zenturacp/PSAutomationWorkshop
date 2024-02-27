# Workshop: PowerShell / Automation

Jeg hedder Christian, jeg er CTO hos Zentura som er en mindre MSP i Danmark der fokusere på small to medium kunder, det betyder for os er det et volume game og vi skal derfor være så effektive som muligt.

## Powershell Swizz army knife!

PowerShell er et cross-platform (Windows, Linux og macOS) kommandolinjeværktøj og et skriptsprog, der er udviklet af Microsoft. Det giver administratorer mulighed for at udføre **automatiseret** administration og konfiguration af både lokale og fjernsystemer. PowerShell er bygget på .NET-frameworket, hvilket giver det adgang til en bred vifte af funktioner og gør det til et kraftfuldt værktøj til automatisering.

En af de primære grunde til, at PowerShell er stærkt til automatisering, er dens **objektbaserede** natur. I modsætning til traditionelle shell-sprog, der arbejder med tekstbaserede output, arbejder PowerShell med .NET-objekter. Dette betyder, at output fra et PowerShell-kommando kan manipuleres, filtreres og arbejdes med direkte som strukturerede data. Det gør det lettere at automatisere komplekse opgaver, da administratorer kan fokusere på at arbejde med dataene i stedet for at parse tekstoutput.

PowerShell indeholder også et stort antal cmdlets (udtalt command-lets), som er indbyggede kommandoer specifikt designet til at udføre almindelige systemadministration opgaver, såsom at administrere filsystemer, processer, tjenester og registreringsdatabasen. Brugerne kan også udvikle og dele deres egne cmdlets og scripts, hvilket gør PowerShell ekstremt fleksibelt og kraftfuldt.

Desuden understøtter PowerShell scripting, hvilket giver brugere mulighed for at skrive komplekse scripts, der udfører en række opgaver automatisk. Det er særligt nyttigt for at automatisere gentagne opgaver, som at udføre regelmæssige systemtjek, deployering af software, eller konfigurering af netværksindstillinger på flere computere samtidig.

Til sidst er PowerShell integreret med alle moderne versioner af Windows og er tilgængeligt på andre platforme, hvilket gør det til et ideelt værktøj for systemadministratorer, der arbejder i heterogene netværksmiljøer. Integrationen med .NET-frameworket, sammen med understøttelse af eksisterende scriptsprog som Python og Perl, gør det muligt for administratorer at udnytte eksisterende kode og ressourcer, yderligere styrke PowerShell's evne til at automatisere komplekse systemadministration opgaver.

## Tooling

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

- [AzureADGraph.ps1](https://github.com/zenturacp/PSAutomationWorkshop/blob/main/AzureADGraph.ps1)
- [ExchangeOnline.ps1](https://github.com/zenturacp/PSAutomationWorkshop/blob/main/ExchangeOnline.ps1)
- [REST-API.ps1](https://github.com/zenturacp/PSAutomationWorkshop/blob/main/REST-API.ps1)
- [ObjektTyper.ps1](https://github.com/zenturacp/PSAutomationWorkshop/blob/main/ObjektTyper.ps1)

## Excel modul

Import Excel er et modul til at arbejde med Excel filer, det er et modul der er bygget på .NET og er derfor meget hurtigt, det kan bruges til at læse og skrive til Excel filer, og kan også bruges til at lave grafer og diagrammer.

Link til projekt: https://github.com/dfinke/ImportExcel

```powershell
Install-Module ImportExcel -Scope AllUsers
```