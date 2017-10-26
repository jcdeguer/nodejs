class nodejs::group {

  $rsync_group_name     = $::nodejs::rsync_group_name
  $rsync_user_uid       = $::nodejs::rsync_user_uid
  $nodejs_group_name    = $::nodejs::nodejs_group_name

  group { $rsync_group_name: ensure => 'present', gid => $rsync_user_uid, }
  group { $nodejs_group_name: ensure => 'present', }

}
