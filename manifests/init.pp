# Main class that declares SQL, IISDB, and creates an
# instance of the attachDB defined type.
class tse_sqlserver (
  $sqlserver_version,
  $mount_iso,
) {

  if $mount_iso {
    contain tse_sqlserver::mount
  }

  contain tse_sqlserver::sql
  tse_sqlserver::attachdb { 'AdventureWorks2012': }
}
