class nodejs::user_add inherits nodejs::params {
  user { $usuario_rsync:
    ensure  => 'present',
    comment => 'Usuario rsync para ser usado por Jenkins',
    groups  => $grupo_rsync,
    shell   => $rsync_shell,
    uid     => '10000',
  }
  user { $usuario_nodejs:
    ensure  => 'present',
    home    => $dir_mod_nodejs,
    comment => 'Usuario node para ser usado por NodeJS',
    groups  => [$grupo_nodejs,$grupo_rsync],
  }->
  exec { 'crear_bash_profile':
    command => '/usr/bin/touch /apps-node/.bash_profile && cat /etc/skel/.bash_profile > /apps-node/.bash_profile',
  }->
  exec { 'copia_eskel_bash_profile':
    command => '/usr/bin/cat /etc/skel/.bash_profile > /apps-node/.bash_profile',
  }->
  exec { 'crea_bashrc':
    command => '/usr/bin/touch /apps-node/.bashrc',
  }->
  exec { 'copia_skel_bashrc':
    command => '/usr/bin/cat /etc/skel/.bashrc > /apps-node/.bashrc',
  }->
  exec { 'modi_priv_node_bashrc':
    command => '/usr/bin/chmod 700 /apps-node/.bashrc ',
  }->
  exec { 'modi_own_node_bashrc':
    command => '/usr/bin/chown node:node /apps-node/.bashrc ',
  }
}
