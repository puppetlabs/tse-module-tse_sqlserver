class role::win_sql_server {
  include profile::windows::mount
  include profile::windows::sqlserver
}
