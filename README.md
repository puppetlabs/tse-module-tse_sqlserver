# tse_sqlserver
Puppet role and profiles for installing and configuring MS SQL server

Requires the following modules:

* staging (https://forge.puppetlabs.com/nanliu/staging)
* mount_iso (https://github.com/puppetlabs/puppetlabs-mount_iso)
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
Use the example.yaml file that is provided in the file directory for setting up your hiera data.

Required options:

mount_iso: dictates whether the iso should be mounted with the mount class provided. This will by default be served by the Puppet file server. If utilizing this feature, please place the ISO file that you need in the files directory. You will also need to specify the name of the iso in your hiera YAML file as shown in the example.yaml.

sqlserver_version: dictates the version of MS SQL Server you are going to be installing, this can be either '2012' or '2014'.


