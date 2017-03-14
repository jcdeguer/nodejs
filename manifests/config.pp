class nodejs::config inherits nodejs::params {
  file { $rsync_shell:
        ensure => present,
        owner => 'root',
        group => 'root',
        mode => 0755,
        content => template ('nodejs/rsync_shell.pl.erb'),
  }
  file { $rsync_home:
        ensure  => directory,
        owner   => 'rsync',
        group   => 'rsync',
        mode => 0755,
  }
  file { $rsync_ssh_dir:
        ensure  => directory,
        owner   => 'rsync',
        group   => 'rsync',
        mode => 0700,
        recurse => true,
  }
  file { $rsync_ssh_key:
        ensure => present,
        owner => 'rsync',
        group => 'rsync',
        mode => 0700,
        content => template ('nodejs/authorized_keys.erb'),
  }
  file { $dir_mod_nodejs:
        ensure => directory,
        owner => 'node',
        group => 'rsync',
        mode => 0774,
  }
  file { $dir_deploy_mod_nodejs:
        ensure => directory,
        owner => 'rsync',
        group => 'node',
        mode => 0770,
  }
  file { $dir_deploy_test:
        ensure => directory,
        owner => 'rsync',
        group => 'node',
        mode => 0770,
  }
  file { $dir_deploy_test_app:
        ensure => present,
        owner => 'root',
        group => 'root',
        mode => 0644,
        content => template ('nodejs/app.js.erb'),
  }
  file { $dir_logs_nodejs:
        ensure  => directory,
        owner   => 'node',
        group   => 'rsync',
        mode => 0770,
  }
  file { $log_test_nodejs:
        ensure => present,
        owner => 'node',
        group => 'rsync',
        mode => 0770,
  }
  file { $init_test_app:
        ensure => present,
        owner => 'root',
        group => 'root',
        mode => 0755,
        content => template ('nodejs/ScritDeInicioNode-test.erb'),
  }
  file { $archivo_sudoers:
        ensure => present
  }
  file_line { 'rsync_sin_pass':
        line => 'rsync ALL=(ALL) NOPASSWD: ALL',
        path => $archivo_sudoers,
  }
  file { $bash_profile:
        ensure => present,
        owner => 'node',
        group => 'node',
        mode => 0700,
  }->
  file_line { 'removedor_paths_viejo':
        line => '#Borrado por seguridad',
        path => $bash_profile,
        match => "export PATH",
  }->
  file_line { 'paths':
        line => 'PATH=/apps-node/.npm-global/bin:/usr/local/bin:/usr/local/sbin:~/bin/usr/local/share/npm/bin:$PATH',
        path => $bash_profile,
  }->
  file_line { 'export_paths':
        line => 'export PATH',
        path => $bash_profile,
        match => "export PATH",
  }->
  file_line { 'node_paths':
        line => 'NODE_PATH=/apps-node/.npm-global/lib/node_modules/:$NODE_PATH',
        path => $bash_profile,
  }->
  file_line { 'export_node_paths':
        line => 'export NODE_PATH',
        path => $bash_profile,
  }

  # Configuracion de npm para instalacion de modulos de nodejs
  file { $npmrc:
        ensure => present,
        owner => 'node',
        group => 'rsync',
        mode => 0774,
  }->
  file_line { 'npmrc_proxy':
        line => ["proxy=${direccion_proxy}"],
        path => $npmrc,
  }->
  file_line { 'npmrc_prefix':
        line => ["prefix=${dir_mod_npm}"],
        path => $npmrc,
  }
  file { $dir_mod_npm:
        ensure  => directory,
        owner => 'node',
        group => 'rsync',
        mode => 0774,
        recurse => true,
  }

# Instalacion del modulo oracledb
  exec { 'seteo_prefixs_en_npm':
        command => '/usr/bin/npm config set prefix "/apps-node/.npm-global/"',
  }->
  exec { 'seteo_proxi_en_npm':
        command => '/usr/bin/npm config set proxy="http://IP_PROXY:PUERTO_PROXY"',
  }
  exec { 'install_oracldb_con_npm': # Este modulo valida si existe oracldb instalado, en caso contrario, lo instala.
        cwd => '/apps-node/',
        command => '/usr/bin/npm install -g oracledb --prefix /apps-node/.npm-global/ -ve',
        user => 'node',
        creates => '/apps-node/.npm-global/lib/node_modules/oracledb',
  }
}
