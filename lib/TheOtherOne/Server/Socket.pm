package TheOtherOne::Server::Socket;

use strict;
use warnings;

use feature ':5.14';

use IO::Socket::INET;

$| = 1;

use TheOtherOne::Runner;

sub new { bless {}; }

sub start {
  my ($self, $port) = @_;

  my $socket = new IO::Socket::INET (
    LocalHost => '0.0.0.0',
    LocalPort => $port // '7777',
    Proto     => 'tcp',
    Listen    => 1,
    Reuse     => 1
  );
  die "cannot create socket $!\n" unless $socket;

  say "server started on port $port.";

  while ( 1 ) {
    my $client_socket = $socket->accept();

    my $data = '';
    $client_socket->recv($data, 1024);
    say "received data: $data";

    TheOtherOne::Runner->run($data);

    shutdown $client_socket, 1;
  }

  say 'server stopped.';

  $socket->close();
}

1;