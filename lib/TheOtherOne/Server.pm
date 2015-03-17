package TheOtherOne::Server;

use strict;
use warnings;

use feature ':5.14';

use Module::Load;

use constant SOCKET => 'socket';
use constant SIGNAL => 'signal';
use constant HTTP   => 'HTTP';

sub get {
  my ($class, $type, $rc) = @_;

  my $module = "TheOtherOne::Server::${\ucfirst($type)}";
  load $module;
  $module->new($rc);
}

1;