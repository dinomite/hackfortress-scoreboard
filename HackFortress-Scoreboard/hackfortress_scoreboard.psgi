use strict;
use warnings;

use HackFortress::Scoreboard;

my $app = HackFortress::Scoreboard->apply_default_middlewares(HackFortress::Scoreboard->psgi_app);
$app;

