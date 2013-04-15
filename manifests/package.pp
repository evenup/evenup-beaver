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

  package { 'python-beaver':
    ensure  => 'latest',
  }
  
  file { '/etc/init.d/beaver':
    ensure  => file,
    mode    => '0555',
    owner   => 'root',
    group   => 'root',
    source  => 'puppet:///modules/beaver/beaver.init',
  }

}