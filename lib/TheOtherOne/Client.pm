package TheOtherOne::Client;

use strict;
use warnings;

use feature ':5.14';

use Module::Load;

use constant SOCKET => 'socket';
use constant HTTP   => 'HTTP';

sub get {
  my ($class, $type) = @_;

  my $module = "TheOtherOne::Client::${\ucfirst($type)}";
  load $module;
  $module->new;
}

1;