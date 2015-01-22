class profile::windows::sqlserver {

  sqlserver_instance { 'MSSQLSERVER': 
    ensure                => present,
    features              => [ 'SQL' ],
    source                => 'F:/',
    sql_sysadmin_accounts => [ 'vagrant' ],
  }


}
