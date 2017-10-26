class nodejs::config {

# Parametros generales
  $direccion_proxy      = $::nodejs::direccion_proxy
  $admin_contact_name   = $::nodejs::admin_contact_name
  $admin_contact_email  = $::nodejs::admin_contact_email
  $registry_address     = $::nodejs::registry_address

# Configuraciones para el usuario rsync
  $rsync_group_name     = $::nodejs::rsync_group_name
  $rsync_user_name      = $::nodejs::rsync_user_name
  $rsync_user_home      = $::nodejs::rsync_user_home
  $rsync_ssh_dir        = $::nodejs::rsync_ssh_dir
  $rsync_ssh_key        = $::nodejs::rsync_ssh_key
  $rsync_ssh_key_file   = $::nodejs::rsync_ssh_key_file

# Configuraciones para el usuario node
  $nodejs_group_name            = $::nodejs::nodejs_group_name
  $nodejs_user_name             = $::nodejs::nodejs_user_name
  $nodejs_user_home             = $::nodejs::nodejs_user_home

# Configuracion del bashrc para el usuario node
  $nodejs_user_bashrc_file_name         = $::nodejs::nodejs_user_bashrc_file_name
  $nodejs_user_bashrc_content           = $::nodejs::nodejs_user_bashrc_content
  $nodejs_modules_deploy_directory      = $::nodejs::nodejs_modules_deploy_directory
  $nodejs_modules_logs_directory        = $::nodejs::nodejs_modules_logs_directory

# Configuracion del bash profile para el usuario node
  $bash_profile_file_name       = $::nodejs::bash_profile_file_name
  $bash_profile_source          = $::nodejs::bash_profile_source
  $path_line_name               = $::nodejs::path_line_name
  $path_line                    = $::nodejs::path_line
  $path_line_export_name        = $::nodejs::path_line_export_name
  $path_line_export             = $::nodejs::path_line_export
  $node_path_line               = $::nodejs::node_path_line
  $node_path_line_name          = $::nodejs::node_path_line_name
  $node_path_line_export        = $::nodejs::node_path_line_export
  $node_path_line_export_name   = $::nodejs::node_path_line_export_name

# Configuracion del archivo sudoers para rsync
  $sudoers_file_name            = $::nodejs::sudoers_file_name
  $sudoers_file_line_name       = $::nodejs::sudoers_file_line_name
  $sudoers_file_line_content    = $::nodejs::sudoers_file_line_content

# Configuracion para el rc de npm.
  $npmrc_file_name              = $::nodejs::npmrc_file_name
  $npmrc_prefix_line_name       = $::nodejs::npmrc_prefix_line_name
  $npmrc_proxy_line_name        = $::nodejs::npmrc_proxy_line_name

# Parametros para configurar prueba de despliegue, (esta app de prueba verifica la conexion con la base).
  $deploy_test_directory                = $::nodejs::deploy_test_directory
  $deploy_test_app                      = $::nodejs::deploy_test_app
  $deploy_test_app_source               = $::nodejs::deploy_test_app_source
  $deploy_test_app_init_file_name       = $::nodejs::deploy_test_app_init_file_name
  $deploy_test_app_init_file_source     = $::nodejs::deploy_test_app_init_file_source
  $deploy_test_log_file_name            = $::nodejs::deploy_test_log_file_name

# Parametros para la instalacion de modulos de nodejs usando npm
  $recargar_modulos_enable      = $::nodejs::recargar_modulos_enable
  $lista_modulos                = $::nodejs::lista_modulos
  $npmrc_root_file_name         = $::nodejs::npmrc_root_file_name
  $npm_modules_directory        = $::nodejs::npm_modules_directory

# Bloque de configuraciones
# Configuracion para el usuario Rsync
  file { $rsync_user_home:
    ensure => directory,
    owner => $rsync_user_name,
    group => $rsync_group_name,
    mode => 0755,
  }
  file { $rsync_ssh_dir:
    ensure => directory,
    owner => $rsync_user_name,
    group => $rsync_group_name,
    mode => 0700,
    recurse => true,
  }
  file { $rsync_ssh_key:
    ensure => present,
    owner => $rsync_user_name,
    group => $rsync_group_name,
    mode => 0700,
    source => $rsync_ssh_key_file,
  }

# Configuracion del bash profile para el usuario node
  file { $bash_profile_file_name:
    ensure => present,
    owner => $nodejs_user_name,
    group => $nodejs_group_name,
    mode => 0700,
    source => $bash_profile_source,
  }->
  file_line { $path_line_name:
    line => $path_line,
    path => $bash_profile_file_name,
  }->
  file_line { $path_line_export_name:
    line => $path_line_export,
    path => $bash_profile_file_name,
  }->
  file_line { $node_path_line_name:
    line => $node_path_line,
    path => $bash_profile_file_name,
  }->
  file_line { $node_path_line_export_name:
    line => $node_path_line_export,
    path => $bash_profile_file_name,
  }

# Configuracion para el usuario node
  file { $nodejs_user_bashrc_file_name:
    ensure => present,
    owner => $nodejs_user_name,
    group => $nodejs_group_name,
    mode => 0700,
    source => $nodejs_user_bashrc_content,
  }
  file { $nodejs_user_home:
    ensure => directory,
    owner => $nodejs_user_name,
    group => $rsync_group_name,
    mode => 0774,
  }
  file { $nodejs_modules_deploy_directory:
    ensure => directory,
    owner => $rsync_user_name,
    group => $nodejs_group_name,
    mode => 0770,
  }
  file { $nodejs_modules_logs_directory:
    ensure => directory,
    owner => $nodejs_user_name,
    group => $rsync_group_name,
    mode => 0770,
  }

# Configuracion de permisos en sudo para rsync
  file { $sudoers_file_name:
    ensure => present
  }->
  file_line { $sudoers_file_line_name:
    line => $sudoers_file_line_content,
    path => $sudoers_file_name,
  }

# Configuracion de npm para instalacion de modulos de nodejs
  file { $npm_modules_directory:
    ensure  => directory,
    owner => $nodejs_user_name,
    group => $rsync_group_name,
    mode => 0774,
    recurse => true,
  }
  file { $npmrc_file_name:
    ensure => present,
    owner => $nodejs_user_name,
    group => $rsync_group_name,
    mode => 0774,
  }->
  file_line { $npmrc_proxy_line_name:
    line => ["proxy=${direccion_proxy}"],
    path => $npmrc_file_name,
  }->
  file_line { $npmrc_prefix_line_name:
    line => ["prefix=${npm_modules_directory}"],
    path => $npmrc_file_name,
  }

# Configuracion para prueba de despliegue, esta app de prueba verifica la conexion con la base
  file { $deploy_test_directory:
    ensure => directory,
    owner => $rsync_user_name,
    group => $nodejs_group_name,
    mode => 0770,
    recurse => true,
  }
  file { $deploy_test_app:
    ensure => present,
    owner => "root",
    group => "root",
    mode => 0644,
    source => $deploy_test_app_source,
  }
  file { $deploy_test_log_file_name:
    ensure => present,
    owner => $nodejs_user_name,
    group => $rsync_group_name,
    mode => 0770,
  }
  file { $deploy_test_app_init_file_name:
    ensure => present,
    owner => "root",
    group => "root",
    mode => 0755,
    source => $deploy_test_app_init_file_source,
  }

# Instalacion del modulo oracledb
  if $recargar_modulos_enable == true {
    file { $npmrc_root_file_name:
      ensure => present,
      mode => 0600,
    }->
    file_line { "seteo_prefixs":
      line => "prefix=${npm_modules_directory}",
      path => $npmrc_root_file_name,
    }->
    file_line { "seteo_proxy":
      line => "proxy=\"${direccion_proxy}\"",
      path => $npmrc_root_file_name,
    }
    if $lista_modulos {
      exec { "instalando_modulos": # Este bloque valida si existe algun modulo adicional al oracldb a instalar
        cwd => $nodejs_user_home,
        command => "/usr/bin/npm install -g ${lista_modulos} --prefix ${npm_modules_directory} -ve",
        user => $nodejs_user_name,
      }
    }
    else {
      exec { "instalando_modulo_oracledb": # Este modulo valida si existe oracldb instalado, en caso contrario, lo instala.
        cwd => $nodejs_user_home,
        command => "/usr/bin/npm install -g oracledb --prefix ${npm_modules_directory} -ve",
        user => 'node',
        #creates => '/apps-node/.npm-global/lib/node_modules/oracledb',
        creates => "${npm_modules_directory}/lib/node_modules/oracledb",
      }
    }
  }
}
