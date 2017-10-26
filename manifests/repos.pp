# Class: nodejs::repos
#
# This class config repo of the application.
#
class nodejs::repos {

  $version_oic          = $::nodejs::version_oic
  $repo_oic_file_name   = $::nodejs::repo_oic_file_name
  $repo_oic_status      = $::nodejs::repo_oic_status
  $repo_oic_baseurl     = $::nodejs::repo_oic_baseurl

  if $::operatingsystemmajrelease == '7' {
    yumrepo { $repo_oic_file_name: # Configurara el repositorio para Oracle Instant Client
      enabled   => $repo_oic_status,
      descr     => "Oracle Instant Client ${version_oic} x86_64",
      baseurl   => $repo_oic_baseurl,
      gpgcheck  => 0,
    }
  }
}
