class symfony::php::packages {
package { "php5" :
  ensure => installed,
}
package { "libapache2-mod-php5" :
  ensure => installed,
  require => Package["php5"],
  notify => Service["apache2"],
}
package { "php5-intl" :
  ensure => installed,
  require => Package["php5"],
  notify => Service["apache2"],
}
package { "php5-cli" :
  ensure => installed,
  require => Package["php5"],
  notify => Service["apache2"],
}
package { "php-pear" :
  ensure => installed,
  require => Package["php5"],
  notify => Service["apache2"],
}
package { "php5-gd" :
  ensure => installed,
  require => Package["php5"],
  notify => Service["apache2"],
}
package { "php5-xsl" :
  ensure => installed,
  require => Package["php5"],
  notify => Service["apache2"],
}
package { "php5-sqlite" :
  ensure => installed,
  require => Package["php5"],
  notify => Service["apache2"],
}
package { "php5-xdebug" :
  ensure => installed,
  require => Package["php5"],
  notify => Service["apache2"],
}
package { "php5-pgsql" :
  ensure => installed,
  require => Package["php5", "postgresql"],
  notify => Service["apache2"],
}
package { "php5-mysql" :
  ensure => installed,
  require => Package["php5", "mysql-server"],
  notify => Service["apache2"],
}
package { "php-apc" :
  ensure => installed,
  require => Package["php5"],
  notify => Service["apache2"],
}
package { "php5-curl" :
  ensure => installed,
  require => Package["php5"],
}
}