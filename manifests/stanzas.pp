# == Class: beaver::stanzas
#
# This class can be included to load stanzas from hiera
#
#
# === Authors
#
# * pvbouwel <https://github.com/pvbouwel>
#
class beaver::stanzas (
  $stanzas = $::beaver::stanzas,
){

  if is_hash($stanzas) {
    create_resources('::beaver::stanza', $stanzas)
  }
}
