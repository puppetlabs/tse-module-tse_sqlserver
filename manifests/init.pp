class tse_sqlserver {
  include tse_sqlserver::sql
  include tse_sqlserver::iisdb
  tse_sqlserver::attachdb { 'AdventureWorks2012': }
}
