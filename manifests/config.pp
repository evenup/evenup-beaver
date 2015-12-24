# == Class: beaver::config
#
# This class is responsible for configuring beaver
# It should not be directly called
#
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
class beaver::config (
  $multiline_regex_before = $::beaver::multiline_regex_before,
  $multline_regex_after   = $::beaver::multiline_regex_after,
){

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  file { '/etc/beaver/beaver.conf':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => template('beaver/beaver.conf.erb'),
    notify  => Class['beaver::service'],
  }

  file { '/etc/beaver.conf':
    ensure => absent,
  }

}
