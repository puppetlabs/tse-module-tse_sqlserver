# This class is used to mount an ISO containing the SQL Server 2014 Code.
class tse_sqlserver::mount (
  $iso = 'SQLServer2012SP1-FullSlipstream-ENU-x64.iso',
) {

  include tse_sqlserver::staging

  staging::file { $iso:
    source => "puppet:///modules/tse_sqlserver/${iso}",
  }

  acl { "c:/staging/tse_sqlserver/${iso}":
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
    require      => Staging::File[$iso],
    before       => Mount_iso["c:/staging/tse_sqlserver/${iso}"],
  }

  mount_iso { "c:/staging/tse_sqlserver/${iso}":
    drive_letter => 'F',
  }

}
