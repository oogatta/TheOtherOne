package TheOtherOne::Server::Socket;

use strict;
use warnings;

use feature ':5.14';

use File::Slurp;

use IO::Socket::INET;

use Module::Load;

$| = 1;

use TheOtherOne::Runner;

sub new {
  my ($class, $rc) = @_;
  
  load $rc;
  
  my $rc_data = read_file($rc);
  say $rc_data;
  if ( $rc_data ) {
    while ( $rc_data =~ /^package\s+([a-zA-Z:]+)\s+[{\$]/mg ) {
      say $1;
    }
  }
  
  bless { rc => $rc };
}

sub start {
  my ($self, $host, $port) = @_;

  my $socket = new IO::Socket::INET (
    LocalHost => $host // '0.0.0.0',
    LocalPort => $port // '7777',
    Proto     => 'tcp',
    Listen    => 5,
    Reuse     => 1
  );
  die "cannot create socket $!\n" unless $socket;

  say "server started on port $port.";

  while ( 1 ) {
    my $client_socket = $socket->accept();

    my $target;
    $client_socket->recv($target, 1024);

    if ( $target ) {
      say "received data: $target";
  
      #TheOtherOne::Runner->run($target);
    }

    shutdown $client_socket, 1;
  }

  say 'server stopped.';

  $socket->close();
}

1;