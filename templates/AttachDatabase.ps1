#
# Attach SQL Server database
#
Add-PSSnapin SqlServerCmdletSnapin* -ErrorAction SilentlyContinue
If (!$?) {Import-Module "C:\Program Files (x86)\Microsoft SQL Server\120\Tools\PowerShell\Modules\SQLPS" -WarningAction SilentlyContinue}
If (!$?) {"Error loading Microsoft SQL Server PowerShell module. Please check if it is installed."; Exit}

$attachSQLCMD = @"
USE [master]
GO
CREATE DATABASE [<%= @title %>] ON (FILENAME = '<%= @mdf_file %>'),(FILENAME = '<%= @ldf_file %>') for ATTACH
GO
"@ 
    Invoke-Sqlcmd $attachSQLCMD -QueryTimeout 3600 -ServerInstance '<%= @hostname %>\<%= @db_instance %>'
$changeowner = @"
USE <%= @title %> 
GO
ALTER AUTHORIZATION ON DATABASE::<%= @title %> TO <%= @owner %>;
GO
"@
    Invoke-Sqlcmd $changeowner -QueryTimeout 3600 -ServerInstance '<%= @hostname %>\<%= @db_instance %>'
