package TheOtherOne;

use strict;
use warnings;

use feature ':5.14';

use Module::Load;

use constant SOCKET => 'Socket';
use constant SIGNAL => 'Signal';

sub server {
    my ($class, $type) = @_;

    my $module = "TheOtherOne::Server::$type";
    load $module;
    $module->new;
}

1;