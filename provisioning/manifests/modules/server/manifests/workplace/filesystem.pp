class server::workplace::filesystem {
  package { 'install acl package':
    ensure => present,
    name => 'acl',
  }
  exec { 'add acl to filesystem':
    path   => '/usr/bin:/usr/sbin:/bin',
    command => 'cp /etc/fstab /etc/fstab.bak && awk \'$2~"^/(ci)*$" && $4 !~ "(^|,)acl(,|$)" {$4="acl,"$4}1\' OFS="\t" /etc/fstab > /tmp/fstab && cat /tmp/fstab > /etc/fstab && rm /tmp/fstab && mount -a',
    unless => "grep -q '\\Wacl\\W' /etc/fstab",
  }
}