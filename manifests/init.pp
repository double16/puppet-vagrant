# Public: Installs Vagrant
#
# Usage:
#
#   include vagrant

class vagrant(
  $version = 'latest',
  $completion = false
) {
  validate_bool($completion)

  $ensure_pkg = $completion ? {
    true    => 'present',
    default => 'absent',
  }

  package { 'vagrant':
    ensure   => $version,
    provider => 'brewcask',
  }

  file { "/Users/${::boxen_user}/.vagrant.d":
    ensure  => directory,
    require => Package['vagrant'],
  }

  package { 'vagrant-completion':
    ensure   => $ensure_pkg,
    provider => 'homebrew',
  }
}
