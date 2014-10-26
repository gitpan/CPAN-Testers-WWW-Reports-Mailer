#!perl -w
use strict;

$|=1;

# -------------------------------------------------------------------
# Library Modules

use lib qw(t/lib);
use Test::More;

use CPAN::Testers::WWW::Reports::Mailer;

use TestEnvironment;
use TestObject;

# -------------------------------------------------------------------
# Variables

my $TESTS = 15;

my %COUNTS = (
    REPORTS => 10643,
    PASS    => 9688,
    FAIL    => 896,
    UNKNOWN => 40,
    NA      => 19,
    NOMAIL  => 0,
    MAILS   => 1,
    NEWAUTH => 0,
    GOOD    => 0,
    BAD     => 0,
    TEST    => 1
);

my @DATA = (
    'auth|BARBIE|3|NULL',
    'dist|BARBIE|-|0|1|FAIL|ALL|ALL|0|ALL|ALL'
);

my %files = (
    'lastmail' => 't/_TMPDIR/test-lastmail.txt',
    'logfile'  => 't/_TMPDIR/test-daily.log',
    'mailfile' => 'mailer-debug.log'
);

my $CONFIG = 't/_DBDIR/preferences-daily.ini';

# -------------------------------------------------------------------
# Tests

for(keys %files) {
    unlink $files{$_}   if(-f $files{$_});
}

my $handles = TestEnvironment::Handles();
if(!$handles)   { plan skip_all => "Unable to create test environment"; }
else            { plan tests    => $TESTS }

SKIP: {
    skip "No supported databases available", $TESTS  unless($handles->{CPANPREFS});

    my ($pa,$pd) = TestEnvironment::ResetPrefs(\@DATA);
    is($pa,1,'author records added');
    is($pd,1,'distro records added');

    my $mailer = TestObject->load(config => $CONFIG);

    is($mailer->nomail,1);

    if($mailer->nomail) {
        $mailer->check_reports();
        $mailer->check_counts();
    }

    is($mailer->{counts}{$_},$COUNTS{$_},"Matched count for $_") for(keys %COUNTS);

    my ($mail1,$mail2) = TestObject::mail_check($files{mailfile},'t/data/61daily.eml');
    is_deeply($mail1,$mail2,'mail files match');
}
