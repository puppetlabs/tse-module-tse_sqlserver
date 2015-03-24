class tse_sqlserver::staging {
  case $osfamily {
    'windows': {
      class { '::staging':
        path  => 'c:\staging',
        owner => 'BUILTIN\Administrators',
        group => 'NT AUTHORITY\SYSTEM',
      }
    }
    default: {
      class {'::staging':
        path  => '/var/staging',
        owner => root,
        group => root,
      }
    }
  }
}
