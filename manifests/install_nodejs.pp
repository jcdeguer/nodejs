class nodejs::install_nodejs inherits nodejs::params {
  package { $version_nodejs:
        ensure => 'installed'
  }
  package { $version_npm:
        ensure => 'installed'
  }
}
