package TheOtherOne::Client::Socket;

use strict;
use warnings;

use feature ':5.14';

use IO::Socket::INET;

$| = 1;

sub new { bless {}; }

sub run {
  my ($self, $host, $port, $test_target, $verbose) = @_;
  
  my $socket = new IO::Socket::INET (
      PeerHost => $host,
      PeerPort => $port,
      Proto    => 'tcp',
  );
  die "cannot connect to the server $!\n" unless $socket;
  
  say 'connected to the server.' if $verbose;
  
  my $size = $socket->send($test_target);
  say "sent: $test_target" if $verbose;
  
  shutdown $socket, 1;
  
  $socket->close();
}

1;