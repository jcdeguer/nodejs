class nodejs::install {

  $package_nodejs       = $::nodejs::package_nodejs
  $package_gcc          = $::nodejs::package_gcc
  $package_make         = $::nodejs::package_make
  $package_oic_version  = $::nodejs::package_oic_version
  $package_oic_d        = "oracle-instantclient${package_oic_version}-devel.x86_64"
  $package_oic_b        = "oracle-instantclient${package_oic_version}-basic.x86_64"

  package { $package_nodejs: ensure => 'installed' }
  package { $package_gcc: ensure => 'installed' }
  package { $package_make: ensure => 'installed' }
  package { $package_oic_d: ensure => 'installed' }
  package { $package_oic_b: ensure => 'installed' }

}
