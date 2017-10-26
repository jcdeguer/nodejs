class nodejs::pre_config {

  $rsync_shell_file             = $::nodejs::rsync_shell_file
  $rsync_shell_file_source      = $::nodejs::rsync_shell_file_source
  $npm_presets_config_command   = $::nodejs::npm_presets_config_command
  $npm_presets_name             = $::nodejs::npm_presets_name
  $npm_command_ensure           = $::nodejs::npm_command_ensure

  file { $rsync_shell_file:
    ensure => present,
    owner => 'root',
    group => 'root',
    mode => 0755,
    source => $rsync_shell_file_source,
  }

  exec { $npm_presets_name:
    command => $npm_presets_config_command,
    creates => $npm_command_ensure,
  }

}
