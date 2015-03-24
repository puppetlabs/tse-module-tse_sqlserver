# This defined type is to attach a zip file containing
# mdf & ldf files into a new database within MS SQL Server 2012.
define tse_sqlserver::attachdb (
  $mdf_file      = 'AdventureWorks2012_Data',
  $ldf_file      = 'AdventureWorks2012_log',
  $zip_file      = 'AdventureWorks2012_Data.zip',
  $path          = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MYINSTANCE\MSSQL\DATA',
  $file_source   = 'puppet:///modules/tse_sqlserver/',
  $db_instance   = 'MYINSTANCE',
  $owner         = 'CloudShop',
  $db_password   = 'Azure$123',
) {
  file { "${path}/${zip_file}":
    ensure => present,
    source => "${file_source}/${zip_file}",
  }
  unzip { "SQL Data ${zip_file}":
    source  => "${path}/${zip_file}",
    creates => "${path}/${mdf_file}.mdf",
    require => File["${path}/${zip_file}"],
  }
  file { "C:/AttachDatabaseConfig_${title}.xml":
    ensure  => present,
    content => template("${module_name}/AttachDatabaseConfig.xml.erb"),
    require => Unzip["SQL Data ${zip_file}"],
  }
  exec { "Attach ${mdf_file}_${title}":
    command     => template("${module_name}/AttachDatabase.ps1"),
    provider    => powershell,
    refreshonly => true,
    logoutput   => true,
  }
  sqlserver::login{ $owner:
    instance => $db_instance,
    password => $db_password,
    notify   => Exec["Attach ${mdf_file}_${title}"],
    require  => File["C:/AttachDatabaseConfig_${title}.xml"],
  }
}
