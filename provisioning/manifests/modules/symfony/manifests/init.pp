class symfony {
#  include common::db::mysql
#  include common::db::postgresql

  include php::php

  include misc::misc

  package { "openjdk-7-jdk": }
  package { "ant":
    require => Package["openjdk-7-jdk"],
  }
}
