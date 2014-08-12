class server::apache::configured {
  define apache::loadmodule () {
    exec { "/usr/sbin/a2enmod $name" :
      unless => "/bin/readlink -e /etc/apache2/mods-enabled/${name}.load",
      notify => Service[apache2],
      require => Package["apache2"]
    }
  }
  exec { "set ServerName in apache":
    path   => "/usr/bin:/usr/sbin:/bin",
    notify  => Service["apache2"],  # this sets up the relationship
    unless => "grep -q '^[ ]*ServerName ' /etc/apache2/httpd.conf",
    command => "echo 'ServerName localhost' >> /etc/apache2/httpd.conf",
    require => Package["apache2"]
  }
  augeas { "set apache configuration for 000-default":
    notify  => Service["apache2"],  # this sets up the relationship
    context => "/files/etc/apache2/sites-available/000-default.conf",
    changes => [
      "set VirtualHost/directive[self::directive='ServerAdmin']/arg foo@localhost",
      "set VirtualHost/directive[self::directive='DocumentRoot']/arg /var/www",
      "rm VirtualHost/*[self::directive='Options']",
      "set VirtualHost/directive[0] Options",
      "set VirtualHost/*[self::directive='Options']/arg[0] '-Indexes'",
      "set VirtualHost/*[self::directive='Options']/arg[0] '+FollowSymLinks'",
      "rm VirtualHost/*[self::directive='ServerName']",
      "set VirtualHost/directive[0] ServerName",
      "set VirtualHost/*[self::directive='ServerName']/arg[0] 'localhost'"
    ],
    require => Package["apache2"]
  }
  augeas { "set apache general configuration":
  notify  => Service["apache2"],  # this sets up the relationship
  context => "/files/etc/apache2/apache2.conf/Directory[arg='/var/www/']",
  changes => [
    "rm directive[self::directive='Options']/arg",
    "set directive[self::directive='Options']/arg[1] '-Indexes'",
    "set directive[self::directive='Options']/arg[2] '+FollowSymLinks'",
    "set directive[self::directive='AllowOverride']/arg 'All'"
  ],
  require => Package["apache2"]
  }
  # enable mod rewrite for apache if not enabled
  apache::loadmodule { "rewrite": }
  group {'www-data':
          ensure => present,
  }
}