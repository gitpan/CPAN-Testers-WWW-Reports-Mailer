#!perl

use strict;
use warnings;

use Test::More tests => 33;
use CPAN::Testers::WWW::Reports::Mailer;

use lib 't';
use CTWRM_Testing;

ok( my $obj = CTWRM_Testing::getObj(), "got object" );

# test the attributes generated by Class::Accessor::Fast

# predefined attributes
foreach my $k ( qw/
	debug
    logfile
    logclean
    tt
    pause
    lastmail
    mode
    mailrc
/ ){
  my $label = "[$k]";
  SKIP: {
    ok( $obj->can($k), "$label can" )
	or skip "'$k' attribute missing", 3;
    isnt( $obj->$k(), undef, "$label has default" );
    is( $obj->$k(123), 123, "$label set" );
    is( $obj->$k, 123, "$label get" );
  };
}

