# == Class: beaver::config
#
# This class is responsible for configuring beaver
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
class beaver::config {

  concat { '/etc/beaver.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    notify  => Class['beaver::service']
  }

  concat::fragment { 'beaver.conf_header':
    content => template('beaver/beaver.conf.erb'),
    target  => '/etc/beaver.conf',
    order   => 01,
  }

}
