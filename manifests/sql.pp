# Class to install SQL Server, set its configuration, create an
# instance, as well as a sample DB.
class tse_sqlserver::sql (
  $source      = 'F:/',
  $admin_user  = 'vagrant',
  $db_instance = 'MYINSTANCE',
  $sa_pass     = 'Password$123$',
  $dbport      = '49400',
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
    protocol     => 'TCP',
    local_port   => $dbport,
    display_name => 'MSSQL',
    description  => "MS SQL Server Inbound Access, enabled by Puppet in $module_name",
  }

  registry_value { 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL12.MYINSTANCE\MSSQLServer\SuperSocketNetLib\Tcp\IPAll\TcpDynamicPorts':
    ensure => present,
    type   => string,
    data   => $dbport,
  }

  registry_value { 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL12.MYINSTANCE\MSSQLServer\SuperSocketNetLib\Tcp\IPAll\TcpPort':
    ensure => present,
    type   => string,
    data   => '',
    notify => Service["MSSQL\$${db_instance}"],
  }

  service { "MSSQL\$${db_instance}":
    ensure  => running,
    require => Sqlserver_instance[$db_instance],
  }
} 
