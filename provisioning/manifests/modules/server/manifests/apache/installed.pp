class server::apache::installed {
  package { 'apache2':
    ensure => present,
    name => 'apache2',
  }
  service { "apache2":
      ensure  => "running",
      enable  => "true",
      require => Package["apache2"]
  }
}