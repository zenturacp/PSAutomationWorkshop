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

