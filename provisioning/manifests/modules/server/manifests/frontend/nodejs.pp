class server::frontend::nodejs {
  package { ['nodejs', 'npm']:
    ensure => 'installed',
  }
  file { "/usr/bin/node":
    require  => Package['nodejs'],
    force => true,
    ensure   => "link",
    target => "/usr/bin/nodejs"
  }
  file { "/home/vagrant/tmp":
    force => true,
    ensure   => "directory",
    owner => "vagrant",
    group => "vagrant"
  }
}