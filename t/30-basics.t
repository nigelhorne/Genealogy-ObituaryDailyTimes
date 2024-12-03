#!/usr/bin/env perl

use strict;
use warnings;
use Test::More tests => 4;

# Module loads
BEGIN { use_ok('Genealogy::ObituaryDailyTimes') }

# Object creation
my $directory = 'lib/Genealogy/ObituaryDailyTimes/data';
my $called = 0;
my $logger = sub { $called++ };
my $obj = Genealogy::ObituaryDailyTimes->new(
	directory => $directory,
	logger => $logger
);
ok($obj, 'Object created successfully');

# Method 'search' for mandatory 'last' argument
my $result = $obj->search(last => 'Smith');
ok($result, 'Search method works with mandatory "last" argument');
cmp_ok($called, '>', 0, 'Logger has been called');
