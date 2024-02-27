# Connect to Microsoft Graph API using Azure AD
Connect-MGGraph -UseDeviceCode -scopes "User.Read.All", "AuditLog.Read.All"

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