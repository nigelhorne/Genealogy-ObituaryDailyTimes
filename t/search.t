#!perl -wT

use strict;

use lib 'lib';
use Test::Most tests => 3;
use lib 't/lib';
use MyLogger;

BEGIN {
	use_ok('Genealogy::ObituaryDailyTimes');
}

SEARCH: {
	if($ENV{'TEST_VERBOSE'}) {
		Genealogy::ObituaryDailyTimes::DB::init(logger => MyLogger->new());
	}
	SKIP: {
		skip 'Database not installed', 2, if(!-r 'lib/Genealogy/ObituaryDailyTimes/database/obituaries.sql');

		my $search = new_ok('Genealogy::ObituaryDailyTimes');

		my @smiths = $search->search(last => 'Smith');

		ok(scalar(@smiths) >= 1);

		if($ENV{'TEST_VERBOSE'}) {
			diag(Data::Dumper->new([\@smiths])->Dump());
		}
	}
}
