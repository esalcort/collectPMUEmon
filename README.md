# collectPMUEmon
This repository contains sample scripts to periodically collect hardware performance monitoring units (PMU) of Intel processors.

The scripts use Intel's emon command-line tool.

**EMON's related links:**
* [User's guide](https://software.intel.com/content/www/us/en/develop/download/emon-user-guide.html)
* If EMON is not available to you, it can be found in the installation of [Intel's VTune Profiler](https://software.intel.com/content/www/us/en/develop/documentation/vtune-help/top.html)

## Scripts

### periodic_sample.sh

This script contains an example of how to collect data periodically. As an example, this script collects data from streamcluster benchmark in the [Parsec-3.0 Suite](https://parsec.cs.princeton.edu/). It assumes that the benchmark has been previously built already.
Read comments carefully and search for EDIT and UNCOMMENT for different ways to accommodate this script to your own needs.
