#!perl

use strict;
use warnings;
use Test::More tests => 1;
use DBI;
#use DBD::SQLite;
use File::Spec;
use File::Path;
use File::Basename;

my $f = File::Spec->catfile('t','_DBDIR','test.db');
#unlink $f if -f $f;
mkpath( dirname($f) );

my $dbh = DBI->connect("dbi:SQLite:dbname=$f", '', '', {AutoCommit=>1});
$dbh->do(q{
    CREATE TABLE `ixlatest` (
      `dist`        text    NOT NULL,
      `version`     text    NOT NULL,
      `released`    int		NOT NULL,
      `author`      text    NOT NULL,
      PRIMARY KEY  (`dist`)
    );
});

while(<DATA>){
  chomp;
  $dbh->do('INSERT INTO ixlatest ( dist, version, released, author ) VALUES ( ?, ?, ?, ? )', {}, split(/\|/,$_) );
}

my ($ct) = $dbh->selectrow_array('select count(*) from ixlatest');

$dbh->disconnect;

is($ct, 40, "row ct");


#select * from ixlatest where author in ('LBROCARD', 'DRRHO', 'VOISCHEV', 'INGY', 'ISHIGAKI', 'SAPER', 'ZOFFIX', 'GARU', 'JESSE', 'JETEVE', 'JJORE', 'JBRYAN', 'JALDHAR', 'JHARDING', 'ADRIANWIT');
#dist|version|released|author
__DATA__
App-Maisha-Plugin-PingFM|0.02|1234885380|BARBIE
App-Maisha|0.12|1235740440|BARBIE
Calendar-List|0.21|1212419186|BARBIE
CPAN-YACSmoke-Plugin-NNTPWeb|0.06|1173724460|BARBIE
CPAN-YACSmoke-Plugin-Outlook|0.06|1173717440|BARBIE
CPAN-YACSmoke-Plugin-NNTP|0.05|1173718960|BARBIE
CPAN-YACSmoke-Plugin-WebList|0.05|1173717735|BARBIE
CPAN-WWW-Testers-Generator|0.30|1222885029|BARBIE
CPAN-Testers-Common-DBUtils|0.03|1229515740|BARBIE
CPAN-Testers-Data-Uploads|0.06|1234715460|BARBIE
CPAN-Testers-Common-Article|0.36|1234445700|BARBIE
CPAN-WWW-Testers|0.49|1234786620|BARBIE
CPAN-Testers-WWW-Statistics|0.65|1244286761|BARBIE
CPAN-Testers-WWW-Reports-Mailer|0.17|1244282381|BARBIE
CPAN-Testers-Data-Generator|0.37|1244364903|BARBIE
CPAN-Testers-Data-Release|0.01|1244389664|BARBIE
CPAN-Testers-WWW-Reports-Parser|0.01|1244470653|BARBIE
Data-Phrasebook-Loader-DBI|0.11|1172753895|BARBIE
Data-Phrasebook-Loader-Ini|0.10|1172755893|BARBIE
Data-Phrasebook-Loader-YAML|0.09|1172756473|BARBIE
Data-Phrasebook|0.29|1172841682|BARBIE
Data-Phrasebook-Loader-XML|0.12|1172756091|BARBIE
Data-FormValidator-Constraints-Words|0.03|1206822667|BARBIE
Finance-Currency-Convert-XE|0.15|1205771511|BARBIE
Games-Trackword|1.06|1212417962|BARBIE
GD-Chart-Radial|0.07|1194000443|BARBIE
Mail-File|0.08|1172838898|BARBIE
Mail-Outlook|0.15|1234310220|BARBIE
Parse-CPAN-Distributions|0.05|1221814104|BARBIE
Regexp-Log-Common|0.05|1172838993|BARBIE
Test-CPAN-Meta|0.13|1243188537|BARBIE
Test-YAML-Meta|0.12|1243188450|BARBIE
WWW-Scraper-ISBN-Amazon_Driver|0.14|1226933400|BARBIE
WWW-Scraper-ISBN-ORA_Driver|0.09|1214580873|BARBIE
WWW-Scraper-ISBN-Pearson_Driver|0.10|1214581796|BARBIE
WWW-UCC|0.02|1067603715|BARBIE
WWW-UsePerl-Journal|0.22|1222694640|BARBIE
WWW-UsePerl-Journal-Thread|0.12|1222771326|BARBIE
WWW-Scraper-ISBN-Yahoo_Driver|0.08|1226932860|BARBIE
Test-JSON-Meta|0.01|1247682480|BARBIE