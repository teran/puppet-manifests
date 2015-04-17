# Class: fuel_project::apps::mirror
#
class fuel_project::apps::mirror (
  $dir = '/var/www/mirror',
  $dir_owner = 'www-data',
  $dir_group = 'www-data',
  $rsync_writable_share = true,
  $lock_file = '/var/run/rsync_mirror_sync.lock',
  $firewall_allow_sources = {},
  $port = 80,
  $service_fqdn = "mirror.${::fqdn}",
  $service_aliases = [],
  $sync_hosts_allow = [],
  $nginx_access_log = '/var/log/nginx/access.log',
  $nginx_error_log = '/var/log/nginx/error.log',
  $nginx_log_format = 'proxy',
) {
  if(!defined(Class['rsync'])) {
    class { 'rsync' :
      package_ensure => 'present',
    }
  }

  ensure_resource('user', $dir_owner, {
    ensure     => 'present',
  })

  ensure_resource('group', $dir_group, {
    ensure     => 'present',
  })

  file { $dir :
    ensure  => 'directory',
    owner   => $dir_owner,
    group   => $dir_group,
    mode    => '0755',
    require => [
        Class['nginx'],
        User[$dir_owner],
        Group[$dir_group],
      ],
  }

  if (!defined(Class['::rsync::server'])) {
    class { '::rsync::server' :
      gid        => 'root',
      uid        => 'root',
      use_chroot => 'yes',
      use_xinetd => false,
    }
  }

  ::rsync::server::module{ 'mirror':
    comment         => 'Fuel mirror rsync share',
    uid             => 'nobody',
    gid             => 'nogroup',
    list            => 'yes',
    lock_file       => '/var/run/rsync_mirror.lock',
    max_connections => 100,
    path            => $dir,
    read_only       => 'yes',
    write_only      => 'no',
    require         => File[$dir],
  }

  if ($rsync_writable_share) {
    ::rsync::server::module{ 'mirror-sync':
      comment         => 'Fuel mirror sync',
      uid             => $dir_owner,
      gid             => $dir_group,
      hosts_allow     => $sync_hosts_allow,
      hosts_deny      => ['*'],
      incoming_chmod  => '0755',
      outgoing_chmod  => '0644',
      list            => 'yes',
      lock_file       => $lock_file,
      max_connections => 100,
      path            => $dir,
      read_only       => 'no',
      write_only      => 'no',
      require         => [
          File[$dir],
          User[$dir_owner],
          Group[$dir_group],
        ],
    }
  }

  if (!defined(Class['::fuel_project::nginx'])) {
    class { '::fuel_project::nginx' :}
  }
  ::nginx::resource::vhost { 'mirror' :
    ensure              => 'present',
    www_root            => '/var/www/mirror',
    access_log          => $nginx_access_log,
    error_log           => $nginx_error_log,
    format_log          => $nginx_log_format,
    server_name         => [
      $service_fqdn,
      "mirror.${::fqdn}",
      join($service_aliases, ' ')
    ],
    location_cfg_append => {
        autoindex => 'on',
    },
  }
}