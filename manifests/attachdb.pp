# This defined type is to attach a zip file containing
# mdf & ldf files into a new database within MS SQL Server 2012.
define tse_sqlserver::attachdb (
  $mdf_file      = 'AdventureWorks2012_Data',
  $ldf_file      = 'AdventureWorks2012_log',
  $zip_file      = 'AdventureWorks2012_Data.zip',
  $file_source   = 'puppet:///modules/tse_sqlserver',
  $db_instance   = 'MYINSTANCE',
  $owner         = 'CloudShop',
  $db_password   = 'Azure$123',
) {
  case $::tse_sqlserver::sqlserver_version {
    '2012':  {  
               $data_path  = 'C:\Program Files\Microsoft SQL Server\MSSQL11.MYINSTANCE\MSSQL\DATA'
               $sqlps_path = 'C:\Program Files (x86)\Microsoft SQL Server\110\Tools\PowerShell\Modules\SQLPS' 
             }
    '2014':  { 
               $data_path  = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MYINSTANCE\MSSQL\DATA'
               $sqlps_path = 'C:\Program Files (x86)\Microsoft SQL Server\120\Tools\PowerShell\Modules\SQLPS' 
             }
  }
  file { "${data_path}/${zip_file}":
    ensure => present,
    source => "${file_source}/${zip_file}",
  }
  unzip { "SQL Data ${zip_file}":
    source  => "${data_path}/${zip_file}",
    creates => "${data_path}/${mdf_file}.mdf",
    require => File["${data_path}/${zip_file}"],
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
