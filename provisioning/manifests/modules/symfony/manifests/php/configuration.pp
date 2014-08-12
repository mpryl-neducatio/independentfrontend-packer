class symfony::php::configuration {
  augeas { "set php apache configuration":
    notify => Service["apache2"],
    context => "/files/etc/php5/apache2/php.ini",
    changes => ["set Date/date.timezone 'Europe/Warsaw'", "set PHP/xdebug.max_nesting_level 250"],
    require => Package["apache2", "php5"],
  }
  augeas { "set php cli configuration":
    context => "/files/etc/php5/cli/php.ini",
    changes => ["set Date/date.timezone 'Europe/Warsaw'", "set PHP/xdebug.max_nesting_level 250"],
    require => Package["apache2", "php5"],
  }
}