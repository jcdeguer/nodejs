class nodejs::group_add inherits nodejs::params {
  group { $grupo_rsync:
        ensure => 'present',
        gid    => '9999',
  }
  group { $grupo_nodejs:
        ensure => 'present',
  }
}
