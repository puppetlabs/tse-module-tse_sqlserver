## tse_sqlserver
### Puppet profile for installing and configuring MS SQL server

### Requires the following modules:

* staging  (https://forge.puppetlabs.com/nanliu/staging)
* mount_iso  (https://github.com/puppetlabs/puppetlabs-mount_iso)
* sqlserver  (https://forge.puppetlabs.com/puppetlabs/sqlserver)
* ACL  (https://forge.puppetlabs.com/puppetlabs/acl)
* WindowsFeature  (https://forge.puppetlabs.com/opentable/windowsfeature)
* Reboot  (https://forge.puppetlabs.com/puppetlabs/reboot)
* Unzip  (https://forge.puppetlabs.com/reidmv/unzip)
* Windows_Firewall (NEW!) (https://github.com/puppet-community/puppet-windows_firewall)

*Sample IIS web app module that can be laid on top of this can be found at the following github URL:*
https://github.com/velocity303/puppet-sqlwebapp

## General Instructions:

This module acts as a profile for implementing the PuppetLabs SQL Server module. This is a particular implementation of the SQL Server module that will install the software, SSMS, set up the sa account, create a user, and setup a sample database. The sample database that is imported by default with the attachdb defined type will be for the Sample IIS Web Application linked to above.

### To setup:
This module no longer requires hiera to use properly and can be used without. There are only a few parameters to pass to the classes if an override is necessary, but the defaults should provide very sane results.

This module can now stage the appropriate files to your windows machine. It currently points to a location in AWS to download the appropriate files. This is recommended before proceeding with including the rest of the code due to the large and slow download process. The mount_iso class will handle this entirely for you to stage SQL Server 2014.
```puppet
include tse_sqlserver::mount_iso
```

Doing a regular include will proceed with a basic install of MS SQL Server. If you would like to install a web application in addition to this, please see the associated module sqlwebapp - https://github.com/velocity303/puppet-sqlwebapp

```puppet
include tse_sqlserver
```

A defined type for attaching databases to your SQL Server instance is included. The mdf and ldf files are produced due to extraction of the zip file.

```puppet
tse_sqlserver::attachdb { $dbname:
  file_source => $file_source,
  dbinstance  => $dbinstance,
  dbpass      => $dbpass,
  owner       => $dbuser,
  mdf_file    => 'AdventureWorks2012_Data.mdf',
  ldf_file    => 'AdventureWorks2012_log.ldf',
  zip_file    => 'AdventureWorks2012_Data.zip',
}
```

### Required options:

`tse_sqlserver::mount_iso:`
 Whether the ISO should be mounted with the mount class provided. Default: True

`tse_sqlserver::sqlserver_version:` The version of MS SQL Server you are going to be installing, this can be either '2012' or '2014'.

`tse_sqlserver::mount::iso:` The name of the ISO you would like to load the SQL installation files from.

`tse_sqlserver::mount::iso_drive:` The drive letter you would like to use for mounting of the drive.

`tse_sqlserver::mount::iso_source:` The location of the iso to be downloaded to your server.

`tse_sqlserver::sql::source:` The source directory for the sql server installation media. This will either point to the drive where you mounted your installation media via ISO or alternatively an extracted version of the ISO contents into a local directory on the machine. For local directory usage, please ensure mount_iso is set to false.

`tse_sqlserver::sql::admin_user:` Admin windows user account for your sql server install. Defaults to vagrant for the demo environment, but may need to be altered to Administrator for other servers.

`tse_sqlserver::sql::db_instance:` Name of the DB instance you would like to install.

`tse_sqlserver::sql::sa_pass:` The SA Password for SQL Server.
