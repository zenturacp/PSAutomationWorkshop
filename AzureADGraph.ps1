# Connect to Microsoft Graph API using Azure AD
Connect-MGGraph -scopes "User.Read.All", "AuditLog.Read.All"

# Show my current scope
$context = Get-MGContext
$context.Scopes

# Get all users
$allUsers = Get-MGUser

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

$allUsers = Get-MgUser -userid "a13a5e5a-38c5-4b39-8c39-9bbb0c6f11e3" -Property $properties
$allUsers | Format-List

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