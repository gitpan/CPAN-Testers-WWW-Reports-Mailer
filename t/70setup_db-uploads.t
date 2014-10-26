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

is($ct, 207, "row count for uploads");

#select * from uploads where author in ('DCANTRELL') and released < unix_timestamp('2009-08-01 17:30:00') ORDER BY released;
# type|author|dist|version|filename|released
__DATA__
cpan|DCANTRELL|Data-Hexdumper|0.01|Data-Hexdumper-0.01.tar.gz|981721074
backpan|DCANTRELL|Pony|1.00|Pony-1.00.tar.gz|986304259
backpan|DCANTRELL|Pony|1.01|Pony-1.01.tar.gz|986377728
cpan|DCANTRELL|Tie-Scalar-Decay|1.0|Tie-Scalar-Decay-1.0.tar.gz|986912122
cpan|DCANTRELL|Tie-Scalar-Decay|1.1|Tie-Scalar-Decay-1.1.tar.gz|987002208
cpan|DCANTRELL|Tie-Scalar-Decay|1.1.1|Tie-Scalar-Decay-1.1.1.tar.gz|990483493
cpan|DCANTRELL|Tie-Hash-Rank|1.0.1|Tie-Hash-Rank-1.0.1.tar.gz|992462581
cpan|DCANTRELL|Acme-Pony|1.1.1|Acme-Pony-1.1.1.tar.gz|993046418
cpan|DCANTRELL|Acme-Pony|1.1.2|Acme-Pony-1.1.2.tar.gz|994748837
backpan|DCANTRELL|Tie-Hash-Transactional|1.0|Tie-Hash-Transactional-1.0.tar.gz|994749035
cpan|DCANTRELL|Acme-Licence|1.0|Acme-Licence-1.0.tar.gz|1032427132
cpan|DCANTRELL|Data-Hexdumper|1.0.1|Data-Hexdumper-1.0.1.tar.gz|1032525107
cpan|DCANTRELL|NestedMap|1.0|NestedMap-1.0.tar.gz|1056616457
cpan|DCANTRELL|File-Find-Rule-Permissions|1.0|File-Find-Rule-Permissions-1.0.tar.gz|1056886629
cpan|DCANTRELL|File-Find-Rule-Permissions|1.1|File-Find-Rule-Permissions-1.1.tar.gz|1058905418
cpan|DCANTRELL|Data-Hexdumper|1.1|Data-Hexdumper-1.1.tar.gz|1060520520
backpan|DCANTRELL|Tie-Hash-Longest|1.0|Tie-Hash-Longest-1.0.tar.gz|1061819051
backpan|DCANTRELL|Tie-Hash-Longest|1.0.reupload|Tie-Hash-Longest-1.0.reupload.tar.gz|1062011632
backpan|DCANTRELL|Tie-Hash-Longest|1.0.reupload-again-because-im-stupid|Tie-Hash-Longest-1.0.reupload-again-because-im-stupid.tar.gz|1062107800
cpan|DCANTRELL|Acme-Scurvy-Whoreson-BilgeRat|1.0|Acme-Scurvy-Whoreson-BilgeRat-1.0.tar.gz|1062542261
cpan|DCANTRELL|Games-Dice-Advanced|1.0|Games-Dice-Advanced-1.0.tar.gz|1066686629
cpan|DCANTRELL|Net-Random|1.0|Net-Random-1.0.tar.gz|1066854275
cpan|DCANTRELL|Scalar-Properties|0.11|Scalar-Properties-0.11.tar.gz|1067972487
cpan|DCANTRELL|Scalar-Properties|0.12|Scalar-Properties-0.12.tar.gz|1068377944
cpan|DCANTRELL|Sub-WrapPackages|1.0|Sub-WrapPackages-1.0.tar.gz|1068924433
cpan|DCANTRELL|Statistics-ChiSquare|0.5|Statistics-ChiSquare-0.5.tar.gz|1068995421
cpan|DCANTRELL|Tie-Hash-Longest|1.1|Tie-Hash-Longest-1.1.tar.gz|1069101730
cpan|DCANTRELL|Statistics-SerialCorrelation|1.0|Statistics-SerialCorrelation-1.0.tar.gz|1069411070
cpan|DCANTRELL|File-Find-Rule-Permissions|1.2|File-Find-Rule-Permissions-1.2.tar.gz|1071689957
cpan|DCANTRELL|Data-Compare|0.03|Data-Compare-0.03.tar.gz|1072192987
cpan|DCANTRELL|Data-Compare|0.04|Data-Compare-0.04.tar.gz|1072199851
cpan|DCANTRELL|Data-Compare|0.05|Data-Compare-0.05.tar.gz|1072823174
cpan|DCANTRELL|Data-Compare|0.06|Data-Compare-0.06.tar.gz|1073430592
cpan|DCANTRELL|Data-Compare|0.07|Data-Compare-0.07.tar.gz|1073503858
cpan|DCANTRELL|Data-Compare|0.08|Data-Compare-0.08.tar.gz|1074603077
cpan|DCANTRELL|Statistics-SerialCorrelation|1.1|Statistics-SerialCorrelation-1.1.tar.gz|1074882312
cpan|DCANTRELL|Data-Hexdumper|1.2|Data-Hexdumper-1.2.tar.gz|1077282031
cpan|DCANTRELL|Data-Compare|0.09|Data-Compare-0.09.tar.gz|1077570269
cpan|DCANTRELL|Data-Compare|0.1|Data-Compare-0.1.tar.gz|1079170436
cpan|DCANTRELL|Data-Compare|0.11|Data-Compare-0.11.tar.gz|1086204525
cpan|DCANTRELL|Class-CanBeA|1.0|Class-CanBeA-1.0.tar.gz|1089484228
backpan|DCANTRELL|Number-Phone|1.0|Number-Phone-1.0.tar.gz|1092847112
cpan|DCANTRELL|Net-Random|1.1|Net-Random-1.1.tar.gz|1094544633
backpan|DCANTRELL|Number-Phone|1.1|Number-Phone-1.1.tar.gz|1095284902
backpan|DCANTRELL|Number-Phone|1.2|Number-Phone-1.2.tar.gz|1095880689
backpan|DCANTRELL|Number-Phone|1.2001|Number-Phone-1.2001.tar.gz|1097691978
backpan|DCANTRELL|Number-Phone|1.3|Number-Phone-1.3.tar.gz|1098306440
cpan|DCANTRELL|Acme-Scurvy-Whoreson-BilgeRat|1.1|Acme-Scurvy-Whoreson-BilgeRat-1.1.tar.gz|1098737924
cpan|DCANTRELL|Data-Transactional|0.1|Data-Transactional-0.1.tar.gz|1099778734
cpan|DCANTRELL|Data-Compare|0.12|Data-Compare-0.12.tar.gz|1100025324
cpan|DCANTRELL|Data-Compare|0.13|Data-Compare-0.13.tar.gz|1100027176
backpan|DCANTRELL|Number-Phone|1.3001|Number-Phone-1.3001.tar.gz|1100128236
backpan|DCANTRELL|Number-Phone|1.3002|Number-Phone-1.3002.tar.gz|1101468660
backpan|DCANTRELL|Number-Phone|1.3003|Number-Phone-1.3003.tar.gz|1102275519
cpan|DCANTRELL|Class-CanBeA|1.1|Class-CanBeA-1.1.tar.gz|1103584854
backpan|DCANTRELL|Number-Phone|1.3004|Number-Phone-1.3004.tar.gz|1113322835
backpan|DCANTRELL|Number-Phone|1.4|Number-Phone-1.4.tar.gz|1116442438
backpan|DCANTRELL|Number-Phone|1.4001|Number-Phone-1.4001.tar.gz|1119910474
backpan|DCANTRELL|Number-Phone|1.4002|Number-Phone-1.4002.tar.gz|1122989620
backpan|DCANTRELL|Number-Phone|1.4003|Number-Phone-1.4003.tar.gz|1124835694
backpan|DCANTRELL|Number-Phone|1.4004|Number-Phone-1.4004.tar.gz|1129043740
backpan|DCANTRELL|Number-Phone|1.5|Number-Phone-1.5.tar.gz|1129469742
cpan|DCANTRELL|Net-Random|1.2|Net-Random-1.2.tar.gz|1134513085
cpan|DCANTRELL|Class-CanBeA|1.2|Class-CanBeA-1.2.tar.gz|1135721806
cpan|DCANTRELL|File-Overwrite|1.0|File-Overwrite-1.0.tar.gz|1138552581
cpan|DCANTRELL|Tie-STDOUT|1.0|Tie-STDOUT-1.0.tar.gz|1151962399
cpan|DCANTRELL|Tie-STDOUT|1.01|Tie-STDOUT-1.01.tar.gz|1151963730
cpan|DCANTRELL|Tie-STDOUT|1.02|Tie-STDOUT-1.02.tar.gz|1152105583
cpan|DCANTRELL|Sub-WrapPackages|1.1|Sub-WrapPackages-1.1.tar.gz|1153898117
cpan|DCANTRELL|Sub-WrapPackages|1.2|Sub-WrapPackages-1.2.tar.gz|1154526137
backpan|DCANTRELL|Number-Phone|1.51|Number-Phone-1.51.tar.gz|1156284339
backpan|DCANTRELL|Number-Phone|1.52|Number-Phone-1.52.tar.gz|1156367623
backpan|DCANTRELL|Number-Phone|1.53|Number-Phone-1.53.tar.gz|1156371714
backpan|DCANTRELL|Number-Phone-UK-DetailedLocations|1.0|Number-Phone-UK-DetailedLocations-1.0.tar.gz|1156371736
backpan|DCANTRELL|Number-Phone|1.54|Number-Phone-1.54.tar.gz|1156428530
backpan|DCANTRELL|Number-Phone-UK-DetailedLocations|1.1|Number-Phone-UK-DetailedLocations-1.1.tar.gz|1156429572
backpan|DCANTRELL|Number-Phone|1.55|Number-Phone-1.55.tar.gz|1156464933
backpan|DCANTRELL|Number-Phone-UK-DetailedLocations|1.2|Number-Phone-UK-DetailedLocations-1.2.tar.gz|1156465243
cpan|DCANTRELL|Games-Dice-Advanced|1.1|Games-Dice-Advanced-1.1.tar.gz|1158083466
cpan|DCANTRELL|Data-Compare|0.14|Data-Compare-0.14.tar.gz|1162396199
backpan|DCANTRELL|Number-Phone|1.56|Number-Phone-1.56.tar.gz|1165925883
cpan|DCANTRELL|Bryar|3.0|Bryar-3.0.tar.gz|1169304931
cpan|DCANTRELL|Net-Random|1.3|Net-Random-1.3.tar.gz|1169334966
cpan|DCANTRELL|XML-Tiny|1.0|XML-Tiny-1.0.tar.gz|1169821411
cpan|DCANTRELL|XML-Tiny|1.01|XML-Tiny-1.01.tar.gz|1170112615
cpan|DCANTRELL|XML-Tiny|1.02|XML-Tiny-1.02.tar.gz|1170197768
cpan|DCANTRELL|XML-Tiny|1.03|XML-Tiny-1.03.tar.gz|1170470907
cpan|DCANTRELL|XML-Tiny|1.04|XML-Tiny-1.04.tar.gz|1171203686
backpan|DCANTRELL|Number-Phone|1.5601|Number-Phone-1.5601.tar.gz|1172324808
cpan|DCANTRELL|Data-Compare|0.15|Data-Compare-0.15.tar.gz|1172435898
cpan|DCANTRELL|Data-Compare|0.16|Data-Compare-0.16.tar.gz|1172608210
cpan|DCANTRELL|XML-Tiny|1.05|XML-Tiny-1.05.tar.gz|1172611088
cpan|DCANTRELL|Net-Random|1.4|Net-Random-1.4.tar.gz|1172696838
cpan|DCANTRELL|XML-Tiny|1.06|XML-Tiny-1.06.tar.gz|1173048094
cpan|DCANTRELL|XML-DoubleEncodedEntities|1.0|XML-DoubleEncodedEntities-1.0.tar.gz|1173731580
cpan|DCANTRELL|Number-Phone-UK-DetailedLocations|1.3|Number-Phone-UK-DetailedLocations-1.3.tar.gz|1173904230
backpan|DCANTRELL|Number-Phone|1.57|Number-Phone-1.57.tar.gz|1173904311
cpan|DCANTRELL|Net-Random|2.0|Net-Random-2.0.tar.gz|1176419823
backpan|DCANTRELL|Number-Phone|1.58|Number-Phone-1.58.tar.gz|1180738847
cpan|DCANTRELL|Palm-TreoPhoneCallDB|1|Palm-TreoPhoneCallDB-1.tar.gz|1185722854
cpan|DCANTRELL|Palm-TreoPhoneCallDB|1.1|Palm-TreoPhoneCallDB-1.1.tar.gz|1185831423
cpan|DCANTRELL|Data-Compare|0.17|Data-Compare-0.17.tar.gz|1186507828
cpan|DCANTRELL|CPAN-FindDependencies|1.0|CPAN-FindDependencies-1.0.tar.gz|1187389332
cpan|DCANTRELL|CPAN-FindDependencies|1.01|CPAN-FindDependencies-1.01.tar.gz|1187484746
cpan|DCANTRELL|CPAN-FindDependencies|1.02|CPAN-FindDependencies-1.02.tar.gz|1187525335
cpan|DCANTRELL|Data-Hexdumper|1.3|Data-Hexdumper-1.3.tar.gz|1187647806
cpan|DCANTRELL|Tie-STDOUT|1.03|Tie-STDOUT-1.03.tar.gz|1188297328
cpan|DCANTRELL|Data-Transactional|1.0|Data-Transactional-1.0.tar.gz|1188338840
backpan|DCANTRELL|Devel-CheckOS|0.9|Devel-CheckOS-0.9.tar.gz|1191165763
backpan|DCANTRELL|Devel-CheckOS|0.91|Devel-CheckOS-0.91.tar.gz|1191257498
backpan|DCANTRELL|Devel-CheckOS|0.92|Devel-CheckOS-0.92.tar.gz|1191274415
cpan|DCANTRELL|Devel-CheckOS|1.0|Devel-CheckOS-1.0.tar.gz|1191340996
cpan|DCANTRELL|File-Find-Rule-Permissions|1.3|File-Find-Rule-Permissions-1.3.tar.gz|1191347852
cpan|DCANTRELL|Devel-CheckOS|1.1|Devel-CheckOS-1.1.tar.gz|1191593126
backpan|DCANTRELL|Devel-AssertLib|0.1|Devel-AssertLib-0.1.tar.gz|1192375350
cpan|DCANTRELL|Devel-CheckOS|1.2|Devel-CheckOS-1.2.tar.gz|1192378462
cpan|DCANTRELL|Devel-CheckLib|0.2|Devel-CheckLib-0.2.tar.gz|1192729369
cpan|DCANTRELL|XML-Tiny|1.07|XML-Tiny-1.07.tar.gz|1193231866
cpan|DCANTRELL|XML-Tiny|1.08|XML-Tiny-1.08.tar.gz|1193322652
cpan|DCANTRELL|XML-Tiny|1.09|XML-Tiny-1.09.tar.gz|1193680667
cpan|DCANTRELL|XML-Tiny|1.10|XML-Tiny-1.10.tar.gz|1193698322
cpan|DCANTRELL|Devel-CheckLib|0.3|Devel-CheckLib-0.3.tar.gz|1193758200
cpan|DCANTRELL|XML-Tiny|1.11|XML-Tiny-1.11.tar.gz|1193936800
cpan|DCANTRELL|Devel-CheckOS|1.3|Devel-CheckOS-1.3.tar.gz|1194459155
backpan|DCANTRELL|Devel-CheckOS|1.4|Devel-CheckOS-1.4.tar.gz|1194470832
cpan|DCANTRELL|Devel-CheckOS|1.41|Devel-CheckOS-1.41.tar.gz|1194471149
cpan|DCANTRELL|CPAN-FindDependencies|1.1|CPAN-FindDependencies-1.1.tar.gz|1194478606
cpan|DCANTRELL|Devel-CheckOS|1.42|Devel-CheckOS-1.42.tar.gz|1195591465
cpan|DCANTRELL|CPAN-FindDependencies|1.99_01|CPAN-FindDependencies-1.99_01.tar.gz|1196704088
cpan|DCANTRELL|CPAN-FindDependencies|2.0|CPAN-FindDependencies-2.0.tar.gz|1197644078
cpan|DCANTRELL|Data-Compare|1.18|Data-Compare-1.18.tar.gz|1200438903
cpan|DCANTRELL|CPU-Emulator-Memory|1.0|CPU-Emulator-Memory-1.0.tar.gz|1203023882
backpan|DCANTRELL|Number-Phone|1.581|Number-Phone-1.581.tar.gz|1204148764
cpan|DCANTRELL|CPU-Emulator-Memory|1.1|CPU-Emulator-Memory-1.1.tar.gz|1204231633
cpan|DCANTRELL|CPU-Emulator-Memory|1.001|CPU-Emulator-Memory-1.001.tar.gz|1204240758
cpan|DCANTRELL|CPU-Emulator-Memory|1.1001|CPU-Emulator-Memory-1.1001.tar.gz|1204241017
cpan|DCANTRELL|Devel-CheckLib|0.4|Devel-CheckLib-0.4.tar.gz|1204667632
cpan|DCANTRELL|Devel-CheckLib|0.5|Devel-CheckLib-0.5.tar.gz|1205352153
cpan|DCANTRELL|Devel-CheckOS|1.43|Devel-CheckOS-1.43.tar.gz|1205352876
cpan|DCANTRELL|CPU-Emulator-Z80|0.9|CPU-Emulator-Z80-0.9.tar.gz|1205362194
cpan|DCANTRELL|Data-Compare|1.19|Data-Compare-1.19.tar.gz|1210606922
cpan|DCANTRELL|Data-Hexdumper|1.4|Data-Hexdumper-1.4.tar.gz|1211126600
cpan|DCANTRELL|Number-Phone|1.6|Number-Phone-1.6.tar.gz|1211933180
cpan|DCANTRELL|CPU-Z80-Assembler|1.0|CPU-Z80-Assembler-1.0.tar.gz|1213389918
cpan|DCANTRELL|CPU-Emulator-Z80|1.0|CPU-Emulator-Z80-1.0.tar.gz|1213390005
cpan|DCANTRELL|CPU-Z80-Assembler|1.01|CPU-Z80-Assembler-1.01.tar.gz|1213464498
cpan|DCANTRELL|Data-Transactional|1.01|Data-Transactional-1.01.tar.gz|1213628141
cpan|DCANTRELL|Data-Transactional|1.02|Data-Transactional-1.02.tar.gz|1213628931
cpan|DCANTRELL|CPU-Z80-Assembler|1.02|CPU-Z80-Assembler-1.02.tar.gz|1214170047
cpan|DCANTRELL|DBIx-Class-SingletonRows|0.1|DBIx-Class-SingletonRows-0.1.tar.gz|1214404878
cpan|DCANTRELL|CPU-Z80-Assembler|1.03|CPU-Z80-Assembler-1.03.tar.gz|1214420549
cpan|DCANTRELL|DBIx-Class-SingletonRows|0.11|DBIx-Class-SingletonRows-0.11.tar.gz|1214501602
cpan|DCANTRELL|Palm-Treo680MessagesDB|1.0|Palm-Treo680MessagesDB-1.0.tar.gz|1215729752
cpan|DCANTRELL|Sort-MultipleFields|0.001_01|Sort-MultipleFields-0.001_01.tar.gz|1217022490
cpan|DCANTRELL|Sort-MultipleFields|1.0|Sort-MultipleFields-1.0.tar.gz|1217282145
cpan|DCANTRELL|Data-Compare|1.20|Data-Compare-1.20.tar.gz|1219329005
cpan|DCANTRELL|Data-Compare|1.200_500|Data-Compare-1.200_500.tar.gz|1219783829
cpan|DCANTRELL|Class-DBI-ClassGenerator|1.0|Class-DBI-ClassGenerator-1.0.tar.gz|1219943721
cpan|DCANTRELL|Data-Compare|1.21|Data-Compare-1.21.tar.gz|1220286742
cpan|DCANTRELL|Class-DBI-ClassGenerator|1.01|Class-DBI-ClassGenerator-1.01.tar.gz|1220459663
cpan|DCANTRELL|Devel-CheckOS|1.44|Devel-CheckOS-1.44.tar.gz|1222701481
cpan|DCANTRELL|Devel-CheckOS|1.45|Devel-CheckOS-1.45.tar.gz|1224705510
cpan|DCANTRELL|Devel-CheckOS|1.46|Devel-CheckOS-1.46.tar.gz|1225139915
cpan|DCANTRELL|Devel-CheckOS|1.49_01|Devel-CheckOS-1.49_01.tar.gz|1225925528
cpan|DCANTRELL|Devel-CheckOS|1.50|Devel-CheckOS-1.50.tar.gz|1226447712
cpan|DCANTRELL|Palm-SMS|0.03|Palm-SMS-0.03.tar.gz|1231604443
cpan|DCANTRELL|XML-Tiny|1.12|XML-Tiny-1.12.tar.gz|1232643360
cpan|DCANTRELL|Class-DBI-ClassGenerator|1.02|Class-DBI-ClassGenerator-1.02.tar.gz|1234279020
cpan|DCANTRELL|File-Find-Rule-Permissions|2.0|File-Find-Rule-Permissions-2.0.tar.gz|1234393200
cpan|DCANTRELL|Number-Phone|1.7|Number-Phone-1.7.tar.gz|1235679378
cpan|DCANTRELL|WWW-Facebook-Go-SGF|1.0|WWW-Facebook-Go-SGF-1.0.tar.gz|1235769360
cpan|DCANTRELL|Data-Hexdumper|2.0|Data-Hexdumper-2.0.tar.gz|1236037620
cpan|DCANTRELL|Data-Hexdumper|2.01|Data-Hexdumper-2.01.tar.gz|1236112173
cpan|DCANTRELL|Number-Phone|1.7001|Number-Phone-1.7001.tar.gz|1236125880
cpan|DCANTRELL|Tie-STDOUT|1.04|Tie-STDOUT-1.04.tar.gz|1237405832
cpan|DCANTRELL|App-Rsnapshot|1.999_00001|App-Rsnapshot-1.999_00001.tar.gz|1237406473
cpan|DCANTRELL|Tie-STDOUT|1.0401|Tie-STDOUT-1.0401.tar.gz|1237457580
cpan|DCANTRELL|XML-Tiny|2.0|XML-Tiny-2.0.tar.gz|1237750287
cpan|DCANTRELL|App-Rsnapshot|1.999_00002|App-Rsnapshot-1.999_00002.tar.gz|1237752266
cpan|DCANTRELL|XML-Tiny|2.01|XML-Tiny-2.01.tar.gz|1237832346
cpan|DCANTRELL|XML-Tiny|2.02|XML-Tiny-2.02.tar.gz|1237907700
cpan|DCANTRELL|XML-Tiny-DOM|1.0|XML-Tiny-DOM-1.0.tar.gz|1238088168
cpan|DCANTRELL|Palm-ProjectGutenberg|1.0|Palm-ProjectGutenberg-1.0.tar.gz|1238100499
cpan|DCANTRELL|CPAN-ParseDistribution|1.0|CPAN-ParseDistribution-1.0.tar.gz|1238454000
cpan|DCANTRELL|CPAN-ParseDistribution|1.1|CPAN-ParseDistribution-1.1.tar.gz|1238841917
cpan|DCANTRELL|Palm-Treo680MessagesDB|1.01|Palm-Treo680MessagesDB-1.01.tar.gz|1239374790
cpan|DCANTRELL|File-Overwrite|1.1|File-Overwrite-1.1.tar.gz|1239376506
cpan|DCANTRELL|CPAN-FindDependencies|2.1|CPAN-FindDependencies-2.1.tar.gz|1239471527
cpan|DCANTRELL|Devel-CheckOS|1.51|Devel-CheckOS-1.51.tar.gz|1239739065
cpan|DCANTRELL|CPAN-FindDependencies|2.2|CPAN-FindDependencies-2.2.tar.gz|1239750535
cpan|DCANTRELL|CPAN-FindDependencies|2.21|CPAN-FindDependencies-2.21.tar.gz|1239820296
cpan|DCANTRELL|Devel-CheckOS|1.52|Devel-CheckOS-1.52.tar.gz|1239820308
cpan|DCANTRELL|CPAN-FindDependencies|2.22|CPAN-FindDependencies-2.22.tar.gz|1239824601
cpan|DCANTRELL|Devel-CheckOS|1.53|Devel-CheckOS-1.53.tar.gz|1239833300
cpan|DCANTRELL|Devel-CheckOS|1.54|Devel-CheckOS-1.54.tar.gz|1239840679
cpan|DCANTRELL|Devel-CheckOS|1.55|Devel-CheckOS-1.55.tar.gz|1239840927
cpan|DCANTRELL|CPAN-FindDependencies|2.3|CPAN-FindDependencies-2.3.tar.gz|1240242800
cpan|DCANTRELL|Devel-CheckOS|1.6|Devel-CheckOS-1.6.tar.gz|1240342766
cpan|DCANTRELL|Number-Phone|1.7002|Number-Phone-1.7002.tar.gz|1240426027
cpan|DCANTRELL|CPAN-FindDependencies|2.31|CPAN-FindDependencies-2.31.tar.gz|1240586881
cpan|DCANTRELL|Devel-CheckOS|1.61|Devel-CheckOS-1.61.tar.gz|1240658305
cpan|DCANTRELL|CPAN-FindDependencies|2.32|CPAN-FindDependencies-2.32.tar.gz|1240846285
cpan|DCANTRELL|Data-Compare|1.2101|Data-Compare-1.2101.tar.gz|1241534586
cpan|DCANTRELL|Devel-CheckLib|0.6|Devel-CheckLib-0.6.tar.gz|1242827231
cpan|DCANTRELL|Bryar|3.1|Bryar-3.1.tar.gz|1243547561
cpan|DCANTRELL|XML-Tiny-DOM|1.1|XML-Tiny-DOM-1.1.tar.gz|1247698080
cpan|DCANTRELL|Devel-CheckLib|0.699_001|Devel-CheckLib-0.699_001.tar.gz|1249140614