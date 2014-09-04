class server::misc::administration {
  package { "ruby":
    ensure => installed,
  }
  package { 'ruby-bundler':
    require   => Package["ruby"],
    ensure => present,
  }
  package { 'install augeas-tools':
    ensure => present,
    name => 'augeas-tools',
  }
  package { 'puppet-module':
    ensure   => 'installed',
    provider => 'gem',
    require   => Package["ruby"],
  }
  package { 'openssh-server':
    ensure => present,
  }
  package { 'lsyncd':
    ensure => present,
  }
}