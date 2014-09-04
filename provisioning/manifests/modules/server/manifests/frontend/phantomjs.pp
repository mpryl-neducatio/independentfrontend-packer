class server::frontend::phantomjs {
  package { ['phantomjs']:
    ensure => 'installed'
  }
}