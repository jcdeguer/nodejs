class nodejs::group_add inherits nodejs::params {
  group { $grupo_rsync:
        ensure => 'present',
        gid    => '10000',
  }
  group { $grupo_nodejs:
        ensure => 'present',
  }
}
