class server::workplace::workflow {
  package { 'mc':
    ensure => present,
  }
  package { 'git':
      ensure => present,
  }
  package { 'p7zip-full':
      ensure => present,
  }
  package { 'mysql-client':
      ensure => present,
  }
}
