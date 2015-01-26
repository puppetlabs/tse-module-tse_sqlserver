class profile::windows::sql (
  $source     = 'C:/vagrant/sqlserver',
  $admin_user = 'vagrant',
) {
  reboot { 'before install':
    when => pending,
  }
  windowsfeature { 'Net-Framework-Core':
    before => Sqlserver_instance['MyInstance'],
  }
  sqlserver_instance{ 'MyInstance':
    ensure                => present,
    features              => ['SQL'],
    source                => $source,
    sql_sysadmin_accounts => [$admin_user],
  }
  sqlserver_features { 'Tools':
    source   => $source,
    features => ['Tools'],
  }
  sqlserver::config{ 'MyInstance':
    admin_user => 'sa',
    admin_pass => 'MySecretPassword',
  }
  sqlserver::database{ 'MyDB':
    ensure   => present,
    instance => 'MyInstance',
  }
}
