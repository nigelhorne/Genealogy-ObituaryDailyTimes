#!/usr/bin/env perl

use strict;
use warnings;

use Test::Most;
use File::Spec;
use File::Temp qw/tempfile tempdir/;
use YAML::XS qw/DumpFile/;

use_ok('Genealogy::ObituaryDailyTimes');

# Create a temp config file
my $tempdir = tempdir(CLEANUP => 1);
my $config_file = File::Spec->catdir($tempdir, 'config.yml');

# Write a fake config with a directory that exists
my $fake_directory = $tempdir; # just use the tempdir itself
my $class_name = 'Genealogy::ObituaryDailyTimes';

DumpFile($config_file, {
	$class_name => { directory => $fake_directory }
});

# Create object using the config_file
my $obj = Genealogy::ObituaryDailyTimes->new(config_file => $config_file);

ok($obj, 'Object was created successfully');
isa_ok($obj, 'Genealogy::ObituaryDailyTimes');
is($obj->{directory}, $fake_directory, 'Directory was read from config file');

subtest 'Environment test' => sub {
	local $ENV{'Genealogy::ObituaryDailyTimes_DIRECTORY'} = '/';

	$obj = Genealogy::ObituaryDailyTimes->new(config_file => $config_file);

	ok($obj, 'Object was created successfully');
	isa_ok($obj, 'Genealogy::ObituaryDailyTimes');
	is($obj->{directory}, '/', 'Read config directory from the environment');
};

# Nonexistent config file is ignored
lives_ok {
	Genealogy::ObituaryDailyTimes->new(config_file => '/nonexistent/path/to/config.yml');
} 'Does not throw error for nonexistent config file';

# Malformed config file (not a hashref)
my ($badfh, $badfile) = tempfile();
print $badfh "--- Just a list\n- foo\n- bar\n";
close $badfh;

throws_ok {
	Genealogy::ObituaryDailyTimes->new(config_file => $badfile);
} qr/Can't locate object method|HASH/, 'Throws error if config is not a hashref';

# Config file exists but has no key for the class
my $nofield_file = File::Spec->catdir($tempdir, 'nokey.yml');
DumpFile($nofield_file, {
	NotTheClass => { directory => $tempdir }
});
$obj = Genealogy::ObituaryDailyTimes->new(config_file => $nofield_file);
ok($obj, 'Object created with config that lacks class key');
diag($obj->{directory});
like($obj->{directory}, qr/lib.Genealogy.ObituaryDailyTimes.data$/, 'Falls back to passed args if class key missing (uses directory directly)');

# Directory in config file does not exist
my $bad_dir_file = File::Spec->catdir($tempdir, 'baddir.yml');
DumpFile($bad_dir_file, {
	$class_name => { directory => '/definitely/does/not/exist' }
});
my $obj2 = Genealogy::ObituaryDailyTimes->new(config_file => $bad_dir_file);
ok(!defined $obj2, 'Returns undef if directory from config file is invalid');

done_testing();
