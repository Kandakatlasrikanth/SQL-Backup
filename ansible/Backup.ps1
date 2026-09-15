param(
    [ValidateSet("FULL", "DIFF", "LOG")]
    [string]$BackupType 
)

$ServerInstance = "localhost"
$BackupDirectory = "C:\SQLBackups"

$query = @"
EXEC master.dbo.DatabaseBackup
    @Databases = 'USER_DATABASES',
    @Directory = '$BackupDirectory',
    @BackupType = '$BackupType',
    @Verify = 'Y',
    @CleanupTime = 168,
    @CheckSum = 'Y',
    @LogToTable = 'Y';
"@

$Result =Invoke-Sqlcmd `
    -ServerInstance $ServerInstance `
    -Database master `
    -Query $query `
    -Verbose  4>&1

$Result |out-string|out-file $LogFile -Append
