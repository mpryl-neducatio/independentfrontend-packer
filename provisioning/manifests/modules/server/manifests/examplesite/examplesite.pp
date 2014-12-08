class server::examplesite::examplesite {
  file { "/home/ubuntu/www/frontendworkflow":
          force => true,
          ensure   => "link",
          target => "/ubuntu/example_staticpage/web",
  }
}
