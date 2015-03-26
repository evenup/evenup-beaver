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
# [*exlcude*]
#   String/Array of strings.  Valid python regex strings to exlude
#   from file globs.
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
define beaver::stanza (
  $type,
  $source                 = undef,
  $tags                   = [],
  $redis_url              = undef,
  $redis_namespace        = undef,
  $format                 = undef,
  $exclude                = [],
  $sincedb_write_interval = 300,
){

  if $source {
    $source_real = $source
  } else {
    $source_real = $name
  }

  validate_string($type, $source_real)
  if ! is_integer($sincedb_write_interval) { fail('sincedb_write_interval is not an integer') }

  include ::beaver
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
