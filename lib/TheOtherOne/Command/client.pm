package TheOtherOne::Command::client;

use strict;
use warnings;

use feature ':5.14';

use List::Util qw(none);

use TheOtherOne -command;
use TheOtherOne::Client;

my $socket_key = lc TheOtherOne::Client::SOCKET;
my $http_key   = lc TheOtherOne::Client::HTTP;

sub abstract {
  'connect to too server';
}

sub opt_spec {
  return (
    [ "$socket_key|s", 'use socket' ],
    [ "$http_key|h",   'use http' ],
    [ 'host|t=s',      'socket|http host', { default => '127.0.0.1' } ],
    [ 'port|p=s',      'socket|http port', { default => '7777' } ],
    [ 'verbose|v',     'speaks verbosely',  { default => 0 } ],
  );
}

sub validate_args {
  my ($self, $opt, $args) = @_;
  
  if ( none { $opt->{$_}; } ($socket_key, $http_key) ) {
    $opt->{$socket_key} = 1;
  }
}

sub execute {
  my ($self, $opt, $args) = @_;
  
  if ( $opt->{$socket_key} ) {
    TheOtherOne::Client->get($socket_key)->run($opt->{host}, $opt->{port}, $args->[0], $opt->{verbose});
  }
  elsif ( $opt->{$http_key} ) {
  }
  else {
    print $self->usage;
  }
}

1;
