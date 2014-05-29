class ssh::ldap {
  include ssh::params

  include ssh::sshd

  $ldap_packages = $ssh::params::ldap_packages

  package { $ldap_packages :
    ensure => 'present',
  }

  file { '/etc/ldap.conf':
    path => '/etc/ldap.conf',
    ensure => 'present',
    mode => '0600',
    owner => 'root',
    group => 'root',
    content => template('ssh/ldap.conf.erb'),
  }

  file { '/etc/ldap/ldap.conf' :
    ensure => 'link',
    target => '/etc/ldap.conf',
  }

  file { '/etc/nsswitch.conf':
    path => '/etc/nsswitch.conf',
    ensure => 'present',
    mode => '0644',
    owner => 'root',
    group => 'root',
    content => template('ssh/nsswitch.conf.erb'),
  }

  file { '/etc/pam.d/common-session' :
    path => '/etc/pam.d/common-session',
    ensure => 'present',
    mode => '0644',
    owner => 'root',
    group => 'root',
    content => template('ssh/common-session.erb'),
  }

  file { '/usr/local/bin/ldap2sshkeys.sh' :
    path => '/usr/local/bin/ldap2sshkeys.sh',
    ensure => 'present',
    mode => '0700',
    owner => 'root',
    group => 'root',
    content => template('ssh/ldap2sshkeys.sh.erb'),
  }

  exec { 'sync-ssh-keys' :
    command => '/usr/local/bin/ldap2sshkeys.sh',
    logoutput => on_failure,
  }

  service { 'nscd' :
    ensure => running,
    enable => true,
    hasstatus => true,
    hasrestart => false,
  }

  cron { 'ldap2sshkeys' :
    command => '/usr/local/bin/ldap2sshkeys.sh',
    user => root,
    hour => '*',
    minute => 0,
  }

  Class['ssh::sshd']->
    Package[$ldap_packages]->
    File['/etc/ldap.conf']->
    File['/etc/nsswitch.conf']->
    File['/etc/pam.d/common-session']->
    File['/usr/local/bin/ldap2sshkeys.sh']->
    Service['nscd']->
    Cron['ldap2sshkeys']

  Class['ssh::sshd']->
    File['/etc/ldap.conf']->
    File['/usr/local/bin/ldap2sshkeys.sh']~>
    Service['nscd']->
    Cron['ldap2sshkeys']

  Class['ssh::sshd']->
    File['/etc/pam.d/common-session']->
    File['/usr/local/bin/ldap2sshkeys.sh']~>
    Service['nscd']->
    Cron['ldap2sshkeys']

  Class['ssh::sshd']->
    File['/usr/local/bin/ldap2sshkeys.sh']~>
    Service['nscd']->
    Cron['ldap2sshkeys']
}