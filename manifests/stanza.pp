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
  $source           = '',
  $tags             = [],
  $redis_url        = '',
  $redis_namespace  = '',
  $format           = '',
){

  include beaver
  Class['beaver::package'] ->
  Beaver::Stanza[$name] ~>
  Class['beaver::service']

  $source_real = $source ? {
    ''      => $name,
    default => $source,
  }

  concat::fragment { "beaver.conf_${name}":
    content => template('beaver/beaver.stanza.erb'),
    target  => '/etc/beaver.conf',
    order   => 10,
  }

}
