class profile::windows::sampleapp (
  $sqldatadir  = 'C:/Program Files/Microsoft SQL Server/MSSQL12.MYINSTANCE/MSSQL/DATA/',
  $docroot     = 'C:/inetpub/wwwroot',
  $db_instance = 'MYINSTANCE',
) {
  file { "${docroot}/CloudShop":
    ensure  => directory,
    require => Class['profile::windows::iisdb'],
  }
  staging::deploy { "AdventureWorks2012_Data.zip":
    target  => $sqldatadir,
    creates => "${sqldatadir}/AdventureWorks2012_Data.mdf",
    source  => "http://master.inf.puppetlabs.demo/AdventureWorks2012_Data.zip",
    require => Class['profile::windows::sql'],
    notify  => Exec['SetupDB'],
  }
  staging::deploy { "CloudShop.zip":
    target  => "${docroot}/CloudShop",
    creates => "${docroot}/CloudShop/packages.config",
    source  => "http://master.inf.puppetlabs.demo/CloudShop.zip",
    require => File["${docroot}/CloudShop"],
    notify  => Exec['ConvertAPP'],
  }
  file { "${docroot}/CloudShop/Web.config":
    ensure  => present,
    content => template('profile/Web.config.erb'),
    require => Staging::Deploy['CloudShop.zip'],
  }
  file { 'C:/AttachDatabasesConfig.xml':
    ensure  => present,
    content => template('profile/AttachDatabasesConfig.xml.erb'),
  }
  exec { 'SetupDB':
    command     => template('profile/AttachDatabase.ps1'),
    provider    => powershell,
    refreshonly => true,
    logoutput   => true,
  }
  exec { 'ConvertAPP':
    command     => 'ConvertTo-WebApplication "IIS:\Sites\Default Web Site\CloudShop"',
    provider    => powershell,
    refreshonly => true,
  }
  sqlserver::login{'CloudShop':
     instance => $db_instance,
     password => 'Azure$123',
  }  
}
