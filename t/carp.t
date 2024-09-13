#!perl -wT

use strict;
use warnings;
use Test::Most tests => 6;
use Test::Needs 'Test::Carp';

BEGIN {
	use_ok('Genealogy::ObituaryDailyTimes');
}

SKIP: {
	skip('Database not installed', 5) if(!-r 'lib/Genealogy/ObituaryDailyTimes/data/obituaries.sql');

	Test::Carp->import();

	my $search = new_ok('Genealogy::ObituaryDailyTimes' => [ directory => 'lib/Genealogy/ObituaryDailyTimes/data' ]);

	does_carp_that_matches(sub { my @empty = $search->search(); }, qr/^Value for 'last' is mandatory/);
	does_carp_that_matches(sub { my @empty = $search->search(last => undef); }, qr/^Value for 'last' is mandatory/);
	does_carp_that_matches(sub { my @empty = $search->search({ last => undef }); }, qr/^Value for 'last' is mandatory/);
	does_carp_that_matches(sub { my $o = Genealogy::ObituaryDailyTimes->new({ directory => '/not_there' }); }, qr/ is not a directory$/);
	done_testing();
}
