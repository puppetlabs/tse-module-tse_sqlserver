#
# Load configuration XML file.
#
[xml]$databases = Get-Content "C:\AttachDatabasesConfig.xml"

#
# Get SQL Server database (MDF/LDF).
#
ForEach ($database in $databases.SQL.Databases) {
    $mdfFilename = $database.MDF
    $ldfFilename = $database.LDF
    $DBName = $database.DB_Name
Start-Sleep -s 10
    #
    # Attach SQL Server database
    #
    Add-PSSnapin SqlServerCmdletSnapin* -ErrorAction SilentlyContinue
        If (!$?) {Import-Module "C:\Program Files (x86)\Microsoft SQL Server\120\Tools\PowerShell\Modules\SQLPS" -WarningAction SilentlyContinue}
If (!$?) {"Error loading Microsoft SQL Server PowerShell module. Please check if it is installed."; Exit}
$attachSQLCMD = @"
USE [master]
GO
CREATE DATABASE [$DBName] ON (FILENAME = '$mdfFilename.mdf'),(FILENAME = '$ldfFilename.ldf') for ATTACH
GO
"@ 
    Invoke-Sqlcmd $attachSQLCMD -QueryTimeout 3600 -ServerInstance '<%= @hostname %>\MYINSTANCE'
$changeowner = @"
USE AdventureWorks2012
GO
ALTER AUTHORIZATION ON DATABASE::AdventureWorks2012 TO CloudShop;
GO
"@
    Invoke-Sqlcmd $changeowner -QueryTimeout 3600 -ServerInstance '<%= @hostname %>\MYINSTANCE'
}

