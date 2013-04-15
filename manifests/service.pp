# == Class: beaver::service
#
# This class installs the beaver package and init scripts.
# It should not be directly called
#
#
# === Parameters
# [*enable*]
#   Boolean.  Should the beaver service be enabled?
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
class beaver::service(
  $enable = true,
) {

  case $enable {
    true, 'true', True: {
      $ensure_real = 'running'
      $enable_real = true
    }
    default: {
      $ensure_real = 'stopped'
      $enable_real = false
    }
  }

  service { 'beaver':
    ensure  => $ensure_real,
    enable  => $enable_real,
  }
}