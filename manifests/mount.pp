# This class is used to mount an ISO containing the SQL Server 2014 Code.
class tse_sqlserver::mount {

  include tse_sqlserver::staging

  staging::file { 'SQLServer2014-x64-ENU.iso':
    source => 'puppet:///modules/tse_sqlserver/SQLServer2014-x64-ENU.iso',
  }

  acl { 'c:/staging/tse_sqlserver/SQLServer2014-x64-ENU.iso':
    permissions  => [
      {
        identity => 'Everyone',
        rights   => [ 'full' ]
      },
      {
        identity => 'Administrators',
        rights   => [ 'full' ]
      },
      {
        identity => 'vagrant',
        rights   => [ 'full' ]
      },
    ],
    require      => Staging::File['SQLServer2014-x64-ENU.iso'],
    before       => Mount_iso['c:/staging/tse_sqlserver/SQLServer2014-x64-ENU.iso'],
  }

  mount_iso { 'c:/staging/tse_sqlserver/SQLServer2014-x64-ENU.iso':
    drive_letter => 'F',
  }

}
