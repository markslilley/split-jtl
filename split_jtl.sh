#!/bin/bash

rampup=$1
rampdown=$2
hold=$3
filename=$4
JMETER_HOME="~/Development/Applications/apache-jmeter-5.5/bin"

if ! [[ -n $rampup && -n $rampdown && -n $hold && -f $filename ]]; then
    echo "$0 600 0 600 kpi-out.jtl"
    exit 1
else
    echo "Deleting any old report and temp files/folders"
    rm -Rf $(ls | grep -E 'report[0-9]+|temp') > /dev/null
    
    header=`grep timeStamp $filename | head -n1`
    columns=`echo $header | awk -F "," ' { print NF-1 } '`
    startDate=`sed '1d' $filename  | head -n1 | cut -c1-10`
    endDate=`cut -d, -f1 $filename | tail -n1 | cut -c1-10`
    durationSec=$(echo `echo $endDate - $startDate | bc`)
    testDuration=$(echo `echo $durationSec - $rampup - $rampdown | bc`)
    loops=$(echo `scale=0;echo $testDuration / $hold | bc`)

    echo "### startDate=$(date -d @$startDate) | endDate=$(date -d @$endDate) | duration=$durationSec | Report=$loops ###"
    echo "Spliting into individual report jtls and generating HTML reports"
    
    echo "### Generating Full Report  -->  report0.jtl  Generating HTML report0 ###"
    awk -v columns=$columns -F "," ' { if ( NF-1 == columns ) print $0 } ' $filename > report0.jtl
    (exec ${JMETER_HOME}/jmeter -g report0.jtl -o report0)
    
    for (( i=1 ; i<=$loops ; i++ ));
    do
        if [ $i -eq 1 ]; then
            Start=$(echo $startDate + $rampup + 1 | bc)
        else
            Start=$(echo $startDate + 1 | bc)
        fi
        End=$(echo $Start + $hold | bc)
        echo "### $(date -d @$Start) - $(date -d @$End)  -->|Generating report$i.jtl|Generating HTML report$i ###" | column -s "|"  -t
        sed -n "/^$Start/,/^$End/{p;/^$End/q}" $filename | awk -v columns=$columns -F "," ' { if ( NF-1 == columns ) print $0 } ' > report"$i".jtl
        sed -i "1i $header"  report"$i".jtl
        (exec ${JMETER_HOME}/jmeter -g report"$i".jtl -o report"$i")
        startDate=$End
    done
fi

