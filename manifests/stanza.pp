# == Define: beaver::stanza
#
# This define is responsible for adding stanzas to the beaver config
#
#
# === Parameters
# [*type*]
#   String.  Type to be passed on to logstash
#
# [*source*]
#   String.  Source logfile to be read
#
# [*tags*]
#   String/Array of strings.  What tags should be added to this stream and
#   passed back to logstash
#
# [*add_field*]
#   String/Array of strings. 
#
# [*exclude*]
#   String. Regex to match files that should be left out. eg: .gz$
#
# [*redis_url*]
#   String.  Redis connection url to use for this specific log stream
#
# [*redis_namespace*]
#   String.  Redis namespace to use for this specific log stream
#
# [*format*]
#   String.  What format is the source logfile in.
#   Valid options: json, msgpack, raw, rawjson, string
#   Default (unset): json
#
# [*sincedb_write_interval*]
#   Integer.  Number of seconds between sincedb write updates
#   Default: 3
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
define beaver::stanza (
  $type,
  $source                 = '',
  $tags                   = [],
  $add_field              = [],
  $exclude                = '',
  $redis_url              = '',
  $redis_namespace        = '',
  $format                 = '',
  $sincedb_write_interval = 300,
){

  $source_real = $source ? {
    ''      => $name,
    default => $source,
  }

  validate_string($type, $source, $source_real)
  if type($sincedb_write_interval) != 'integer' { fail('sincedb_write_interval is not an integer') }

  include beaver
  Class['beaver::package'] ->
  Beaver::Stanza[$name] ~>
  Class['beaver::service']

  $filename = regsubst($name, '[/:\n]', '_', 'GM')
  file { "/etc/beaver/conf.d/${filename}":
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    content => template("${module_name}/beaver.stanza.erb"),
    notify  => Class['beaver::service'],
  }

}
