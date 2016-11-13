#!/usr/bin/perl

use strict;
use warnings;
 
my $file = $ARGV[0] or die "Need to get CSV file on the command line\n";
my $gpsflag = $ARGV[3];

my $sum = 0;
my $off = 0;
my $tone = "";
my $dtcscode = 23;
my $ctonefreq = 88.5;
#my $dtcsPolarity = "NN";
my $mode = "FM";
my $tstep = 5;

open(my $data, '<', $file) or die "Could not open $!\n";

open(my $out, '>', $ARGV[1] ) or die "unable to open outfile\n";
# if ($gpsflag == 1) {open(my $gpsout, '>', $ARGV[2] ) or die "unable to open gpsoutfile\n"};
open(my $gpsout, '>', $ARGV[2] ) or die "unable to open gpsoutfile\n";


print $out "Receive Frequency,Transmit Frequency,Offset Direction,Operating Mode,Name,Show Name,Tone Mode,CTCSS,DCS,Tx Power,Comment\n";
if ( $file eq "/tmp/trip2m.csv" ) {print $out "146.520000,146.520000,,FM,2M CALL,Small,None,100,023,High,2M Simplex\n"}; 
if ( $file eq "/tmp/trip70cm.csv" ) {print $out "446.000000,446.000000,,FM,70cm CALL,Small,None,100,023,High,70cm Simplex\n"};
if ( $gpsflag == 1 ) {print $gpsout "Name,Latitude,Longitude,City\n"};
while (my $line = <$data>) {
  chomp $line;
  my @fields = split /,/, $line;
#  my $off = sprintf("%.2f", abs ( $fields[0] - $fields[1]));
  if ( $fields[3] eq '') {$tone = ""; $fields[3] = 88.5} else { $tone = "Tone" };
  print $out "$fields[0],$fields[1],$fields[2],$mode,$fields[9],Small,$tone,$fields[3],$dtcscode,High,$fields[5] $fields[6]\n";
  if ( $gpsflag == 1 ) {print $gpsout "$fields[9],$fields[7],$fields[8],$fields[5]\n"};
}
  close( $out );
  close( $gpsout );