#!/usr/bin/perl

use strict;
use warnings;
 
my $file = $ARGV[0] or die "Need to get CSV file on the command line\n";
my $flag = $ARGV[3];
my $gpsflag = $ARGV[4];

my $sum = 0;
my $off = 0;
my $tone = "";
my $dtcscode = 23;
my $ctonefreq = 88.5;
my $dtcsPolarity = "NN";
my $mode = "FM";
my $tstep = 5;
my $last = 0;

open(my $data, '<', $file) or die "Could not open $!\n";

open(my $out, '>', $ARGV[1] ) or die "unable to open outfile\n";
# if ($gpsflag == 1) {open(my $gpsout, '>', $ARGV[2] ) or die "unable to open gpsoutfile\n"};
open(my $gpsout, '>', $ARGV[2] ) or die "unable to open gpsoutfile\n";


print $out "Location,Name,Frequency,Duplex,Offset,Tone,rToneFreq,cToneFreq,DtcsCode,DtcsPolarity,Mode,TStep,Skip,Comment,URCALL,RPT1CALL,RPT2CALL\n";
if ( $file eq "/tmp/ntrip2m.csv" ) {print $out "0,2M CALL,146.520000,,0.000000,,88.5,88.5,023,NN,FM,5.00,,,,,,\n"}; 
if ( $file eq "/tmp/ntrip70cm.csv" ) {print $out "0,70CM CALL,446.000000,,0.000000,,88.5,88.5,023,NN,FM,5.00,,,,,,\n"};
if ( $gpsflag == 1 ) {print $gpsout "id,Name,Latitude,Longitude,City\n"};
while (my $line = <$data>) {
  chomp $line;
  my @fields = split /,/, $line;
  my $off = sprintf("%.2f", abs ( $fields[1] - $fields[2]));
  if ( $fields[4] eq '') {$tone = ""; $fields[4] = 88.5} else { $tone = "Tone" };
  print $out "$fields[0],$fields[10],$fields[1],$fields[3],$off,$tone,$fields[4],$ctonefreq,$dtcscode,$dtcsPolarity,$mode,$tstep,,$fields[6],,,,,,\n";
  $last = $fields[0];
  if ( $gpsflag == 1 ) {print $gpsout "$fields[0],$fields[10],$fields[8],$fields[9],$fields[6]\n"};
}
if ($flag == 1) {
  $last++;
  print $out "$last,WX1,162.550000,,0.000000,,88.5,88.5,023,NN,FM,5.00,,,,,,\n";
  $last++;
  print $out "$last,WX2,162.400000,,0.000000,,88.5,88.5,023,NN,FM,5.00,,,,,,\n";
  $last++;
  print $out "$last,WX3,162.475000,,0.000000,,88.5,88.5,023,NN,FM,5.00,,,,,,\n";
  $last++;
  print $out "$last,WX4,162.425000,,0.000000,,88.5,88.5,023,NN,FM,5.00,,,,,,\n";
  $last++;
  print $out "$last,WX5,162.450000,,0.000000,,88.5,88.5,023,NN,FM,5.00,,,,,,\n";
  $last++;
  print $out "$last,WX6,162.500000,,0.000000,,88.5,88.5,023,NN,FM,5.00,,,,,,\n";
  $last++;
  print $out "$last,WX7,162.525000,,0.000000,,88.5,88.5,023,NN,FM,5.00,,,,,,\n";
}
  close( $out );
  close( $gpsout );