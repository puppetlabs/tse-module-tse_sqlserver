class tse_sqlserver::params {
  case $::tse_sqlserver::sqlserver_version {
    '2012': { $path       = 'C:\Program Files\Microsoft SQL Sersver\MSSQL11.MYINSTANCE\MSSQL\DATA'
              $sqlps_path = 'C:\Program Files (x86)\Microsoft SQL Server\110\Tools\PowerShell\Modules\SQLPS' 
            }
    '2014': { $path = 'C:\Program Files\Microsoft SQL Sersver\MSSQL12.MYINSTANCE\MSSQL\DATA'
              $sqlps_path = 'C:\Program Files (x86)\Microsoft SQL Server\110\Tools\PowerShell\Modules\SQLPS' 
            }
  }
}
