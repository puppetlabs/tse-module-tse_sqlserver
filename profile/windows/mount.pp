class profile::windows::mount {

  include profile::staging

  #  staging::file { 'SQLServer2014-x64-ENU.iso':
  #    source => 'puppet:///modules/profile/SQLServer2014-x64-ENU.iso',
  #  }
  #
  #  acl { 'c:/staging/profile/SQLServer2014-x64-ENU.iso':
  #    permissions  => [
  #      { identity => 'Everyone', rights       => [ 'full' ] },
  #      { identity => 'Administrators', rights => [ 'full' ] },
  #      { identity => 'vagrant', rights        => [ 'full' ] },
  #    ],
  #    require => Staging::File['SQLServer2014-x64-ENU.iso'],
  #    before  => Mount_iso['c:/staging/profile/SQLServer2014-x64-ENU.iso'],
  #  }

  mount_iso { 'c:/staging/profile/SQLServer2014-x64-ENU.iso':
    drive_letter => 'F',
  }

}
