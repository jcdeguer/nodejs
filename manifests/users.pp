# Maneja los usuarios
class nodejs::users {

  $usuario_rsync        = $::nodejs::usuario_rsync
  $grupo_rsync          = $::nodejs::grupo_rsync
  $usuario_nodejs       = $::nodejs::usuario_nodejs
  $grupo_nodejs         = $::nodejs::grupo_nodejs
  $dir_mod_nodejs       = $::nodejs::dir_mod_nodejs
  $rsync_group_name     = $::nodejs::rsync_group_name
  $rsync_user_name      = $::nodejs::rsync_user_name
  $rsync_user_comment   = $::nodejs::rsync_user_comment
  $rsync_user_home      = $::nodejs::rsync_user_home
  $rsync_user_uid       = $::nodejs::rsync_user_uid
  $rsync_shell_file     = $::nodejs::rsync_shell_file
  $nodejs_group_name    = $::nodejs::nodejs_group_name
  $nodejs_user_name     = $::nodejs::nodejs_user_name
  $nodejs_user_comment  = $::nodejs::nodejs_user_comment
  $nodejs_user_uid      = $::nodejs::nodejs_user_uid
  $nodejs_user_home     = $::nodejs::nodejs_user_home

  user { $rsync_user_name:
    ensure      => 'present',
    comment     => $rsync_user_comment, # 'Usuario rsync para ser usado por Jenkins',
    home        => $rsync_user_home,
    groups      => $rsync_group_name,
    shell       => $rsync_shell_file,
    uid         => $rsync_user_uid, # '10000',
  }
  user { $nodejs_user_name:
    ensure      => 'present',
    home        => $nodejs_user_home,
    comment     => $nodejs_user_comment,
    groups      => [$nodejs_group_name,$rsync_group_name],
  }->
  exec { 'crear_bash_profile':
    command => "/usr/bin/touch ${nodejs_user_home}/.bash_profile && cat /etc/skel/.bash_profile > ${nodejs_user_home}/.bash_profile",
    creates => '/apps-node/.bash_profile',
  }->
  exec { 'crea_bashrc':
    command => "/usr/bin/touch ${nodejs_user_home}/.bashrc",
    creates => '/apps-node/.bashrc',
  }
}
