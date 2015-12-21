# Class to install SQL Server, set its configuration, create an
# instance, as well as a sample DB.
class tse_sqlserver::sql (
  $source = 'F:/',
  $admin_user = 'vagrant',
  $db_instance = 'MYINSTANCE',
  $sa_pass = 'Password$123$',
) {
  reboot { 'before install':
      when => pending,
  }
  dotnet { 'dotnet35-sql': version => '3.5' }
  sqlserver_instance{ $db_instance:
    ensure                => present,
    features              => ['SQL'],
    source                => $source,
    security_mode         => 'SQL',
    sa_pwd                => $sa_pass,
    sql_sysadmin_accounts => [$admin_user],
    require               => Dotnet['dotnet35-sql'],
  }
  sqlserver_features { 'Management_Studio':
    source   => $source,
    features => ['SSMS'],
  }
  sqlserver::config{ $db_instance:
    admin_user => 'sa',
    admin_pass => $sa_pass,
  }
  windows_firewall::exception { 'Sqlserver Access':
    ensure       => present,
    direction    => 'in',
    action       => 'Allow',
    enabled      => 'yes',
    program      => 'C:\Program Files\Microsoft SQL Server\MSSQL12.MYINSTANCE\MSSQL\Binn\sqlserver.exe'
    display_name => 'MSSQL',
    description  => "MS SQL Server Inbound Access, enabled by Puppet in $module_name",
  }
}
