# split-jtl
As an output to Apache Jmeter testing a JTL file is typically created containing all of the captured data points for the entire duration of the test.

Depending on the scenario this may also include a period of ramp-up and ramp-down. When reporting on the test you may want to exclude these to ensure the averages and percentiles are not impacted.

This bash script is designed to take the JTL file and produce report(s) from the data. It can exclude ramp-up and ramp-down and can prove time slices such as 1 hour which will then be written to individual JTL files and HTML reports generated for each. By default the pack will also create a HTML report for the original JTL file.

** Pre-reqs ** 
To use the script you will been a working version of bash with `bc` installed.

** Example commands **
The shell script expects a number of inputs. These are rampup, duration, rampdown and JTL filename. All numerical values signify seconds. So in thie instance there was a 10 minute ramp-up and the test ran for 1 hour with no ramp-down. The JTL filename was dummy.jtl.

`./split_jtl.sh 600 3600 0 dummy.jtl`

