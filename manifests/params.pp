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
  $redis_url              = 'redis://localhost:6379/0'
  $redis_namespace        = 'logstash:beaver'
  $logstash_version       = 0
  $enable_sincedb         = true
  $sincedb_path           = '/tmp/beaver_since.db'
  $multiline_regex_after  = ''
  $multiline_regex_before = ''
}
