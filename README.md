# tse_sqlserver
Puppet role and profiles for installing and configuring MS SQL server

Requires the following modules:

* staging (https://forge.puppetlabs.com/nanliu/staging)
* mount_ISO (https://github.com/puppetlabs/puppetlabs-mount_ISO)
* sqlserver (https://forge.puppetlabs.com/puppetlabs/sqlserver)
* ACL (https://forge.puppetlabs.com/puppetlabs/acl)
* WindowsFeature (https://forge.puppetlabs.com/opentable/windowsfeature)
* Reboot (https://forge.puppetlabs.com/puppetlabs/reboot)
* Unzip (https://forge.puppetlabs.com/reidmv/unzip)

Sample IIS web app module that can be laid on top of this can be found at the following github URL:
https://github.com/velocity303/puppet-sqlwebapp

General Instructions:

This module acts as a profile for implementing the PuppetLabs SQL Server module. This is a particular implementation of the SQL Server module that will install the software, SSMS, set up the sa account, create a user, and setup a sample database. The sample database that is imported by default with the attachdb defined type will be for the Sample IIS Web Application linked to above.

To setup:
Use the example.yaml file that is provided in the files directory for setting up your hiera data. This should include some sane defaults. Additionally, if using the mount_ISO option, please place the ISO file in your files directory within the module and update the name of the ISO in your hieradata. This will ensure it can be properly deployed to the machine. 

Required options:

tse_sqlserver::mount_ISO: Whether the ISO should be mounted with the mount class provided. This will by default be served by the Puppet file server. If utilizing this feature, please place the ISO file that you need in the files directory. You will also need to specify the name of the ISO in your hiera YAML file as shown in the example.yaml.

tse_sqlserver::sqlserver_version: The version of MS SQL Server you are going to be installing, this can be either '2012' or '2014'.

tse_sqlserver::mount::iso: The name of the ISO you would like to load the SQL installation files from.

tse_sqlserver::mount::iso_drive: The drive letter you would like to use for mounting of the drive.

tse_sqlserver::sql::source: The source directory for the sql server installation media. This will either point to the drive where you mounted your installation media via ISO or alternatively an extracted version of the ISO contents into a local directory on the machine. For local directory usage, please ensure mount_iso is set to false.

tse_sqlserver::sql::admin_user: Admin windows user account for your sql server install.

tse_sqlserver::sql::db_instance: Name of the DB instance you would like to install.

tse_sqlserver::sql::sa_pass: The SA Password for SQL Server. 

tse_sqlserver::sql::db_name: The name of the DB you would like to create in your instance.
