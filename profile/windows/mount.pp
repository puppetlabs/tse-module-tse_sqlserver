class profile::windows::mount {

  include profile::staging

  staging::file { 'SQLServer2014-x64-ENU.iso':
    source => 'puppet:///modules/profile/SQLServer2014-x64-ENU.iso',
  }

  mount_iso { 'C:\\staging\\profile\SQLServer2014-x64-ENU.iso':
    drive_letter => 'H',
  }

}
