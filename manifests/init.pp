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
# Parametros generales
  $direccion_proxy      = $::nodejs::params::direccion_proxy,
  $admin_contact_name   = $::nodejs::params::admin_contact_name,
  $admin_contact_email  = $::nodejs::params::admin_contact_email,
  $registry_address     = $::nodejs::params::registry_address,

# Parametros usados para repositorios
  $repo_oic_file_name   = $::nodejs::params::repo_oic_file_name,
  $repo_oic_status      = $::nodejs::params::repo_oic_status,
  $repo_oic_baseurl     = $::nodejs::params::repo_oic_baseurl,

# Parametros usados para definir los paquetes
  $package_nodejs       = $::nodejs::params::package_nodejs,
  $package_npm          = $::nodejs::params::package_npm,
  $package_gcc          = $::nodejs::params::package_gcc,
  $package_make         = $::nodejs::params::package_make,
  $package_oic_version  = $::nodejs::params::package_oic_version,

# Parametros preconfiguraciones para evitar errores en modulos user y config
  $npm_presets_config_command   = $::nodejs::params::npm_presets_config_command,
  $npm_presets_name             = $::nodejs::params::npm_presets_name,
  $npm_command_ensure           = $::nodejs::params::npm_command_ensure,

# Parametros usados por rsync
  $rsync_user_home              = $::nodejs::params::rsync_user_home,
  $rsync_ssh_dir                = $::nodejs::params::rsync_ssh_dir,
  $rsync_ssh_key                = $::nodejs::params::rsync_ssh_key,
  $rsync_ssh_key_file           = $::nodejs::params::rsync_ssh_key_file,
  $rsync_group_name             = $::nodejs::params::rsync_group_name,
  $rsync_user_name              = $::nodejs::params::rsync_user_name,
  $rsync_user_comment           = $::nodejs::params::rsync_user_comment,
  $rsync_user_uid               = $::nodejs::params::rsync_user_uid,
  $rsync_shell_file             = $::nodejs::params::rsync_shell_file,
  $rsync_shell_file_source      = $::nodejs::params::rsync_shell_file_source,

# Parametros usados por node
  $nodejs_group_name    = $::nodejs::params::nodejs_group_name,
  $nodejs_user_name     = $::nodejs::params::nodejs_user_name,
  $nodejs_user_comment  = $::nodejs::params::nodejs_user_comment,
  $nodejs_user_uid      = $::nodejs::params::nodejs_user_uid,
  $nodejs_user_home     = $::nodejs::params::nodejs_user_home,

# Configuracion del bashrc para el usuario node
  $nodejs_user_bashrc_file_name         = $::nodejs::params::nodejs_user_bashrc_file_name,
  $nodejs_user_bashrc_content           = $::nodejs::params::nodejs_user_bashrc_content,
  $nodejs_modules_deploy_directory      = $::nodejs::params::nodejs_modules_deploy_directory,
  $nodejs_modules_logs_directory        = $::nodejs::params::nodejs_modules_logs_directory,

# Configuracion del bash profile para el usuario node
  $bash_profile_source          = $::nodejs::params::bash_profile_source,
  $bash_profile_file_name       = $::nodejs::params::bash_profile_file_name,
  $path_line                    = $::nodejs::params::path_line,
  $path_line_name               = $::nodejs::params::path_line_name,
  $path_line_export             = $::nodejs::params::path_line_export,
  $path_line_export_name        = $::nodejs::params::path_line_export_name,
  $node_path_line               = $::nodejs::params::node_path_line,
  $node_path_line_name          = $::nodejs::params::node_path_line_name,
  $node_path_line_export        = $::nodejs::params::node_path_line_export,
  $node_path_line_export_name   = $::nodejs::params::node_path_line_export_name,

# Configuracion del archivo sudoers para rsync
  $sudoers_file_name            = $::nodejs::params::sudoers_file_name,
  $sudoers_file_line_name       = $::nodejs::params::sudoers_file_line_name,
  $sudoers_file_line_content    = $::nodejs::params::sudoers_file_line_content,

# Configuracion para el rc de npm
  $npmrc_file_name              = $::nodejs::params::npmrc_file_name,
  $npmrc_prefix_line_name       = $::nodejs::params::npmrc_prefix_line_name,
  $npmrc_proxy_line_name        = $::nodejs::params::npmrc_proxy_line_name,
  $npm_modules_directory        = $::nodejs::params::npm_modules_directory,

# Parametros para configurar prueba de despliegue, (esta app de prueba verifica la conexion con la base).
  $deploy_test_directory                = $::nodejs::params::deploy_test_directory,
  $deploy_test_app                      = $::nodejs::params::deploy_test_app,
  $deploy_test_app_source               = $::nodejs::params::deploy_test_app_source,
  $deploy_test_app_init_file            = $::nodejs::params::deploy_test_app_init_file,
  $deploy_test_app_init_file_source     = $::nodejs::params::deploy_test_app_init_file_source,
  $deploy_test_log_file_name            = $::nodejs::params::deploy_test_log_file_name,

# Parametros para la instalacion de modulos de nodejs usando npm
  $recargar_modulos_enable      = $::nodejs::params::recargar_modulos_enable,
  $lista_modulos                = $::nodejs::params::lista_modulos,
  $npmrc_root_file_name         = $::nodejs::params::npmrc_root_file_name,
  $npm_modules_directory        = $::nodejs::params::npm_modules_directory,

) inherits nodejs::params {

  if $::operatingsystemmajrelease == '7' {

    include nodejs::repos
    include nodejs::install
    include nodejs::params

    if $recargar_modulos_enable == true {
      include nodejs::pre_config
      include nodejs::group
      include nodejs::users
      include nodejs::config

      Class['nodejs::repos']
      -> Class['nodejs::install']
      -> Class['nodejs::pre_config']
      -> Class['nodejs::group']
      -> Class['nodejs::users']
      -> Class['nodejs::config']

    }
  }
}
