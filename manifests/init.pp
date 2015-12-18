# Main class that declares SQL, IISDB, and creates an
# instance of the attachDB defined type.
class tse_sqlserver (
  $sqlserver_version = '2014',
  $mount_iso = True,
) {

  if $mount_iso {
    contain tse_sqlserver::mount
  }

  contain tse_sqlserver::sql
}
