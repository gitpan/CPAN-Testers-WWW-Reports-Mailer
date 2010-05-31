#!perl

use strict;
use warnings;
$|=1;
use Test::More tests => 1;
use DBI;
#use DBD::SQLite;
use File::Spec;
use File::Path;
use File::Basename;

my $f = File::Spec->catfile('t','_DBDIR','test.db');
mkpath( dirname($f) );

my $dbh = DBI->connect("dbi:SQLite:dbname=$f", '', '', {AutoCommit=>1});
$dbh->do(q{
  CREATE TABLE uploads (
                          type          TEXT,
                          author        TEXT,
                          dist          TEXT,
                          version       TEXT,
                          filename      TEXT,
                          released      TEXT
  )
});

while(<DATA>){
  chomp;
  $dbh->do('INSERT INTO uploads ( type, author, dist, version, filename, released ) VALUES ( ?, ?, ?, ?, ?, ? )', {}, split(/\|/,$_) );
}

$dbh->do(q{ CREATE INDEX distvers ON uploads (dist, version) });
$dbh->do(q{ CREATE INDEX author ON uploads (author) });

my ($ct) = $dbh->selectrow_array('select count(*) from uploads');

$dbh->disconnect;

is($ct, 303, "row count for uploads");

#select * from uploads where author in ('BARBIE') and released < unix_timestamp('2009-07-25 08:07:00') ORDER BY released;
# type|author|dist|version|filename|released
__DATA__
backpan|BARBIE|Calendar-List|0.05|Calendar-List-0.05.tar.gz|1060187826
backpan|BARBIE|Calendar-List|0.06|Calendar-List-0.06.tar.gz|1060255836
backpan|BARBIE|WWW-UsePerl-Journal-Thread|0.01|WWW-UsePerl-Journal-Thread-0.01.tar.gz|1060786944
backpan|BARBIE|WWW-UsePerl-Journal-Thread|0.02|WWW-UsePerl-Journal-Thread-0.02.tar.gz|1060866018
backpan|BARBIE|Games-Trackword|1.0|Games-Trackword-1.0.tar.gz|1063100923
backpan|BARBIE|WWW-UCC|0.02|WWW-UCC-0.02.tar.gz|1067603715
backpan|BARBIE|WWW-UsePerl-Journal-Thread|0.03|WWW-UsePerl-Journal-Thread-0.03.tar.gz|1068113860
backpan|BARBIE|Calendar-List|0.07|Calendar-List-0.07.tar.gz|1068113971
backpan|BARBIE|Finance-Currency-Convert-XE|0.03|Finance-Currency-Convert-XE-0.03.tar.gz|1068114082
backpan|BARBIE|Games-Trackword|1.01|Games-Trackword-1.01.tar.gz|1068114098
backpan|BARBIE|Calendar-List|0.08|Calendar-List-0.08.tar.gz|1068203537
backpan|BARBIE|Calendar-List|0.10|Calendar-List-0.10.tar.gz|1071599388
backpan|BARBIE|Finance-Currency-Convert-XE|0.04|Finance-Currency-Convert-XE-0.04.tar.gz|1076675511
backpan|BARBIE|Finance-Currency-Convert-XE|0.05|Finance-Currency-Convert-XE-0.05.tar.gz|1078423427
backpan|BARBIE|WWW-UsePerl-Journal-Thread|0.04|WWW-UsePerl-Journal-Thread-0.04.tar.gz|1078930288
backpan|BARBIE|WWW-Scraper-ISBN-ORA_Driver|0.01|WWW-Scraper-ISBN-ORA_Driver-0.01.tar.gz|1081358109
backpan|BARBIE|WWW-Scraper-ISBN-Pearson_Driver|0.01|WWW-Scraper-ISBN-Pearson_Driver-0.01.tar.gz|1081358336
backpan|BARBIE|WWW-Scraper-ISBN-Amazon_Driver|0.01|WWW-Scraper-ISBN-Amazon_Driver-0.01.tar.gz|1082048248
backpan|BARBIE|WWW-Scraper-ISBN-Yahoo_Driver|0.01|WWW-Scraper-ISBN-Yahoo_Driver-0.01.tar.gz|1082048552
backpan|BARBIE|Calendar-List|0.11|Calendar-List-0.11.tar.gz|1082386615
backpan|BARBIE|WWW-UsePerl-Journal-Thread|0.05|WWW-UsePerl-Journal-Thread-0.05.tar.gz|1082387058
backpan|BARBIE|Finance-Currency-Convert-XE|0.06|Finance-Currency-Convert-XE-0.06.tar.gz|1082387563
backpan|BARBIE|Games-Trackword|1.02|Games-Trackword-1.02.tar.gz|1082388255
backpan|BARBIE|WWW-Scraper-ISBN-Amazon_Driver|0.02|WWW-Scraper-ISBN-Amazon_Driver-0.02.tar.gz|1082389385
backpan|BARBIE|WWW-Scraper-ISBN-Yahoo_Driver|0.02|WWW-Scraper-ISBN-Yahoo_Driver-0.02.tar.gz|1082390454
backpan|BARBIE|WWW-Scraper-ISBN-Pearson_Driver|0.02|WWW-Scraper-ISBN-Pearson_Driver-0.02.tar.gz|1082390572
backpan|BARBIE|WWW-Scraper-ISBN-ORA_Driver|0.02|WWW-Scraper-ISBN-ORA_Driver-0.02.tar.gz|1082391845
backpan|BARBIE|WWW-UsePerl-Journal-Thread|0.06|WWW-UsePerl-Journal-Thread-0.06.tar.gz|1082470512
backpan|BARBIE|WWW-UsePerl-Journal-Thread|0.07|WWW-UsePerl-Journal-Thread-0.07.tar.gz|1082642622
backpan|BARBIE|Calendar-List|0.12|Calendar-List-0.12.tar.gz|1082645085
backpan|BARBIE|Calendar-List|0.13|Calendar-List-0.13.tar.gz|1082654026
backpan|BARBIE|WWW-Scraper-ISBN-ORA_Driver|0.03|WWW-Scraper-ISBN-ORA_Driver-0.03.tar.gz|1084282208
backpan|BARBIE|WWW-Scraper-ISBN-Pearson_Driver|0.03|WWW-Scraper-ISBN-Pearson_Driver-0.03.tar.gz|1084283342
backpan|BARBIE|WWW-Scraper-ISBN-Pearson_Driver|0.04|WWW-Scraper-ISBN-Pearson_Driver-0.04.tar.gz|1086631359
backpan|BARBIE|WWW-Scraper-ISBN-ORA_Driver|0.04|WWW-Scraper-ISBN-ORA_Driver-0.04.tar.gz|1093975005
backpan|BARBIE|WWW-Scraper-ISBN-Pearson_Driver|0.05|WWW-Scraper-ISBN-Pearson_Driver-0.05.tar.gz|1093976093
backpan|BARBIE|WWW-Scraper-ISBN-Amazon_Driver|0.03|WWW-Scraper-ISBN-Amazon_Driver-0.03.tar.gz|1094137093
backpan|BARBIE|WWW-Scraper-ISBN-Yahoo_Driver|0.03|WWW-Scraper-ISBN-Yahoo_Driver-0.03.tar.gz|1094139168
backpan|BARBIE|Calendar-List|0.14|Calendar-List-0.14.tar.gz|1105103843
backpan|BARBIE|WWW-Scraper-ISBN-ORA_Driver|0.05|WWW-Scraper-ISBN-ORA_Driver-0.05.tar.gz|1105104764
backpan|BARBIE|WWW-Scraper-ISBN-Amazon_Driver|0.04|WWW-Scraper-ISBN-Amazon_Driver-0.04.tar.gz|1105104890
backpan|BARBIE|WWW-Scraper-ISBN-Pearson_Driver|0.06|WWW-Scraper-ISBN-Pearson_Driver-0.06.tar.gz|1105105332
backpan|BARBIE|Finance-Currency-Convert-XE|0.07|Finance-Currency-Convert-XE-0.07.tar.gz|1105115986
backpan|BARBIE|Regexp-Log-Common|0.01|Regexp-Log-Common-0.01.tar.gz|1106564815
backpan|BARBIE|Mail-File|0.05|Mail-File-0.05.tar.gz|1106761989
backpan|BARBIE|Mail-Outlook|0.06|Mail-Outlook-0.06.tar.gz|1106762099
backpan|BARBIE|Data-Phrasebook|0.18|Data-Phrasebook-0.18.tar.gz|1109697090
backpan|BARBIE|Data-Phrasebook-Loader-Ini|0.02|Data-Phrasebook-Loader-Ini-0.02.tar.gz|1109697627
backpan|BARBIE|Data-Phrasebook-Loader-YAML|0.02|Data-Phrasebook-Loader-YAML-0.02.tar.gz|1109697851
backpan|BARBIE|Regexp-Log-Common|0.02|Regexp-Log-Common-0.02.tar.gz|1109698061
backpan|BARBIE|Calendar-List|0.15|Calendar-List-0.15.tar.gz|1109698617
backpan|BARBIE|WWW-Scraper-ISBN-Amazon_Driver|0.05|WWW-Scraper-ISBN-Amazon_Driver-0.05.tar.gz|1109706525
backpan|BARBIE|Data-Phrasebook-Loader-XML|0.02|Data-Phrasebook-Loader-XML-0.02.tar.gz|1109772204
backpan|BARBIE|Data-Phrasebook-Loader-DBI|0.02|Data-Phrasebook-Loader-DBI-0.02.tar.gz|1109782713
backpan|BARBIE|WWW-Scraper-ISBN-Yahoo_Driver|0.04|WWW-Scraper-ISBN-Yahoo_Driver-0.04.tar.gz|1109783204
backpan|BARBIE|CPAN-YACSmoke-Plugin-NNTP|0.01|CPAN-YACSmoke-Plugin-NNTP-0.01.tar.gz|1109784375
backpan|BARBIE|CPAN-YACSmoke-Plugin-NNTPWeb|0.01|CPAN-YACSmoke-Plugin-NNTPWeb-0.01.tar.gz|1109784592
backpan|BARBIE|CPAN-YACSmoke-Plugin-Outlook|0.02|CPAN-YACSmoke-Plugin-Outlook-0.02.tar.gz|1109784831
backpan|BARBIE|CPAN-YACSmoke-Plugin-WebList|0.02|CPAN-YACSmoke-Plugin-WebList-0.02.tar.gz|1109784957
backpan|BARBIE|WWW-Scraper-ISBN-Pearson_Driver|0.07|WWW-Scraper-ISBN-Pearson_Driver-0.07.tar.gz|1109786266
backpan|BARBIE|Finance-Currency-Convert-XE|0.08|Finance-Currency-Convert-XE-0.08.tar.gz|1109789653
backpan|BARBIE|Data-Phrasebook|0.19|Data-Phrasebook-0.19.tar.gz|1109810599
backpan|BARBIE|Data-Phrasebook-Loader-Ini|0.03|Data-Phrasebook-Loader-Ini-0.03.tar.gz|1109810726
backpan|BARBIE|Data-Phrasebook-Loader-XML|0.03|Data-Phrasebook-Loader-XML-0.03.tar.gz|1109810840
backpan|BARBIE|Data-Phrasebook-Loader-YAML|0.03|Data-Phrasebook-Loader-YAML-0.03.tar.gz|1109810856
backpan|BARBIE|Calendar-List|0.16|Calendar-List-0.16.tar.gz|1109852054
backpan|BARBIE|CPAN-YACSmoke-Plugin-NNTP|0.03|CPAN-YACSmoke-Plugin-NNTP-0.03.tar.gz|1109853394
backpan|BARBIE|CPAN-YACSmoke-Plugin-NNTPWeb|0.03|CPAN-YACSmoke-Plugin-NNTPWeb-0.03.tar.gz|1109854125
backpan|BARBIE|CPAN-YACSmoke-Plugin-Outlook|0.03|CPAN-YACSmoke-Plugin-Outlook-0.03.tar.gz|1109854616
backpan|BARBIE|CPAN-YACSmoke-Plugin-WebList|0.03|CPAN-YACSmoke-Plugin-WebList-0.03.tar.gz|1109855012
backpan|BARBIE|Data-Phrasebook|0.20|Data-Phrasebook-0.20.tar.gz|1109875073
backpan|BARBIE|Data-Phrasebook-Loader-DBI|0.03|Data-Phrasebook-Loader-DBI-0.03.tar.gz|1109947900
backpan|BARBIE|Data-Phrasebook-Loader-Ini|0.04|Data-Phrasebook-Loader-Ini-0.04.tar.gz|1109950136
backpan|BARBIE|Data-Phrasebook-Loader-XML|0.04|Data-Phrasebook-Loader-XML-0.04.tar.gz|1109950378
backpan|BARBIE|Data-Phrasebook-Loader-YAML|0.04|Data-Phrasebook-Loader-YAML-0.04.tar.gz|1109951098
backpan|BARBIE|Finance-Currency-Convert-XE|0.09|Finance-Currency-Convert-XE-0.09.tar.gz|1109952899
backpan|BARBIE|Games-Trackword|1.03|Games-Trackword-1.03.tar.gz|1111314729
backpan|BARBIE|Mail-File|0.06|Mail-File-0.06.tar.gz|1111314962
backpan|BARBIE|Games-Trackword|1.04|Games-Trackword-1.04.tar.gz|1111441853
cpan|BARBIE|Mail-File|0.07|Mail-File-0.07.tar.gz|1111443311
backpan|BARBIE|Regexp-Log-Common|0.03|Regexp-Log-Common-0.03.tar.gz|1111451950
backpan|BARBIE|Data-Phrasebook-Loader-DBI|0.04|Data-Phrasebook-Loader-DBI-0.04.tar.gz|1111924579
backpan|BARBIE|Data-Phrasebook-Loader-Ini|0.05|Data-Phrasebook-Loader-Ini-0.05.tar.gz|1111924597
backpan|BARBIE|Data-Phrasebook-Loader-XML|0.05|Data-Phrasebook-Loader-XML-0.05.tar.gz|1111924614
backpan|BARBIE|Data-Phrasebook-Loader-YAML|0.05|Data-Phrasebook-Loader-YAML-0.05.tar.gz|1111924630
cpan|BARBIE|CPAN-YACSmoke-Plugin-NNTP|0.04|CPAN-YACSmoke-Plugin-NNTP-0.04.tar.gz|1111957129
backpan|BARBIE|CPAN-YACSmoke-Plugin-NNTPWeb|0.04|CPAN-YACSmoke-Plugin-NNTPWeb-0.04.tar.gz|1111957152
backpan|BARBIE|CPAN-YACSmoke-Plugin-Outlook|0.04|CPAN-YACSmoke-Plugin-Outlook-0.04.tar.gz|1111957169
backpan|BARBIE|CPAN-YACSmoke-Plugin-WebList|0.04|CPAN-YACSmoke-Plugin-WebList-0.04.tar.gz|1111957187
backpan|BARBIE|Mail-Outlook|0.07|Mail-Outlook-0.07.tar.gz|1111957205
cpan|BARBIE|CPAN-YACSmoke-Plugin-Outlook|0.05|CPAN-YACSmoke-Plugin-Outlook-0.05.tar.gz|1112117437
backpan|BARBIE|Mail-Outlook|0.08|Mail-Outlook-0.08.tar.gz|1112117548
backpan|BARBIE|WWW-UsePerl-Journal|0.12|WWW-UsePerl-Journal-0.12.tar.gz|1113833446
backpan|BARBIE|WWW-UsePerl-Journal-Thread|0.08|WWW-UsePerl-Journal-Thread-0.08.tar.gz|1113834037
backpan|BARBIE|Finance-Currency-Convert-XE|0.10|Finance-Currency-Convert-XE-0.10.tar.gz|1114616254
cpan|BARBIE|Regexp-Log-Common|0.04|Regexp-Log-Common-0.04.tar.gz|1114696798
backpan|BARBIE|Data-Phrasebook|0.21|Data-Phrasebook-0.21.tar.gz|1116524830
backpan|BARBIE|Data-Phrasebook-Loader-XML|0.06|Data-Phrasebook-Loader-XML-0.06.tar.gz|1116525721
backpan|BARBIE|Data-Phrasebook|0.22|Data-Phrasebook-0.22.tar.gz|1118772551
backpan|BARBIE|Data-Phrasebook-Loader-DBI|0.05|Data-Phrasebook-Loader-DBI-0.05.tar.gz|1118773446
backpan|BARBIE|Data-Phrasebook-Loader-Ini|0.06|Data-Phrasebook-Loader-Ini-0.06.tar.gz|1118773467
backpan|BARBIE|Data-Phrasebook-Loader-XML|0.07|Data-Phrasebook-Loader-XML-0.07.tar.gz|1118773813
backpan|BARBIE|Data-Phrasebook-Loader-Ini|0.07|Data-Phrasebook-Loader-Ini-0.07.tar.gz|1118831681
backpan|BARBIE|Data-Phrasebook-Loader-DBI|0.06|Data-Phrasebook-Loader-DBI-0.06.tar.gz|1118832704
backpan|BARBIE|Data-Phrasebook-Loader-XML|0.08|Data-Phrasebook-Loader-XML-0.08.tar.gz|1118833293
backpan|BARBIE|Data-Phrasebook-Loader-DBI|0.07|Data-Phrasebook-Loader-DBI-0.07.tar.gz|1118942666
backpan|BARBIE|WWW-UsePerl-Journal|0.13|WWW-UsePerl-Journal-0.13.tar.gz|1122331214
backpan|BARBIE|Mail-Outlook|0.09|Mail-Outlook-0.09.tar.gz|1123623051
backpan|BARBIE|Data-Phrasebook|0.23|Data-Phrasebook-0.23.tar.gz|1123627272
backpan|BARBIE|Data-Phrasebook-Loader-Ini|0.08|Data-Phrasebook-Loader-Ini-0.08.tar.gz|1123627406
backpan|BARBIE|Data-Phrasebook-Loader-XML|0.09|Data-Phrasebook-Loader-XML-0.09.tar.gz|1123628691
backpan|BARBIE|WWW-Scraper-ISBN-ORA_Driver|0.06|WWW-Scraper-ISBN-ORA_Driver-0.06.tar.gz|1126531570
backpan|BARBIE|Data-Phrasebook|0.24|Data-Phrasebook-0.24.tar.gz|1127399856
backpan|BARBIE|Data-Phrasebook-Loader-XML|0.10|Data-Phrasebook-Loader-XML-0.10.tar.gz|1127399981
backpan|BARBIE|Data-Phrasebook-Loader-DBI|0.08|Data-Phrasebook-Loader-DBI-0.08.tar.gz|1127400110
backpan|BARBIE|WWW-UsePerl-Journal|0.14|WWW-UsePerl-Journal-0.14.tar.gz|1127430308
backpan|BARBIE|Calendar-List|0.17|Calendar-List-0.17.tar.gz|1132333628
backpan|BARBIE|Data-Phrasebook|0.25|Data-Phrasebook-0.25.tar.gz|1132699691
backpan|BARBIE|Data-Phrasebook|0.26|Data-Phrasebook-0.26.tar.gz|1159480403
backpan|BARBIE|Data-Phrasebook-Loader-YAML|0.06|Data-Phrasebook-Loader-YAML-0.06.tar.gz|1159480793
backpan|BARBIE|Mail-Outlook|0.10|Mail-Outlook-0.10.tar.gz|1159534191
backpan|BARBIE|Finance-Currency-Convert-XE|0.11|Finance-Currency-Convert-XE-0.11.tar.gz|1160570538
backpan|BARBIE|WWW-Scraper-ISBN-ORA_Driver|0.07|WWW-Scraper-ISBN-ORA_Driver-0.07.tar.gz|1160573459
backpan|BARBIE|WWW-Scraper-ISBN-Amazon_Driver|0.06|WWW-Scraper-ISBN-Amazon_Driver-0.06.tar.gz|1160580593
backpan|BARBIE|Data-Phrasebook|0.27|Data-Phrasebook-0.27.tar.gz|1172162616
backpan|BARBIE|Data-Phrasebook-Loader-YAML|0.07|Data-Phrasebook-Loader-YAML-0.07.tar.gz|1172165476
cpan|BARBIE|Data-Phrasebook-Loader-YAML|0.08|Data-Phrasebook-Loader-YAML-0.08.tar.gz|1172166133
backpan|BARBIE|Data-Phrasebook-Loader-DBI|0.09|Data-Phrasebook-Loader-DBI-0.09.tar.gz|1172166606
cpan|BARBIE|Data-Phrasebook-Loader-DBI|0.10|Data-Phrasebook-Loader-DBI-0.10.tar.gz|1172167080
cpan|BARBIE|Data-Phrasebook-Loader-Ini|0.09|Data-Phrasebook-Loader-Ini-0.09.tar.gz|1172167281
cpan|BARBIE|Data-Phrasebook-Loader-XML|0.11|Data-Phrasebook-Loader-XML-0.11.tar.gz|1172167763
backpan|BARBIE|Test-YAML-Meta|0.01|Test-YAML-Meta-0.01.tar.gz|1172579235
backpan|BARBIE|Test-YAML-Meta|0.02|Test-YAML-Meta-0.02.tar.gz|1172586866
backpan|BARBIE|Test-YAML-Meta|0.03|Test-YAML-Meta-0.03.tar.gz|1172734912
cpan|BARBIE|Data-Phrasebook-Loader-DBI|0.11|Data-Phrasebook-Loader-DBI-0.11.tar.gz|1172753895
cpan|BARBIE|Data-Phrasebook|0.28|Data-Phrasebook-0.28.tar.gz|1172754966
cpan|BARBIE|Data-Phrasebook-Loader-Ini|0.10|Data-Phrasebook-Loader-Ini-0.10.tar.gz|1172755893
cpan|BARBIE|Data-Phrasebook-Loader-XML|0.12|Data-Phrasebook-Loader-XML-0.12.tar.gz|1172756091
cpan|BARBIE|Data-Phrasebook-Loader-YAML|0.09|Data-Phrasebook-Loader-YAML-0.09.tar.gz|1172756473
backpan|BARBIE|WWW-Scraper-ISBN-Yahoo_Driver|0.05|WWW-Scraper-ISBN-Yahoo_Driver-0.05.tar.gz|1172762116
backpan|BARBIE|WWW-Scraper-ISBN-ORA_Driver|0.08|WWW-Scraper-ISBN-ORA_Driver-0.08.tar.gz|1172772309
backpan|BARBIE|WWW-Scraper-ISBN-Pearson_Driver|0.08|WWW-Scraper-ISBN-Pearson_Driver-0.08.tar.gz|1172783844
backpan|BARBIE|Calendar-List|0.18|Calendar-List-0.18.tar.gz|1172838795
cpan|BARBIE|Mail-File|0.08|Mail-File-0.08.tar.gz|1172838898
cpan|BARBIE|Regexp-Log-Common|0.05|Regexp-Log-Common-0.05.tar.gz|1172838993
cpan|BARBIE|Games-Trackword|1.05|Games-Trackword-1.05.tar.gz|1172840745
cpan|BARBIE|Data-Phrasebook|0.29|Data-Phrasebook-0.29.tar.gz|1172841682
backpan|BARBIE|Finance-Currency-Convert-XE|0.12|Finance-Currency-Convert-XE-0.12.tar.gz|1172845201
backpan|BARBIE|Finance-Currency-Convert-XE|0.13|Finance-Currency-Convert-XE-0.13.tar.gz|1173281194
backpan|BARBIE|WWW-Scraper-ISBN-Amazon_Driver|0.07|WWW-Scraper-ISBN-Amazon_Driver-0.07.tar.gz|1173699827
cpan|BARBIE|CPAN-YACSmoke-Plugin-Outlook|0.06|CPAN-YACSmoke-Plugin-Outlook-0.06.tar.gz|1173717440
cpan|BARBIE|CPAN-YACSmoke-Plugin-WebList|0.05|CPAN-YACSmoke-Plugin-WebList-0.05.tar.gz|1173717735
cpan|BARBIE|CPAN-YACSmoke-Plugin-NNTP|0.05|CPAN-YACSmoke-Plugin-NNTP-0.05.tar.gz|1173718960
backpan|BARBIE|WWW-UsePerl-Journal|0.15|WWW-UsePerl-Journal-0.15.tar.gz|1173720630
backpan|BARBIE|CPAN-YACSmoke-Plugin-NNTPWeb|0.05|CPAN-YACSmoke-Plugin-NNTPWeb-0.05.tar.gz|1173721473
cpan|BARBIE|CPAN-YACSmoke-Plugin-NNTPWeb|0.06|CPAN-YACSmoke-Plugin-NNTPWeb-0.06.tar.gz|1173724460
backpan|BARBIE|WWW-Scraper-ISBN-Amazon_Driver|0.08|WWW-Scraper-ISBN-Amazon_Driver-0.08.tar.gz|1173784049
backpan|BARBIE|WWW-UsePerl-Journal|0.16|WWW-UsePerl-Journal-0.16.tar.gz|1173873971
backpan|BARBIE|Mail-Outlook|0.11|Mail-Outlook-0.11.tar.gz|1178212964
backpan|BARBIE|Mail-Outlook|0.12|Mail-Outlook-0.12.tar.gz|1178271830
backpan|BARBIE|Mail-Outlook|0.13|Mail-Outlook-0.13.tar.gz|1178692880
backpan|BARBIE|Test-YAML-Meta|0.04|Test-YAML-Meta-0.04.tar.gz|1179227427
backpan|BARBIE|GD-Chart-Radial|0.02|GD-Chart-Radial-0.02.tar.gz|1181572678
backpan|BARBIE|GD-Chart-Radial|0.03|GD-Chart-Radial-0.03.tar.gz|1181572878
backpan|BARBIE|GD-Chart-Radial|0.04|GD-Chart-Radial-0.04.tar.gz|1181638618
backpan|BARBIE|WWW-Scraper-ISBN-Amazon_Driver|0.09|WWW-Scraper-ISBN-Amazon_Driver-0.09.tar.gz|1185458977
backpan|BARBIE|WWW-Scraper-ISBN-Pearson_Driver|0.09|WWW-Scraper-ISBN-Pearson_Driver-0.09.tar.gz|1185461104
backpan|BARBIE|WWW-Scraper-ISBN-Yahoo_Driver|0.06|WWW-Scraper-ISBN-Yahoo_Driver-0.06.tar.gz|1185466944
backpan|BARBIE|WWW-Scraper-ISBN-Amazon_Driver|0.10|WWW-Scraper-ISBN-Amazon_Driver-0.10.tar.gz|1185554405
backpan|BARBIE|WWW-Scraper-ISBN-Amazon_Driver|0.11|WWW-Scraper-ISBN-Amazon_Driver-0.11.tar.gz|1193657661
cpan|BARBIE|Finance-Currency-Convert-XE|0.14|Finance-Currency-Convert-XE-0.14.tar.gz|1193676553
backpan|BARBIE|GD-Chart-Radial|0.05|GD-Chart-Radial-0.05.tar.gz|1193843844
backpan|BARBIE|WWW-UsePerl-Journal|0.17|WWW-UsePerl-Journal-0.17.tar.gz|1193846046
cpan|BARBIE|GD-Chart-Radial|0.06|GD-Chart-Radial-0.06.tar.gz|1193854727
cpan|BARBIE|GD-Chart-Radial|0.07|GD-Chart-Radial-0.07.tar.gz|1194000443
backpan|BARBIE|Test-YAML-Meta|0.05|Test-YAML-Meta-0.05.tar.gz|1194001957
backpan|BARBIE|WWW-UsePerl-Journal|0.18|WWW-UsePerl-Journal-0.18.tar.gz|1194211923
backpan|BARBIE|WWW-UsePerl-Journal|0.19|WWW-UsePerl-Journal-0.19.tar.gz|1194286391
backpan|BARBIE|WWW-UsePerl-Journal-Thread|0.09|WWW-UsePerl-Journal-Thread-0.09.tar.gz|1194306265
backpan|BARBIE|Test-YAML-Meta|0.06|Test-YAML-Meta-0.06.tar.gz|1194307863
backpan|BARBIE|WWW-UsePerl-Journal|0.20|WWW-UsePerl-Journal-0.20.tar.gz|1194438403
backpan|BARBIE|WWW-UsePerl-Journal|0.21|WWW-UsePerl-Journal-0.21.tar.gz|1194527847
backpan|BARBIE|WWW-UsePerl-Journal-Thread|0.10|WWW-UsePerl-Journal-Thread-0.10.tar.gz|1194535813
backpan|BARBIE|Test-CPAN-Meta|0.07|Test-CPAN-Meta-0.07.tar.gz|1199974670
backpan|BARBIE|Data-FormValidator-Constraints-Words|0.01|Data-FormValidator-Constraints-Words-0.01.tar.gz|1200827357
backpan|BARBIE|Data-FormValidator-Constraints-Words|0.02|Data-FormValidator-Constraints-Words-0.02.tar.gz|1200828889
backpan|BARBIE|Test-YAML-Meta|0.07|Test-YAML-Meta-0.07.tar.gz|1205761883
backpan|BARBIE|Test-CPAN-Meta|0.08|Test-CPAN-Meta-0.08.tar.gz|1205761970
backpan|BARBIE|Test-YAML-Meta|0.08|Test-YAML-Meta-0.08.tar.gz|1205762308
backpan|BARBIE|Test-CPAN-Meta|0.09|Test-CPAN-Meta-0.09.tar.gz|1205762479
cpan|BARBIE|Finance-Currency-Convert-XE|0.15|Finance-Currency-Convert-XE-0.15.tar.gz|1205771511
backpan|BARBIE|Calendar-List|0.19|Calendar-List-0.19.tar.gz|1205969619
backpan|BARBIE|Calendar-List|0.20|Calendar-List-0.20.tar.gz|1206822313
backpan|BARBIE|Test-CPAN-Meta|0.10|Test-CPAN-Meta-0.10.tar.gz|1206822567
backpan|BARBIE|Test-YAML-Meta|0.09|Test-YAML-Meta-0.09.tar.gz|1206822655
cpan|BARBIE|Data-FormValidator-Constraints-Words|0.03|Data-FormValidator-Constraints-Words-0.03.tar.gz|1206822667
backpan|BARBIE|Test-CPAN-Meta|0.11|Test-CPAN-Meta-0.11.tar.gz|1212417033
backpan|BARBIE|Test-YAML-Meta|0.10|Test-YAML-Meta-0.10.tar.gz|1212417119
cpan|BARBIE|Games-Trackword|1.06|Games-Trackword-1.06.tar.gz|1212417962
cpan|BARBIE|Calendar-List|0.21|Calendar-List-0.21.tar.gz|1212419186
backpan|BARBIE|Test-YAML-Meta|0.11|Test-YAML-Meta-0.11.tar.gz|1214570238
backpan|BARBIE|Test-CPAN-Meta|0.12|Test-CPAN-Meta-0.12.tar.gz|1214570325
backpan|BARBIE|WWW-Scraper-ISBN-Amazon_Driver|0.12|WWW-Scraper-ISBN-Amazon_Driver-0.12.tar.gz|1214577880
backpan|BARBIE|WWW-Scraper-ISBN-ORA_Driver|0.09|WWW-Scraper-ISBN-ORA_Driver-0.09.tar.gz|1214580873
cpan|BARBIE|WWW-Scraper-ISBN-Pearson_Driver|0.10|WWW-Scraper-ISBN-Pearson_Driver-0.10.tar.gz|1214581796
backpan|BARBIE|WWW-Scraper-ISBN-Yahoo_Driver|0.07|WWW-Scraper-ISBN-Yahoo_Driver-0.07.tar.gz|1214584248
backpan|BARBIE|WWW-Scraper-ISBN-Amazon_Driver|0.13|WWW-Scraper-ISBN-Amazon_Driver-0.13.tar.gz|1214586094
backpan|BARBIE|CPAN-WWW-Testers-Generator|0.23|CPAN-WWW-Testers-Generator-0.23.tar.gz|1219069465
backpan|BARBIE|CPAN-WWW-Testers-Generator|0.24|CPAN-WWW-Testers-Generator-0.24.tar.gz|1219141890
backpan|BARBIE|CPAN-WWW-Testers-Generator|0.25|CPAN-WWW-Testers-Generator-0.25.tar.gz|1220007085
backpan|BARBIE|CPAN-WWW-Testers-Generator|0.26|CPAN-WWW-Testers-Generator-0.26.tar.gz|1220390397
backpan|BARBIE|CPAN-Testers-WWW-Statistics|0.48|CPAN-Testers-WWW-Statistics-0.48.tar.gz|1220400212
backpan|BARBIE|CPAN-WWW-Testers-Generator|0.27|CPAN-WWW-Testers-Generator-0.27.tar.gz|1221123407
backpan|BARBIE|Parse-CPAN-Distributions|0.01|Parse-CPAN-Distributions-0.01.tar.gz|1221237175
backpan|BARBIE|Parse-CPAN-Distributions|0.02|Parse-CPAN-Distributions-0.02.tar.gz|1221483975
backpan|BARBIE|Parse-CPAN-Distributions|0.03|Parse-CPAN-Distributions-0.03.tar.gz|1221490217
cpan|BARBIE|Parse-CPAN-Distributions|0.04|Parse-CPAN-Distributions-0.04.tar.gz|1221642127
backpan|BARBIE|CPAN-WWW-Testers-Generator|0.28|CPAN-WWW-Testers-Generator-0.28.tar.gz|1221745622
backpan|BARBIE|CPAN-Testers-WWW-Statistics|0.49|CPAN-Testers-WWW-Statistics-0.49.tar.gz|1221745708
cpan|BARBIE|Mail-Outlook|0.14|Mail-Outlook-0.14.tar.gz|1221757181
cpan|BARBIE|Parse-CPAN-Distributions|0.05|Parse-CPAN-Distributions-0.05.tar.gz|1221814104
cpan|BARBIE|CPAN-WWW-Testers-Generator|0.29|CPAN-WWW-Testers-Generator-0.29.tar.gz|1221817801
backpan|BARBIE|CPAN-WWW-Testers|0.34|CPAN-WWW-Testers-0.34.tar.gz|1221830335
backpan|BARBIE|CPAN-Testers-WWW-Statistics|0.50|CPAN-Testers-WWW-Statistics-0.50.tar.gz|1222432675
backpan|BARBIE|CPAN-WWW-Testers|0.35|CPAN-WWW-Testers-0.35.tar.gz|1222612670
cpan|BARBIE|WWW-UsePerl-Journal|0.22|WWW-UsePerl-Journal-0.22.tar.gz|1222694640
cpan|BARBIE|WWW-UsePerl-Journal-Thread|0.11|WWW-UsePerl-Journal-Thread-0.11.tar.gz|1222724723
cpan|BARBIE|WWW-UsePerl-Journal-Thread|0.12|WWW-UsePerl-Journal-Thread-0.12.tar.gz|1222771326
backpan|BARBIE|CPAN-Testers-WWW-Statistics|0.51|CPAN-Testers-WWW-Statistics-0.51.tar.gz|1222884942
cpan|BARBIE|CPAN-WWW-Testers-Generator|0.30|CPAN-WWW-Testers-Generator-0.30.tar.gz|1222885029
backpan|BARBIE|CPAN-Testers-WWW-Statistics|0.52|CPAN-Testers-WWW-Statistics-0.52.tar.gz|1223632601
backpan|BARBIE|CPAN-WWW-Testers|0.36|CPAN-WWW-Testers-0.36.tar.gz|1224245979
backpan|BARBIE|CPAN-WWW-Testers|0.37|CPAN-WWW-Testers-0.37.tar.gz|1226932740
backpan|BARBIE|WWW-Scraper-ISBN-Yahoo_Driver|0.08|WWW-Scraper-ISBN-Yahoo_Driver-0.08.tar.gz|1226932860
cpan|BARBIE|WWW-Scraper-ISBN-Amazon_Driver|0.14|WWW-Scraper-ISBN-Amazon_Driver-0.14.tar.gz|1226933400
backpan|BARBIE|CPAN-Testers-Common-DBUtils|0.01|CPAN-Testers-Common-DBUtils-0.01.tar.gz|1229250471
backpan|BARBIE|CPAN-Testers-WWW-Reports-Mailer|0.08|CPAN-Testers-WWW-Reports-Mailer-0.08.tar.gz|1229255359
backpan|BARBIE|CPAN-Testers-Common-DBUtils|0.02|CPAN-Testers-Common-DBUtils-0.02.tar.gz|1229354055
cpan|BARBIE|CPAN-Testers-Common-DBUtils|0.03|CPAN-Testers-Common-DBUtils-0.03.tar.gz|1229515740
backpan|BARBIE|CPAN-Testers-WWW-Reports-Mailer|0.09|CPAN-Testers-WWW-Reports-Mailer-0.09.tar.gz|1229519160
backpan|BARBIE|CPAN-Testers-WWW-Reports-Mailer|0.10|CPAN-Testers-WWW-Reports-Mailer-0.10.tar.gz|1229519280
backpan|BARBIE|CPAN-Testers-Data-Generator|0.31|CPAN-Testers-Data-Generator-0.31.tar.gz|1229629380
backpan|BARBIE|CPAN-Testers-Data-Generator|0.32|CPAN-Testers-Data-Generator-0.32.tar.gz|1229690640
backpan|BARBIE|CPAN-WWW-Testers|0.39|CPAN-WWW-Testers-0.39.tar.gz|1230501112
backpan|BARBIE|CPAN-Testers-Data-Generator|0.33|CPAN-Testers-Data-Generator-0.33.tar.gz|1230577890
backpan|BARBIE|CPAN-WWW-Testers|0.40|CPAN-WWW-Testers-0.40.tar.gz|1230843300
backpan|BARBIE|CPAN-WWW-Testers|0.41|CPAN-WWW-Testers-0.41.tar.gz|1231365094
backpan|BARBIE|CPAN-WWW-Testers|0.42|CPAN-WWW-Testers-0.42.tar.gz|1231510380
backpan|BARBIE|CPAN-Testers-Data-Generator|0.34|CPAN-Testers-Data-Generator-0.34.tar.gz|1231762213
backpan|BARBIE|CPAN-Testers-WWW-Statistics|0.54|CPAN-Testers-WWW-Statistics-0.54.tar.gz|1231763890
backpan|BARBIE|CPAN-WWW-Testers|0.43|CPAN-WWW-Testers-0.43.tar.gz|1231884840
backpan|BARBIE|CPAN-Testers-WWW-Reports-Mailer|0.11|CPAN-Testers-WWW-Reports-Mailer-0.11.tar.gz|1232315520
backpan|BARBIE|CPAN-Testers-WWW-Reports-Mailer|0.12|CPAN-Testers-WWW-Reports-Mailer-0.12.tar.gz|1232367180
backpan|BARBIE|CPAN-WWW-Testers|0.44|CPAN-WWW-Testers-0.44.tar.gz|1232367840
backpan|BARBIE|CPAN-Testers-WWW-Reports-Mailer|0.13|CPAN-Testers-WWW-Reports-Mailer-0.13.tar.gz|1232395680
backpan|BARBIE|CPAN-Testers-WWW-Statistics|0.55|CPAN-Testers-WWW-Statistics-0.55.tar.gz|1232486280
backpan|BARBIE|CPAN-WWW-Testers|0.45|CPAN-WWW-Testers-0.45.tar.gz|1232631540
backpan|BARBIE|CPAN-WWW-Testers|0.46|CPAN-WWW-Testers-0.46.tar.gz|1232632560
backpan|BARBIE|CPAN-Testers-WWW-Statistics|0.56|CPAN-Testers-WWW-Statistics-0.56.tar.gz|1232905020
backpan|BARBIE|CPAN-Testers-WWW-Statistics|0.57|CPAN-Testers-WWW-Statistics-0.57.tar.gz|1232917140
backpan|BARBIE|CPAN-Testers-WWW-Statistics|0.58|CPAN-Testers-WWW-Statistics-0.58.tar.gz|1232965320
backpan|BARBIE|CPAN-Testers-WWW-Reports-Mailer|0.14|CPAN-Testers-WWW-Reports-Mailer-0.14.tar.gz|1233232260
backpan|BARBIE|CPAN-Testers-Data-Generator|0.35|CPAN-Testers-Data-Generator-0.35.tar.gz|1233235320
backpan|BARBIE|CPAN-Testers-WWW-Statistics|0.59|CPAN-Testers-WWW-Statistics-0.59.tar.gz|1233321660
backpan|BARBIE|CPAN-Testers-WWW-Statistics|0.60|CPAN-Testers-WWW-Statistics-0.60.tar.gz|1233577985
backpan|BARBIE|CPAN-WWW-Testers|0.47|CPAN-WWW-Testers-0.47.tar.gz|1233592502
cpan|BARBIE|CPAN-WWW-Testers|0.48|CPAN-WWW-Testers-0.48.tar.gz|1233610207
cpan|BARBIE|Mail-Outlook|0.15|Mail-Outlook-0.15.tar.gz|1234310220
backpan|BARBIE|CPAN-Testers-Common-Article|0.36|CPAN-Testers-Common-Article-0.36.tar.gz|1234445700
backpan|BARBIE|CPAN-Testers-Data-Uploads|0.04|CPAN-Testers-Data-Uploads-0.04.tar.gz|1234527420
backpan|BARBIE|App-Maisha|0.01|App-Maisha-0.01.tar.gz|1234540080
backpan|BARBIE|App-Maisha|0.02|App-Maisha-0.02.tar.gz|1234613700
backpan|BARBIE|App-Maisha|0.03|App-Maisha-0.03.tar.gz|1234637100
backpan|BARBIE|CPAN-Testers-Data-Uploads|0.05|CPAN-Testers-Data-Uploads-0.05.tar.gz|1234688340
backpan|BARBIE|CPAN-Testers-Data-Uploads|0.06|CPAN-Testers-Data-Uploads-0.06.tar.gz|1234715460
backpan|BARBIE|App-Maisha|0.04|App-Maisha-0.04.tar.gz|1234716120
backpan|BARBIE|CPAN-Testers-Data-Generator|0.36|CPAN-Testers-Data-Generator-0.36.tar.gz|1234786140
cpan|BARBIE|CPAN-WWW-Testers|0.49|CPAN-WWW-Testers-0.49.tar.gz|1234786620
backpan|BARBIE|App-Maisha|0.05|App-Maisha-0.05.tar.gz|1234790520
backpan|BARBIE|App-Maisha|0.06|App-Maisha-0.06.tar.gz|1234794600
cpan|BARBIE|App-Maisha-Plugin-PingFM|0.01|App-Maisha-Plugin-PingFM-0.01.tar.gz|1234800960
backpan|BARBIE|App-Maisha|0.07|App-Maisha-0.07.tar.gz|1234869120
backpan|BARBIE|App-Maisha|0.08|App-Maisha-0.08.tar.gz|1234876020
backpan|BARBIE|App-Maisha|0.09|App-Maisha-0.09.tar.gz|1234885080
cpan|BARBIE|App-Maisha-Plugin-PingFM|0.02|App-Maisha-Plugin-PingFM-0.02.tar.gz|1234885380
backpan|BARBIE|App-Maisha|0.10|App-Maisha-0.10.tar.gz|1234885620
backpan|BARBIE|App-Maisha|0.11|App-Maisha-0.11.tar.gz|1234972140
cpan|BARBIE|App-Maisha|0.12|App-Maisha-0.12.tar.gz|1235740440
backpan|BARBIE|CPAN-Testers-WWW-Statistics|0.61|CPAN-Testers-WWW-Statistics-0.61.tar.gz|1237899180
backpan|BARBIE|CPAN-Testers-WWW-Statistics|0.62|CPAN-Testers-WWW-Statistics-0.62.tar.gz|1238144160
backpan|BARBIE|CPAN-Testers-WWW-Reports-Mailer|0.15|CPAN-Testers-WWW-Reports-Mailer-0.15.tar.gz|1238852975
backpan|BARBIE|CPAN-Testers-WWW-Reports-Mailer|0.16|CPAN-Testers-WWW-Reports-Mailer-0.16.tar.gz|1240510571
backpan|BARBIE|Test-YAML-Meta|0.12|Test-YAML-Meta-0.12.tar.gz|1243188450
backpan|BARBIE|Test-CPAN-Meta|0.13|Test-CPAN-Meta-0.13.tar.gz|1243188537
backpan|BARBIE|CPAN-Testers-WWW-Reports-Mailer|0.17|CPAN-Testers-WWW-Reports-Mailer-0.17.tar.gz|1244282381
backpan|BARBIE|CPAN-Testers-WWW-Statistics|0.64|CPAN-Testers-WWW-Statistics-0.64.tar.gz|1244284235
backpan|BARBIE|CPAN-Testers-WWW-Statistics|0.65|CPAN-Testers-WWW-Statistics-0.65.tar.gz|1244286761
backpan|BARBIE|CPAN-Testers-Data-Generator|0.37|CPAN-Testers-Data-Generator-0.37.tar.gz|1244364903
cpan|BARBIE|CPAN-Testers-Data-Release|0.01|CPAN-Testers-Data-Release-0.01.tar.gz|1244389664
cpan|BARBIE|CPAN-Testers-WWW-Reports-Parser|0.01|CPAN-Testers-WWW-Reports-Parser-0.01.tar.gz|1244470653
backpan|BARBIE|Test-JSON-Meta|0.01|Test-JSON-Meta-0.01.tar.gz|1247682480
cpan|BARBIE|CPAN-Testers-Data-Release|0.02|CPAN-Testers-Data-Release-0.02.tar.gz|1247766446
backpan|BARBIE|CPAN-Testers-Data-Uploads|0.07|CPAN-Testers-Data-Uploads-0.07.tar.gz|1247767897
