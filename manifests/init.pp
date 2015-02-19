# Main class that declares SQL, IISDB, and creates an
# instance of the attachDB defined type.
class tse_sqlserver {
  include tse_sqlserver::mount
  include tse_sqlserver::sql
  include tse_sqlserver::iisdb
  #  tse_sqlserver::attachdb { 'AdventureWorks2012': }
}
