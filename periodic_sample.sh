#!/bin/bash

## Make sure that emon command is readily available.
## If installed with VTune Profiler, source vtune-vars.sh as follows:
## # # # # # # # # # # # # EDIT THIS # # # # # # # # # # # # ##
## Change directory to point to the location of VTune or Emon##
## installation in your machine                              ##  
source /opt/intel/vtune_profiler_2020.2.0.610396/vtune-vars.sh
## # # # # # # # # # # # # # # # # # # # # # # # # # # # # # ##


## # # # # # # # # # # # # EDIT THIS # # # # # # # # # # # # ##
## As an example, I am using one of PARSEC-3.0's benchmarks.
## Modify $execline to contain the command to run your workload
for benchmark in streamcluster; do
 execline="/home/local/gamma/esalcort/parsec-3.0/bin/parsecmgmt -a run -p ${benchmark} -i native"
## # # # # # # # # # # # # # # # # # # # # # # # # # # # # # ##

 ## Emon works better when executing a line with no arguments. Thus, I copy the execution line to 
 ## a temporary file with execution permissions.
 echo $execline > temp.sh
 chmod +x temp.sh

 ## # # # # # # # # # # # # EDIT THIS # # # # # # # # # # # # ##
 ## Edit emon's arguments according to your needs
 ## Tip: to look at available PMU use
 ## emon -!
 # EMON command to collect data periodically:
 # emon
 # -V                                             : CSV friendly format
 # -f ${benchmark}.csv                            : output file
 # -t0.1                                          : every 100 ms
 # -l800000                                       : MAX number of data points, required to force emon to collect periodically
 # -w                                             : Finish collection when workload is done (if it finishes before MAX)
 # -C "INST_RETIRED.ANY,CPU_CLK_UNHALTED.THREAD"  : Performance counters to collect
 # ./temp.sh                                      : Workload lo execute
 # > emon.log                                     : Forward workload's standard output
 emon -V -f ${benchmark}.csv -t0.1 -l8000000 -w -C "INST_RETIRED.ANY,CPU_CLK_UNHALTED.THREAD" ./temp.sh > emon.log
 ## # # # # # # # # # # # # # # # # # # # # # # # # # # # # # ##
	
 ## # # # # # # # # # # # # # # # # # # # # # # # # # # # # # ##
 ## The workload will be executed on any core, controlled by the Operating System.
 ## Taskset can be used to indicate on which cpu(s) to run the workload

 ## UNCOMMENT Next Line for a Single Core example. Modify "2" for any other CPU if necessary
 # taskset 2 emon -V -f ${benchmark}.csv -t0.1 -l8000000 -w -C "INST_RETIRED.ANY,CPU_CLK_UNHALTED.THREAD" ./temp.sh > emon.log

 ## UNCOMMENT Next Line for a Multi-Core example with fixed cores. Modify "2,4" for any other CPU(s) if necessary
 # taskset --cpu-list 2,4 emon -V -f ${benchmark}.csv -t0.1 -l8000000 -w -C "INST_RETIRED.ANY,CPU_CLK_UNHALTED.THREAD" ./temp.sh > emon.log
 ## # # # # # # # # # # # # # # # # # # # # # # # # # # # # # ##

 ## Optional. Remove temporary files
 rm emon.log
 rm temp.sh
done






