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
  $venv           = $beaver::venv,
  $package_name   = $beaver::package_name,
  $provider       = $beaver::package_provider,
  $python_version = $beaver::python_version,
  $version        = $beaver::version,
  $user           = $beaver::user,
  $group          = $beaver::group,
  $home           = $beaver::home,
) {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  # Setup some variables for the virtualenv
  $venv_environment = [
    "PATH=${venv}/bin:\$PATH",
    "VIRTUAL_ENV=${venv}",
  ]

  if $provider == 'pip' {
    class { 'python':
      pip             => true,
      manage_gunicorn => false
    }
  }

  if $provider == 'virtualenv' {
    # Installs python pip/virtualenv.
    class { 'python':
      pip             => true,
      virtualenv      => true,
      manage_gunicorn => false
    }

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
      install_args => "--download-cache ${venv}/.pip-cache",
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
      require  => Class['python'],
      notify   => Class['beaver::service'],
    }
  }

  file { '/lib/systemd/system/beaver.service':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    content => template('beaver/beaver.service.erb'),
  }

  file { '/etc/init.d/beaver':
    ensure  => file,
    mode    => '0555',
    owner   => 'root',
    group   => 'root',
    content => template('beaver/beaver.init.erb'),
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
