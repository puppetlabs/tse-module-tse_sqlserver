class profile::windows::sql (
  $source      = 'C:/vagrant/sqlserver',
  $admin_user  = 'vagrant',
  $db_instance = 'MYINSTANCE',
) {
  reboot { 'before install':
      when => pending,
  }
  service { 'wuauserv':
    ensure  => running,
    enable  => true,
    before  => Windowsfeature['Net-Framework-Core'],
  }
  windowsfeature { 'Net-Framework-Core':
    before => Sqlserver::Database['mytest'],
  }
  sqlserver_instance{ $db_instance:
    ensure                => present,
    features              => ['SQL'],
    source                => $source,
    security_mode	  => 'SQL',
    sa_pwd                => 'MySecretPassword',
    sql_sysadmin_accounts => [$admin_user],
  }
  sqlserver_features { 'Management_Studio':
    source   => $source,
    features => ['SSMS'],
  }
  sqlserver::config{ $db_instance:
    admin_user => 'sa',
    admin_pass => 'MySecretPassword',
  }
  sqlserver::database{ 'mytest':
    ensure   => present,
    db_name  => 'mytest',
    instance => $db_instance,
  }
}
