class symfony::misc::misc {

  $mountpoint = "/home/ubuntu/tmpfscache"
  file { $mountpoint:
    ensure => "directory",
  }
  mount { "cache_ramdisk":
    require => File[$mountpoint],
    name => $mountpoint,
    atboot => true,
    device => "none",
    ensure => "mounted",
    fstype => "tmpfs",
    options => "size=128m,nodev,nosuid,noexec,mode=1777",
    remounts => true,
  }
}
