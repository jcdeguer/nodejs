# Class: nodejs::params
#
class nodejs::params {

# Parametros generales
  $direccion_proxy              = "http://PROXY_URL:PROXY_PORT"
  $admin_contact_name           = "Administrador"
  $admin_contact_email          = "admin@mail.net"
  $registry_address             = 'registry = "https://registry.npmjs.org/"'

# Parametros usados para repositorios
  $repo_oic_file_name   = 'oracle_instant_client'
  $repo_oic_status      = 1
  $repo_oic_baseurl     = 'http://url_repositorio_oracle_instant_client'

# Parametros usados para definir los paquetes
  $package_nodejs       = 'nodejs.x86_64'
  $package_npm          = 'npm.x86_64'
  $package_gcc          = [ 'gcc.x86_64', 'gcc-objc.x86_64', 'gcc-c++.x86_64', 'gcc-objc++.x86_64' ]
  $package_make         = 'make.x86_64'
  $package_oic_version  = '12.1'

# Parametros usados por rsync
  $rsync_user_home              = '/home/rsync'
  $rsync_ssh_dir                = '/home/rsync/.ssh'
  $rsync_ssh_key                = '/home/rsync/.ssh/authorized_keys'
  $rsync_ssh_key_file           = 'puppet:///modules/nodejs/authorized_keys'
  $rsync_user_name              = 'rsync'
  $rsync_user_comment           = 'Usuario rsync para ser usado por Jenkins'
  $rsync_user_uid               = 10000
  $rsync_group_name             = 'rsync'
  $rsync_shell_file             = '/usr/local/bin/rsync_shell.pl'
  $rsync_shell_file_source      = 'puppet:///modules/nodejs/rsync_shell.pl'

# Parametros usados por nodejs
  $nodejs_user_name             = 'node'
  $nodejs_group_name            = 'node'
  $nodejs_user_comment          = 'Usuario node para ser usado por NodeJS'
  $nodejs_user_home             = '/apps-node'

# Configuracion del bashrc para el usuario node
  $nodejs_user_bashrc_file_name         = "/apps-node/.bashrc"
  $nodejs_user_bashrc_content           = "puppet:///modules/nodejs/bashrc"
  $nodejs_modules_deploy_directory      = "/apps-node/deploys"
  $nodejs_modules_logs_directory        = "/apps-node/logs"

# Configuracion de bashrc para el usuario node
  $bash_profile_file_name       = "/apps-node/.bash_profile"
  $bash_profile_source          = "puppet:///modules/nodejs/bash_profile"
  $path_line                    = 'PATH=/apps-node/.npm-global/bin:/usr/local/bin:/usr/local/sbin:~/bin/usr/local/share/npm/bin:$PATH'
  $path_line_name               = 'paths'
  $path_line_export             = 'export PATH'
  $path_line_export_name        = 'export_paths'
  $node_path_line               = 'NODE_PATH=/apps-node/.npm-global/lib/node_modules:$NODE_PATH'
  $node_path_line_name          = 'node_paths'
  $node_path_line_export        = 'export NODE_PATH'
  $node_path_line_export_name   = 'export_node_paths'

# Configuracion del archivo sudoers para rsync
  $sudoers_file_name            = "/etc/sudoers"
  $sudoers_file_line_name       = "rsync_sin_pass"
  $sudoers_file_line_content    = "rsync ALL=(ALL) NOPASSWD: ALL"

# Configuracion para el rc de npm
  $npmrc_file_name              = "/apps-node/.npmrc"
  $npmrc_prefix_line_name       = "npmrc_prefix_line"
  $npmrc_proxy_line_name        = "npmrc_proxy_line"

# Parametros para configurar prueba de despliegue, (esta app de prueba verifica la conexion con la base).
  $deploy_test_directory                = "/apps-node/deploys/node-test"
  $deploy_test_app                      = "/apps-node/deploys/node-test/app.js"
  $deploy_test_app_source               = "puppet:///modules/nodejs/app.js"
  $deploy_test_app_init_file_name       = "/etc/init.d/node-test"
  $deploy_test_app_init_file_source     = "puppet:///modules/nodejs/ScritDeInicioNode-test"
  $deploy_test_log_file_name            = "/apps-node/logs/node-test.log"

# Parametros para la instalacion de modulos de nodejs usando npm
  $recargar_modulos_enable      = undef
  $lista_modulos                = undef
  $npmrc_root_file_name         = "/root/.npmrc"
  $npm_modules_directory        = "/apps-node/.npm-global"

# Parametros de pre-configuracion para evitar errores
  $npm_presets_config_command   = '/usr/bin/npm config set prefix "/apps-node/.npm-global/" && /usr/bin/npm config set proxy="http://PROXY_URL:PROXY_PORT"'
  $npm_presets_name             = 'prefixs_command_name'
  $npm_command_ensure           = '/apps-node/.npmrc'

}
