#/bin/sh
# files
Babel=/Applications/GPSBabelFE.app/Contents/MacOS/gpsbabel
Stylefile=./repeater.style
Tpdir=/tmp
Converterpl=./Rtsys.pl

echo "usage mapchirp.sh track_kml 2M_csv 70cm_csv near_miles widearea_miles generate_lat/lon(0or1)"

#clean up files

grep -v -e 'DStar\|DMR\|ATV\|P25\|Wide\ area' $2 |grep 'On-Air' |grep OPEN > $Tpdir/2mtmp.csv

grep -v -e 'DStar\|DMR\|ATV\|P25\|Wide\ area' $3 |grep 'On-Air' |grep OPEN > $Tpdir/70cmtmp.csv

grep -v -e 'DStar\|DMR\|ATV\|P25' $2 |grep 'On-Air' |grep OPEN |grep Wide\ area > $Tpdir/2mwidetmp.csv

grep -v -e 'DStar\|DMR\|ATV\|P25' $3 |grep 'On-Air' |grep OPEN |grep Wide\ area > $Tpdir/70cmwidetmp.csv

echo "grep done"
# convert kml gps file to arc path

$Babel -i kml -f $1 -o arc -F $Tpdir/ARCTEMP.arc

echo "arc generated"
# generate near repeater file


$Babel -i xcsv,style=$Stylefile -f $Tpdir/2mtmp.csv -x arc,file=$Tpdir/ARCTEMP.arc,distance=$4 -o xcsv,style=$Stylefile -F $Tpdir/trip2m_n.csv

$Babel -i xcsv,style=$Stylefile -f $Tpdir/2mwidetmp.csv -x arc,file=$Tpdir/ARCTEMP.arc,distance=$5 -o xcsv,style=$Stylefile -F $Tpdir/trip2m_w.csv

echo "near table generated"
# generate far repeater file

$Babel -i xcsv,style=$Stylefile -f $Tpdir/70cmtmp.csv -x arc,file=$Tpdir/ARCTEMP.arc,distance=$4 -o xcsv,style=$Stylefile -F $Tpdir/trip70cm_n.csv

$Babel -i xcsv,style=$Stylefile -f $Tpdir/70cmwidetmp.csv -x arc,file=$Tpdir/ARCTEMP.arc,distance=$5 -o xcsv,style=$Stylefile -F $Tpdir/trip70cm_w.csv

echo "far table generated"
# concat near and far

cat $Tpdir/trip2m_w.csv $Tpdir/trip2m_n.csv > $Tpdir/trip2m.csv
cat $Tpdir/trip70cm_w.csv $Tpdir/trip70cm_n.csv > $Tpdir/trip70cm.csv

echo "files merged"
# remove “x” from offset

sed -ie s/,x,/,,/g $Tpdir/trip2m.csv
sed -ie s/,x,/,,/g $Tpdir/trip70cm.csv
sed -ie s/\ //g $Tpdir/trip2m.csv
sed -ie s/\ //g $Tpdir/trip70cm.csv
sed -ie s/\"//g $Tpdir/trip2m.csv
sed -ie s/\"//g $Tpdir/trip70cm.csv


#
# add line numbers
# 

# awk '{printf("%5d , %s\n", NR,$0)}' $Tpdir/trip2m.csv > $Tpdir/ntrip2m.csv
# awk '{printf("%5d , %s\n", NR,$0)}' $Tpdir/trip70cm.csv > $Tpdir/ntrip70cm.csv

echo "tables cleaned"

# reorder columns

$Converterpl $Tpdir/trip2m.csv ./2mout.csv ./2mgpsout.csv $6
$Converterpl $Tpdir/trip70cm.csv ./70cmout.csv ./70cmgpsout.csv $6

echo "tables converted to RTSys compatible"

