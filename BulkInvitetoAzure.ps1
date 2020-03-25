# Bulk invite to Azure Ad | sturner@thechineseroom.co.uk

# connect to Azure with your credentials | must have AzureAD module installed.

Connect-AzureAD

Function Get-FileName($InitialDirectory)
{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

  $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
  $OpenFileDialog.initialDirectory = $initialDirectory
  $OpenFileDialog.filter = "CSV (*.csv) | *.csv"
  $OpenFileDialog.ShowDialog() | Out-Null
  $OpenFileDialog.FileName
}

$csv = Get-FileName | Import-Csv
$InvitationMessage = New-Object Microsoft.Open.MSGraph.Model.InvitedUserMessageInfo
$InvitationMessage.CustomizedMessageBody = "Hello, you have been invited to the contoso organisation."

foreach ($email in $csv)
{
    New-AzureADMSInvitation `
    -InvitedUserEmailAddress $email.InvitedUserEmailAddress `
    -InvitedUserDisplayName $email.Name `
    -InviteRedirectUrl https://myapps.microsoft.com/YOURDOMAINHERE`
    -InvitedUserMessageInfo $InvitationMessage `
    -SendInvitationMessage $true
}
