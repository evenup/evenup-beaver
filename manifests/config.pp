# == Class: beaver::config
#
# This class is responsible for configuring beaver
# It should not be directly called
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
class beaver::config {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  file { '/etc/beaver/beaver.conf':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0744',
    content => template('beaver/beaver.conf.erb'),
    notify  => Class['beaver::service']
  }

}
