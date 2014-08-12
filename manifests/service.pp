# == Class: beaver::service
#
# This class installs the beaver package and init scripts.
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
class beaver::service {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  case $beaver::enable {
    true: {
      $ensure_real = 'running'
      $enable_real = true
    }
    default: {
      $ensure_real = 'stopped'
      $enable_real = false
    }
  }

  service { 'beaver':
    ensure => $ensure_real,
    enable => $enable_real,
  }
}
