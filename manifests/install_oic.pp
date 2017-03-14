class nodejs_for_el7::install_oic inherits nodejs_for_el7::params {
  package { $version_gcc:
        ensure => 'installed'
  }
  package { $version_make:
        ensure => 'installed'
  }
  package { $version_oracle_instant_client_devel:
        ensure => 'installed'
  }
  package { $version_oracle_instant_client_basic:
        ensure => 'installed'
  }
}
