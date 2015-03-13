package TheOtherOne::Runner;

use strict;
use warnings;

use feature ':5.14';

use Cwd 'abs_path';
use App::Prove;

sub run {
  my ($class, $target) = @_;

  say 'ok, starting tests.';

  my @args = ();
  push @args, '-l';
  push @args, '-r';
  push @args, '-v';
  push @args, '-w';
  push @args, '--color';
  push @args, '-PPretty';

  # TODO この人らはオプションで受け付ける
  push @args, '-j1'; #grep -c ^processor /proc/cpuinfo
  push @args, '-I/kaisya/no/perl5/x86_64-linux-thread-multi';
  push @args, '-I/kaisya/no/perl5';
  push @args, '-It/inc';
  push @args, '--rc=t/proverc';

  push @args, $target;

  my $app = App::Prove->new;
  $app->process_args(@args);
  $app->run;

  say 'tests finished i guess.';
}


1;