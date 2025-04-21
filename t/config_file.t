#!/usr/bin/env perl

use strict;
use warnings;

use Test::Most;
use File::Temp qw/tempfile tempdir/;
use YAML::XS qw/DumpFile/;

use_ok('Genealogy::ObituaryDailyTimes');

# Create a temp config file
my $tempdir = tempdir(CLEANUP => 1);
my $config_file = "$tempdir/config.yml";

# Write a fake config with a directory that exists
my $fake_directory = $tempdir; # just use the tempdir itself
my $class_name = 'Genealogy::ObituaryDailyTimes';

DumpFile($config_file, {
	$class_name => {
		directory => $fake_directory,
	}
});

# Create object using the config_file
my $obj = Genealogy::ObituaryDailyTimes->new(config_file => $config_file);

ok($obj, 'Object was created successfully');
isa_ok($obj, 'Genealogy::ObituaryDailyTimes');
is($obj->{directory}, $fake_directory, 'Directory was read from config file');

local $ENV{'Genealogy::ObituaryDailyTimes_DIRECTORY'} = '/';

$obj = Genealogy::ObituaryDailyTimes->new(config_file => $config_file);

ok($obj, 'Object was created successfully');
isa_ok($obj, 'Genealogy::ObituaryDailyTimes');
is($obj->{directory}, '/', 'Read config directory from the environment');

done_testing();
