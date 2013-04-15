# == Class: beaver
#
# This class installs and configures beaver, the logstash shipper
# https://github.com/josegonzalez/beaver
#
#
# === Parameters
# [*enable*]
#   Boolean.  Should the beaver service be running?
#   Default: true
#
# [*redis_host*]
#   String.  Default redis to send logs to
#   Default: localhost
#
# [*redis_db*]
#   Integer.  Default redis db to write logs to
#   Default: 0
#
# [*redis_port*]
#   Integer.  Default port to use for the redis connection
#   Default: 6379
#
# [*redis_namespace*]
#   String.  Default namespace beaver should write logs to
#   Default:  logstash::beaver
#
#
# === Examples
#
# * Installation:
#     class { 'beaver': }
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
class beaver (
  $enable           = true,
  $redis_host       = 'localhost',
  $redis_db         = 0,
  $redis_port       = 6379,
  $redis_namespace  = 'logstash:beaver'
){

  class { 'beaver::package': } ->
  class { 'beaver::config': } ~>
  class { 'beaver::service': enable => $enable } ->
  Class['beaver']

}
