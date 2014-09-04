class server::apache::configured_for_vagrant {
    $wwwdir = "/home/vagrant/www"
    exec { "UsergroupChange" :
        path   => "/usr/bin:/usr/sbin:/bin",
        unless => "egrep -c '^export APACHE_RUN_[^_]+=vagrant' /etc/apache2/envvars | grep -q 2", # two vagrant entries present
        # command => "",
        # command => "ls -al /tmp/aaa > /tmp/p1 && chown vagrant.vagrant /tmp/aaa && ls -al /var/lock/apache2 > /tmp/aaa",
        command => "chown vagrant.vagrant /var/lock/apache2 && sed -i 's/^export APACHE_RUN_USER=.*$/export APACHE_RUN_USER=vagrant/' /etc/apache2/envvars && sed -i 's/^export APACHE_RUN_GROUP=.*$/export APACHE_RUN_GROUP=vagrant/' /etc/apache2/envvars",
        require => Package["apache2"],
        notify  => Service['apache2'],
    }
    file { $wwwdir:
      ensure => "directory",
      owner  => "vagrant",
      group  => "vagrant",
    }
    file { "/var/www":
        require  => [Package['apache2'], File[$wwwdir]],
        force => true,
        ensure   => "link",
        target => $wwwdir,
    }
}
