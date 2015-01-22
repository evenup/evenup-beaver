# == Class: beaver::stanzas
#
# This class can be included to load stanzas from hiera
#
#
# === Authors
#
# * pvbouwel <https://github.com/pvbouwel>
#
#
# === Copyright
#
# Copyright 2013 EvenUp.
#
class beaver::stanzas {
  $hiera_config = hiera_hash('beaver::stanzas', undef)
  if $hiera_config {
    create_resources(stanza, $hiera_config)
  }
}