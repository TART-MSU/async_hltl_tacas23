# HyperQube subTools
GENQBF=HyperQube-master/exec/genqbf
QUABS=HyperQube-master/exec/quabs
MAP=HyperQube-master/exec/util_mapvars
PARSE_BOOL=HyperQube-master/exec/util_parsebools

# output files
QCIR_OUT=HQ_async.qcir
QUABS_OUT=HQ.quabs

QUABS_OUT=HQ.quabs
MAP_OUT1=OUTPUT_byName.cex
MAP_OUT2=OUTPUT_byTime.cex
PARSE_OUT=OUTPUT_formatted.cex

# simple mapping of variable names and values
# TODO: do it in python
# MAP=util/util_mapvars.java
# MAP=util_mapvars
MAP_OUT1=OUTPUT_byName.cex
MAP_OUT2=OUTPUT_byTime.cex
# simple parser for convering binaries to digits
# PARSE_BOOL=util/util_parsebools.java
# PARSE_BOOL=util_parsebools
PARSE_OUT=OUTPUT_formatted.cex
# echo "---QUABS solving---"
echo "solving QBF..."
  ${QUABS}  --statistics --partial-assignment ${QCIR_OUT} 2>&1 | tee ${QUABS_OUT}
#  ${QUABS} --statistics --preprocessing 0 --partial-assignment ${QCIR_OUT} 2>&1 | tee ${QUABS_OUT}


${MAP} ${QCIR_OUT} ${QUABS_OUT} ${MAP_OUT1} ${MAP_OUT2}
${PARSE_BOOL} ${MAP_OUT2} ${PARSE_OUT}
