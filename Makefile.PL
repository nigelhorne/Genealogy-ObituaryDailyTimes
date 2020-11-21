use strict;
use warnings;
use ExtUtils::MakeMaker 6.64;	# 6.64 for TEST_REQUIRES

WriteMakefile(
	NAME		=> 'Genealogy::ObituaryDailyTimes',
	AUTHOR		=> q{Nigel Horne <njh@bandsman.co.uk>},
	VERSION_FROM	=> 'lib/Genealogy/ObituaryDailyTimes.pm',
	ABSTRACT_FROM	   => 'lib/Genealogy/ObituaryDailyTimes.pm',
	((defined($ExtUtils::MakeMaker::VERSION) &&
	 ($ExtUtils::MakeMaker::VERSION >= 6.3002))
	  ? ('LICENSE'=> 'GPL')
	  : ()),
	'LIBS' => [''],   # e.g., '-lm'
	'DEFINE' => '',     # e.g., '-DHAVE_SOMETHING'
	'INC' => '',     # e.g., '-I/usr/include/other'
	PL_FILES	=> {},
	TEST_REQUIRES => {
		'Test::Most' => 0,
		'Test::NoWarnings' => 0,
		# 'Test::Kwalitee' => 0,
		'autodie' => 0,
		'IPC::System::Simple' => 0,
	}, PREREQ_PM => {
		'DBI' => 0,
		'File::HomeDir' => 0,
		'File::Spec' => 0,
		'HTML::Entities' => 0,
		'HTTP::Cache::Transparent' => 0,
		'LWP::ConnCache' => 0,
		'LWP::UserAgent::WithCache' => 0,
		'Lingua::EN::NameCase' => 0,
		'Try::Tiny' => 0,
	},
	dist		=> { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
	clean		=> { FILES => 'Genealogy-ObituaryDailyTimes-*' },
	# META_ADD => {
		# provides => {}
	# },
	META_MERGE		=> {
		'meta-spec' => { version => 2 },
		resources => {
			repository => {
				type => 'git',
				url => 'git://github.com/nigelhorne/Genealogy-ObituaryDailyTimes.git',
				web => 'https://github.com/nigelhorne/Genealogy-ObituaryDailyTimes',
				repository => 'https://github.com/nigelhorne/Genealogy-ObituaryDailyTimes',
			},
			bugtracker => {
				# web => 'https://rt.cpan.org/Public/Dist/Display.html?Name=Genealogy-ObituaryDailyTimes',
				# mailto => 'bug-Genealogy-ObituaryDailyTimes@rt.cpan.org'
				web => 'https://github.com/nigelhorne/Genealogy-ObituaryDailyTimes/issues',
				url => 'https://github.com/nigelhorne/Genealogy-ObituaryDailyTimes/issues',
			}

		},
	},
	PPM_INSTALL_EXEC	=> 'perl',
	PPM_INSTALL_SCRIPT	=> 'bin/create_db.PL',
	MIN_PERL_VERSION	=> '5.6.2'	# Probably would work, but never tested on earlier versions than this
);
