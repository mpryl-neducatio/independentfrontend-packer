class server::frontend::nodejs {
  package { ['nodejs', 'npm']:
    ensure => 'installed'
  }
  file { "/usr/bin/node":
    require  => Package['nodejs'],
    force => true,
    ensure   => "link",
    target => "/usr/bin/nodejs"
  }
  file { "/home/ubuntu/tmp":
    force => true,
    ensure   => "directory",
    owner => "ubuntu",
    group => "ubuntu"
  }
  package { 'bower':
    ensure   => present,
    provider => 'npm',
    require   => Package["npm"],
  }
  package { 'grunt-cli':
    ensure   => present,
    provider => 'npm',
    require   => Package["npm"],
  }
}
