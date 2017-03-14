# == Class: nodejs
#
# Full description of class nodejs here.
#
# === Parameters
# === Variables
# === Examples
# === Authors
#
# Author Deguer, Juan Carlos <juan.deguer@gmail.com>
#

class nodejs
(
  $version_nodejs                       = $::nodejs::params::version_nodejs,
  $version_npm                          = $::nodejs::params::version_npm,
  $version_gcc                          = $::nodejs::params::version_gcc,
  $version_make                         = $::nodejs::params::version_make,
  $version_oracle_instant_client_devel  = $::nodejs::params::version_oracle_instant_client_devel,
  $version_oracle_instant_client_basic  = $::nodejs::params::version_oracle_instant_client_basic,
  $dir_mod_nodejs                       = $::nodejs::params::dir_mod_nodejs,
  $dir_deploy_mod_nodejs                = $::nodejs::params::dir_deploy_mod_nodejs,
  $dir_deploy_test                      = $::nodejs::params::dir_deploy_test,
  $dir_logs_nodejs                      = $::nodejs::params::dir_logs_nodejs,
  $log_test_nodejs                      = $::nodejs::params::log_test_nodejs,
  $rsync_shell                          = $::nodejs::params::rsync_shell,
  $rsync_home                           = $::nodejs::params::rsync_home,
  $rsync_ssh_dir                        = $::nodejs::params::rsync_ssh_dir,
  $rsync_ssh_key                        = $::nodejs::params::rsync_ssh_key,
  $dir_deploy_test_app                  = $::nodejs::params::dir_deploy_test_app,
  $bash_profile                         = $::nodejs::params::bash_profile,
  $init_test_app                        = $::nodejs::params::init_test_app,
  $archivo_sudoers                      = $::nodejs::params::archivo_sudoers,
  $dir_mod_npm                          = $::nodejs::params::dir_mod_npm,
  $usuario_rsync                        = $::nodejs::params::usuario_rsync,
  $grupo_rsync                          = $::nodejs::params::grupo_rsync,
  $usuario_nodejs                       = $::nodejs::params::usuario_nodejs,
  $grupo_nodejs                         = $::nodejs::params::grupo_nodejs,
  $contacto                             = $::nodejs::params::contacto,
  $registro                             = $::nodejs::params::registro,
  $lista_modulos                        = $::nodejs::params::lista_modulos,
  $npmrc                                = $::nodejs::params::npmrc,
  $direccion_proxy                      = $::nodejs::params::direccion_proxy,
  $contacto                             = $::nodejs::params::contacto,
  $registro                             = $::nodejs::params::registro,
  $lista_modulos                        = $::nodejs::params::lista_modulos,
) inherits nodejs::params {

  include nodejs::install_nodejs
  include nodejs::install_oic
  include nodejs::group_add
  include nodejs::user_add
  include nodejs::config

  Class['nodejs::install_nodejs']
  -> Class['nodejs::install_oic']
  -> Exec ['crea_rsync_shell_file_vacio']
  -> Exec ['prefixs']
  -> Class['nodejs::group_add']
  -> Class['nodejs::user_add']
  -> Class['nodejs::config']

  exec { 'crea_rsync_shell_file_vacio':
        command => '/usr/bin/touch /usr/local/bin/rsync_shell.pl',
  }->
  exec { 'mod_rsync_shell_file':
        command => '/usr/bin/chmod +x /usr/local/bin/rsync_shell.pl',
  }
  exec { 'prefixs':
        command => '/usr/bin/npm config set prefix "/apps-node/.npm-global/" && /usr/bin/npm config set proxy="http://10.75.100.100:3128"',
  }
}
