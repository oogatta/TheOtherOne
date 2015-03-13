package TheOtherOne::Server::Signal;

use strict;
use warnings;

use TheOtherOne::Runner;

use feature ':5.14';


sub new { bless {}; }

sub start {
  my ($self, $target) = @_;

  my $running = 1;

  run_test($target);

  $SIG{INT} = sub {
    run_test($target);
  };

  $SIG{QUIT} = sub {
    $running = 0;
  };

  while ($running) {
    sleep 2;
  }
}

sub run_test {
  TheOtherOne::Runner->run(shift);
}

1;