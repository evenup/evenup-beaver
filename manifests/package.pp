# == Class: beaver::package
#
# This class installs the beaver package and init scripts.
# It should not be directly called
#
#
# === Parameters
#   None
#
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
class beaver::package (
  $venv             = $::beaver::venv,
  $package_name     = $::beaver::package_name,
  $provider         = $::beaver::package_provider,
  $python_version   = $::beaver::python_version,
  $version          = $::beaver::version,
  $user             = $::beaver::user,
  $group            = $::beaver::group,
  $home             = $::beaver::home,
  $service_provider = $::beaver::service_provider,
) {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  # Setup some variables for the virtualenv
  $venv_environment = [
    "PATH=${venv}/bin:\$PATH",
    "VIRTUAL_ENV=${venv}",
  ]

  if $provider == 'virtualenv' {
    python::virtualenv { $venv:
      ensure  => present,
      version => $python_version,
      owner   => $user,
      group   => $group,
      require => Class['python'],
    }

    python::pip { $package_name:
      ensure       => $version,
      pkgname      => $package_name,
      virtualenv   => $venv,
      install_args => "--cache-dir ${venv}/.pip-cache",
      owner        => 'root',
      require      => User[$user],
      notify       => Class['beaver::service'],
    }

    user { $user:
      ensure     => present,
      home       => $home,
      managehome => true,
      system     => true,
    }
  } else {
    package { $package_name:
      ensure   => $version,
      provider => $provider,
      notify   => Class['beaver::service'],
    }
  }

  if $service_provider == 'init' {
    file { '/etc/init.d/beaver':
      ensure  => file,
      mode    => '0555',
      owner   => 'root',
      group   => 'root',
      content => template('beaver/beaver.init.erb'),
    }
  } else {
    include ::systemd
    
    exec { 'switch-init-to-systemd':
      path    => '/bin:/sbin:/usr/bin:/usr/sbin',
      onlyif  => 'test -e /var/run/beaver.pid',
      command => '/etc/init.d/beaver stop || kill $(cat /var/run/beaver.pid) && rm -f /var/run/beaver.pid',
    }->
    file { '/etc/init.d/beaver':
      ensure => absent,
    }->
    file { '/lib/systemd/system/beaver.service':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      content => template('beaver/beaver.service.erb'),
    } ~>
    Exec['systemctl-daemon-reload']
  }

  file { '/etc/beaver':
    ensure => 'directory',
    mode   => '0555',
    owner  => 'root',
    group  => 'root',
  }

  file { '/etc/beaver/conf.d':
    ensure  => 'directory',
    mode    => '0555',
    owner   => 'root',
    group   => 'root',
    purge   => true,
    force   => true,
    recurse => true,
    notify  => Class['beaver::service'],
  }

}
