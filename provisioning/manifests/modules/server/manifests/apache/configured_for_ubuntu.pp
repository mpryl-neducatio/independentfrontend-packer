class server::apache::configured_for_ubuntu {
    $wwwdir = "/home/ubuntu/www"
    exec { "UsergroupChange" :
        path   => "/usr/bin:/usr/sbin:/bin",
        unless => "egrep -c '^export APACHE_RUN_[^_]+=ubuntu' /etc/apache2/envvars | grep -q 2", # two ubuntu entries present
        # command => "",
        # command => "ls -al /tmp/aaa > /tmp/p1 && chown ubuntu.ubuntu /tmp/aaa && ls -al /var/lock/apache2 > /tmp/aaa",
        command => "chown ubuntu.ubuntu /var/lock/apache2 && sed -i 's/^export APACHE_RUN_USER=.*$/export APACHE_RUN_USER=ubuntu/' /etc/apache2/envvars && sed -i 's/^export APACHE_RUN_GROUP=.*$/export APACHE_RUN_GROUP=ubuntu/' /etc/apache2/envvars",
        require => Package["apache2"],
        notify  => Service['apache2'],
    }
    file { $wwwdir:
      ensure => "directory",
      owner  => "ubuntu",
      group  => "ubuntu",
    }
    file { "/var/www":
        require  => [Package['apache2'], File[$wwwdir]],
        force => true,
        ensure   => "link",
        target => $wwwdir,
    }
}
