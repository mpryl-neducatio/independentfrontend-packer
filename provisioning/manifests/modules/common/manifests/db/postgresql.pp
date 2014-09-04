class common::db::postgresql {

  package { "iptables-persistent": }

  service { "iptables-persistent":
    ensure => running,
    require => Package["iptables-persistent"],
  }

  package { "postgresql" :
    ensure => installed,
    require => Service["iptables-persistent"],
  }

  class { 'postgresql::server':
    ip_mask_deny_postgres_user => '0.0.0.0/32',
    ip_mask_allow_all_users => '0.0.0.0/0',
    listen_addresses => 'localhost',
    manage_firewall => true,
    postgres_password => 'rwoeiru04u0w4t',
  }


  postgresql::server::pg_hba_rule { 'allow application network to access app database':
    description => "Open up postgresql for access from 200.1.2.0/24",
    type => 'local',
    database => 'all',
    user => 'vagrant',
    address => undef,
    auth_method => 'password',
    order       => '001',
  }

  postgresql::server::role { 'vagrant':
    password_hash => postgresql_password('vagrant', 'vagrant'),
    createdb	=> true
  }

  postgresql::server::db { 'vagrant':
    user => 'vagrant',
    password => 'vagrant',
  }
}