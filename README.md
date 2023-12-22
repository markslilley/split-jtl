## split-jtl v1.0.0

This shell script can take a jtl file and split it into new jtl files containing only the period of time where the peak throughput executed. It will then create individual Jmeter HTML reports for each. With this granularity you will get an accurate view of the percentiles, throughput and response times rather than the skewed figures from the entire test.

### Script Execution
The script expects input values from the command line. These are rampup, rampdown, hold and filename. If any of the values are not entered you will be prompted with a help dialogue.

`./split-jtl.sh 600 0 600 dummy.jtl`

### Output
The output of the script will be new jtl files and new Jmeter HTML reports. So typically you will see the following files and folders for a full Peak+5 run. Before execution the script will delete any previously created files listed below. 

#### jtl files
- report0.jtl - Filtered copy of full report. It will remove any incomplete lines and ensures that column numbers are correct removing any problem lines.
- report1.jtl - Peak 1
- report2.jtl - Peak 2
- report3.jtl - Peak 3
- report4.jtl - Peak 4
- report5.jtl - Peak 5

#### HTML Report folders
- report0 - Filtered copy of full report. It will remove any incomplete lines and ensures that column numbers are correct removing any problem lines.
- report1 - Peak 1
- report2 - Peak 2
- report3 - Peak 3
- report4 - Peak 4
- report5 - Peak 5

#### Temp files
- temp0.jtl - this is a temp file created to leave the kpi-out.jtl unaltered but provide a working copy which has been filtered.

#### Example Execution Output

```
./split-jtl.sh 600 0 1800 dummy.jtl 
Deleting any old report and temp files/folders
### startDate=Wed  1 Dec 10:24:19 GMT 2021 | endDate=Wed  1 Dec 11:35:59 GMT 2021 | duration=4300 | Report=2 ###
Spliting into individual report jtls and generating HTML reports
### Generating Full Report  -->  report0.jtl  Generating HTML report0 ###
### Wed  1 Dec 10:34:20 GMT 2021 - Wed  1 Dec 11:04:20 GMT 2021  -->  Generating report1.jtl  Generating HTML report1 ###
### Wed  1 Dec 11:04:21 GMT 2021 - Wed  1 Dec 11:34:21 GMT 2021  -->  Generating report2.jtl  Generating HTML report2 ###
```
