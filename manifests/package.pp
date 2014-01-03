# == Class: beaver::package
#
# This class installs the beaver package and init scripts.
# It should not be directly called
#
#
# === Parameters
#   None
#
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
#
# === Copyright
#
# Copyright 2013 EvenUp.
#
class beaver::package {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  package { $beaver::package_name:
    ensure    => $beaver::version,
    provider  => $beaver::package_provider,
    notify    => Class['beaver::service'],
  }

  file { '/etc/init.d/beaver':
    ensure  => file,
    mode    => '0555',
    owner   => 'root',
    group   => 'root',
    source  => 'puppet:///modules/beaver/beaver.init',
  }

  file { '/etc/beaver':
    ensure  => 'directory',
    mode    => '0555',
    owner   => 'root',
    group   => 'root',
  }

  file { '/etc/beaver/conf.d':
    ensure  => 'directory',
    mode    => '0555',
    owner   => 'root',
    group   => 'root',
  }

}
