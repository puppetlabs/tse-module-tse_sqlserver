class profile::windows::sampleapp (
  $sqldatadir = 'C:/Program Files/Microsoft SQL Server/MSSQL12.MYINSTANCE/MSSQL/DATA/',
) {
  staging::deploy { "AdventureWorks2012_Data.zip":
    target  => $sqldatadir,
    creates => "${sqldatadir}/AdventureWorks2012_Data.mdf",
    source  => "http://master.inf.puppetlabs.demo/AdventureWorks2012_Data.zip",
    require => Class['profile::windows::sql'],
    notify  => Exec['SetupDB'],
  }
  file { 'C:/AttachDatabase.ps1':
    ensure  => present,
    content => template('profile/AttachDatabase.ps1'),
  }
  file { 'C:/AttachDatabasesConfig.xml':
    ensure  => present,
    content => template('profile/AttachDatabasesConfig.xml.erb'),
  }
  file { 'C:/inetpub/wwwroot/CloudShop':
    ensure  => directory,
    require => Class['profile::windows::iisdb'],
  }
  staging::deploy { "CloudShop.zip":
    target  => 'C:/inetpub/wwwroot/CloudShop',
    creates => 'C:/inetpub/wwwroot/CloudShop/packages.config',
    source  => "http://master.inf.puppetlabs.demo/CloudShop.zip",
    require => File['C:/inetpub/wwwroot/CloudShop'],
    notify  => Exec['ConvertAPP'],
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
  file { 'C:/inetpub/wwwroot/CloudShop/Web.config':
    ensure  => present,
    content => template('profile/Web.config.erb'),
    require => Staging::Deploy['CloudShop.zip'],
  }
  sqlserver::login{'CloudShop':
     instance => 'MYINSTANCE',
     password => 'Azure$123',
  }  
}
