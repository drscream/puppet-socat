# params is a hash of socat instances to run
#  {
#    'name1' => 'command line args',
#    'name2' => 'command line args',
#  }
class socat ( $params={} ) {
  package { 'socat':
    ensure => installed,
  }

  File{
    owner => 'root',
    group => 'root',
  }

  file { '/etc/init.d/socat':
    source => 'puppet:///modules/socat/socat',
    require => Package['socat'],
    notify  => Service['socat'],
    mode => "0750";
  }

  file { '/etc/default/socat':
    mode    => "664",
    content => template('socat/socat.erb'),
    notify  => Service['socat'],
  }

  service { 'socat':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => Package['socat'],
  }
}
