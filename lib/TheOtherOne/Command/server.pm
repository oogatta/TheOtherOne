package TheOtherOne::Command::server;

use strict;
use warnings;

use feature ':5.14';

use List::Util qw(none);

use TheOtherOne -command;
use TheOtherOne::Server;

my $socket_key = lc TheOtherOne::Server::SOCKET;
my $signal_key = lc TheOtherOne::Server::SIGNAL;
my $http_key   = lc TheOtherOne::Server::HTTP;

sub abstract {
  'start server';
}

sub opt_spec {
  return (
    [ "$socket_key|s", 'use socket (default)' ],
    [ "$signal_key|i", 'use signal' ],
    [ "$http_key|h",   'use http' ],
    [ 'host|t=s',      'socket|http host (default: 0.0.0.0', { default => '0.0.0.0' } ],
    [ 'port|p=s',      'socket|http port (default: 7777)', { default => '7777' } ],
    [ 'rc=s',          'too configuration file path' ],
  );
}

sub validate_args {
  my ($self, $opt, $args) = @_;
  
  if ( none { $opt->{$_}; } ($socket_key, $signal_key, $http_key) ) {
    $opt->{$socket_key} = 1;
  }
}

sub execute {
  my ($self, $opt, $args) = @_;
  
  if ( $opt->{$socket_key} ) {
    TheOtherOne::Server->get($socket_key, $opt->{rc})->start($opt->{host}, $opt->{port});
  }
  elsif ( $opt->{$signal_key} ) {
    TheOtherOne::Server->get($signal_key, $opt->{rc})->start($args->[0]);
  }
  elsif ( $opt->{$http_key} ) {
  }
  else {
    print $self->usage;
  }
}

1;
