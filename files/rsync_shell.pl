#!/usr/bin/perl

$command = $ENV{SSH_ORIGINAL_COMMAND};
chomp($command);

if($command =~/^rsync --server.* \/apps-node\/deploys\/\S+\/$/) {
  `echo OK $command >> /tmp/rsync_jenkins.log`;
}
elsif($command =~/^\/usr\/bin\/sudo \/etc\/init.d\/node-\S+ restart$/) {
  `echo OK $command >> /tmp/rsync_jenkins.log`;
}
else {
  `echo MUERO $command >> /tmp/rsync_jenkins.log`;
  die("Acceso Denegado");
}
exec($command);
