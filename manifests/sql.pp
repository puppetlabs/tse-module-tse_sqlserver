# Class to install SQL Server, set its configuration, create an
# instance, as well as a sample DB.
class tse_sqlserver::sql (
  $source = 'F:/',
  $admin_user = 'Administrator',
  $db_instance = 'MYINSTANCE',
  $sa_pass = 'Password$123$',
  $db_name = 'sampledb'
) {
  reboot { 'before install':
      when => pending,
  }

  service { 'wuauserv':
    ensure => running,
    enable => true,
    before => Windowsfeature['Net-Framework-Core'],
  }

  windowsfeature { 'Net-Framework-Core':
    before => Sqlserver::Database[$db_name],
  }
  sqlserver_instance{ $db_instance:
    ensure                => present,
    features              => ['SQL'],
    source                => $source,
    security_mode         => 'SQL',
    sa_pwd                => $sa_pass,
    sql_sysadmin_accounts => [$admin_user],
  }
  sqlserver_features { 'Management_Studio':
    source   => $source,
    features => ['SSMS'],
  }
  sqlserver::config{ $db_instance:
    admin_user => 'sa',
    admin_pass => $sa_pass,
  }
  sqlserver::database{ $db_name:
    ensure   => present,
    db_name  => $db_name,
    instance => $db_instance,
  }
}
