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
# [*package_name*]
#   String.  Name of the beaver package
#   Default: beaver
#
# [*package_provider*]
#   String.  Package provider for beaver
#   Default: pip
#
# [*python_version*]
#   String: Version of python for virtualenv
#   Default: 2.7
#
# [*home*]
#   String: Home directory for the virtualenv user
#   Default: /home/beaver
#
# [*venv*]
#   String: Directory target for the virtualenv
#   Default: ${home}/venv
#
# [*user*]
#   String: User to install/run in virtualenv
#   Default: beaver
#
# [*group*]
#   String: Group to install/run in virtualenv
#   Default: beaver
#
# [*version*]
#   String.  What version of beaver to install
#   Default: installed
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
# [*queue_timeout*]
#   Integer. Timeout value for active queues.
#   Default: 60
#
# [*logstash_version*]
#   Integer.  Pre-1.2 (0) or 1.2+ logstash (1)?
#   Default: 0
#
# [*enable_sincedb*]
#   Boolean.  Whether or not sincedb tracking should be enabled
#   Default: true
#
# [*sincedb_path*]
#   String.  Location for sincedb sqlite3 database.  Beaver needs rw to this location
#   Default: /tmp/beaver
#
# [*multiline_regex_after*]
#   String.   If a line match this regular expression, it will be merged with next line(s)
#
# [*multiline_regex_before*]
#   String.   If a line match this regular expression, it will be merged with previous line(s).
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
  $enable                 = $beaver::params::enable,
  $package_name           = $beaver::params::package_name,
  $package_provider       = $beaver::params::package_provider,
  $python_version         = $beaver::params::python_version,
  $home                   = $beaver::params::home,
  $venv                   = $beaver::params::venv,
  $user                   = $beaver::params::user,
  $group                  = $beaver::params::group,
  $version                = $beaver::params::version,
  $redis_host             = $beaver::params::redis_host,
  $redis_db               = $beaver::params::redis_db,
  $redis_port             = $beaver::params::redis_port,
  $redis_namespace        = $beaver::params::redis_namespace,
  $queue_timeout          = $beaver::params::queue_timeout,
  $logstash_version       = $beaver::params::logstash_version,
  $enable_sincedb         = $beaver::params::enable_sincedb,
  $sincedb_path           = $beaver::params::sincedb_path,
  $multiline_regex_after  = $beaver::params::multiline_regex_after,
  $multiline_regex_before = $beaver::params::multiline_regex_before,
) inherits beaver::params {

  validate_bool($enable, $enable_sincedb)
  if type($redis_db) != 'integer' { fail('redis_db is not an integer') }
  if type($redis_port) != 'integer' { fail('redis_port is not an integer') }
  if $logstash_version > 1 {
    fail("logstash_version must be 0 or 1, got ${logstash_version}")
  }
  validate_string($redis_host, $redis_namespace)

  class { 'beaver::package': } ->
  class { 'beaver::config': } ~>
  class { 'beaver::service': } ->
  Class['beaver']

}
