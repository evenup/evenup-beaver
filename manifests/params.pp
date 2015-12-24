# == Class: beaver::params
#
# This class is responsible for setting defaults
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
class beaver::params {
  $enable                 = true
  $package_name           = 'beaver'
  $package_provider       = 'pip'
  $version                = 'installed'
  $redis_host             = 'localhost'
  $redis_db               = 0
  $redis_port             = 6379
  $redis_namespace        = 'logstash:beaver'
  $logstash_version       = 0
  $enable_sincedb         = true
  $sincedb_path           = '/tmp/beaver_since.db'
  $multiline_regex_after  = ''
  $multiline_regex_before = ''
}
