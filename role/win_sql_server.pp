class role::win_sql_server {
  include profile::windows::sql
  include profile::windows::iisdb
  include sqlwebapp 
}
