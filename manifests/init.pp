# Main class that declares SQL, IISDB, and creates an
# instance of the attachDB defined type.
class tse_sqlserver (
  $sqlserver_version = '2014',
  $mount_iso = true,
) {

  if $mount_iso {
    contain tse_sqlserver::mount
    Class['tse_sqlserver::mount'] -> Class['tse_sqlserver::sql']
  }

  contain tse_sqlserver::sql
}
