class tse_sqlserver::staging {
    class { '::staging':
      path  => 'c:\staging',
      owner => 'BUILTIN\Administrators',
      group => 'NT AUTHORITY\SYSTEM',
  }
}
