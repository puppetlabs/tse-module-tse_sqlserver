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
