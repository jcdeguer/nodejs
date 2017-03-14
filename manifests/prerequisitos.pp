class nodejs::prerequisitos inherits nodejs::params {
  exec { 'crea_rsync_shell_file_vacio': # Crea un archivo vacio por dependencia.
    command => '/usr/bin/touch /usr/local/bin/rsync_shell.pl',
  }->
  exec { 'mod_rsync_shell_file': # Se le da privilegios de ejecucion a ese archivo vacio.
    command => '/usr/bin/chmod +x /usr/local/bin/rsync_shell.pl',
  }
  exec { 'prefixs': # Setea el prefix y el proxy en npm.
    command => '/usr/bin/npm config set prefix "/apps-node/.npm-global/" && /usr/bin/npm config set proxy="http://IP_PROXY:PUERTO_PROXY"',
  }
}
