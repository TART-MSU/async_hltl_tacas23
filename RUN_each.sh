#!/bin/sh
#coding:utf-8
########################################################################
# This script runs table 2 of the paper:
# `` Bounded Model Checking for Asynchronous Hyperproperties ''

# To run, exexute:
# ./RUN_table2.sh

########################################################################
### Parameter setup
HYPERQUBE=./HyperQube-master/hyperqube.sh # The open source HyperQube tool
GENMODEL=./async_genmodel.sh
SOLVEQBF=./async_solveqbf.sh
PARSEOUTPUT=./async_parseoutputs.sh
DUMMYPROP=cases/dummy_prop.hq
SNIPROP=cases/speculative_execution/se_prop.hq
BUILD_SNI=cases/buildtraj_SNI.py
BUILD_AAE=cases/buildtraj_AAE.py # AAE: G((out_{pi, tau'} = out_{pi', tau'}))
BUILD_AAE2=cases/buildtraj_AAE2.py # AAE2: ((in_{pi, tau} = in_{pi', tau})) ==> G((out_{pi, tau} = out_{pi', tau}))
BUILD_AAAE=cases/buildtraj_AAAE.py # AAAE: ((in_{pi, tau} = in_{pi', tau})) ==> G((out_{pi, tau'} = out_{pi', tau'}))


TIMEFORMAT=' %R sec '
PRINTGEN="genQBF:%2s"
PRINTBUILD="buildTr:%1s"
PRINTSOLVE="solveQBF: "
# generate model, build trajectories, then solve QBF

WRITELOG=table2_LOG.txt
WRITETIME=table2_TIME.txt


MAP=exec/util_mapvars
PARSE_BOOL=exec/util_parsebools


########## Some helper scripts
### Check program termination
# ${HYPERQUBE} ${MODEL1} ${MODEL2} ${DUMMYPROP} ${M} hpes -find -multi
### Parse outputs
# ${PARSEOUTPUT}
### Parse trajectories
# PARSETRAJ=async_traj_parser.py
# python3 ${PARSETRAJ}

### clean
>${WRITELOG}
>${WRITETIME}

###########
#   ACDB  #
###########
# ### uncomment to run ACDB original
# ( echo "\n\n===== ACDB =====" ) | tee -a ${WRITETIME} | tee -a ${WRITELOG}
# M=6
# TRAJ=12
# MODEL1=ccs22_cases/acdb/original/acdb_composed.smv
# MODEL2=ccs22_cases/acdb/original/acdb_composed.smv
# BUILDTRAJ=${BUILD_AAE}
# ( printf ${PRINTGEN}; time ${GENMODEL} ${MODEL1} ${MODEL2} ${DUMMYPROP} ${M} hpes -find -multi >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTBUILD}; time python3 ${BUILDTRAJ} ${M} ${M} ${TRAJ} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTSOLVE}; time ${SOLVEQBF} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}


##################
#    ACBD ndet   #
##################
# ( echo "\n\n===== ACDB_ndet =====" ) | tee -a ${WRITETIME} | tee -a ${WRITELOG}
# M=8
# TRAJ=16
# MODEL1=ccs22_cases/acdb/with_ndet/acdb_composed.smv
# MODEL2=ccs22_cases/acdb/with_ndet/acdb_composed.smv
# BUILDTRAJ=${BUILD_AAAE}
# ( printf ${PRINTGEN}; time ${GENMODEL} ${MODEL1} ${MODEL2} ${DUMMYPROP} ${M} hpes -find -multi >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTBUILD}; time python3 ${BUILDTRAJ} ${M} ${M} ${TRAJ} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTSOLVE}; time ${SOLVEQBF} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}


########################
#   concurrent leaks   #
########################
### uncomment to run conc_leak original
# ( echo "\n\n===== ConcLeak =====" ) | tee -a ${WRITETIME} | tee -a ${WRITELOG}
# M=11
# D1=11
# D2=11
# TRAJ=22
# MODEL1=ccs22_cases/concleaks/original/conc_leaks_2procs.smv
# MODEL2=ccs22_cases/concleaks/original/conc_leaks_2procs.smv
# BUILDTRAJ=${BUILD_AAE}
# ( printf ${PRINTGEN}; time ${GENMODEL} ${MODEL1} ${MODEL2} ${DUMMYPROP} ${M} hpes -find -multi >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTBUILD}; time python3 ${BUILDTRAJ} ${D1} ${D2} ${TRAJ} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTSOLVE}; time ${SOLVEQBF} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}


###############################
#   concurrent leaks - ndet   #
###############################
### uncomment to run conc_leak new
# ( echo "\n\n===== ConcLeak =====" ) | tee -a ${WRITETIME} | tee -a ${WRITELOG}
# M=18
# D1=18
# D2=18
# TRAJ=36
# MODEL1=ccs22_cases/concleaks/with_ndet/conc_leaks_3procs.smv
# MODEL2=ccs22_cases/concleaks/with_ndet/conc_leaks_3procs.smv
# BUILDTRAJ=${BUILD_AAAE}
# ( printf ${PRINTGEN}; time ${GENMODEL} ${MODEL1} ${MODEL2} ${DUMMYPROP} ${M} hpes -find -multi >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTBUILD}; time python3 ${BUILDTRAJ} ${D1} ${D2} ${TRAJ} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTSOLVE}; time ${SOLVEQBF} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}




##############################
#   speculative executions   #
##############################

### uncomment to run SpecExcu_v1
# ( echo "\n\n===== SpecExcu_v1 =====" ) | tee -a ${WRITETIME} | tee -a ${WRITELOG}
# DUMMYPROP=ccs22_cases/speculative_execution/se_prop.hq
# M=7
# D1=3
# D2=6
# TRAJ=9
# MODEL1=ccs22_cases/speculative_execution/se_v1_nse.smv
# MODEL2=ccs22_cases/speculative_execution/se_v1_se.smv
# BUILDTRAJ=${BUILD_SNI}
# ( printf ${PRINTGEN}; time ${GENMODEL} ${MODEL1} ${MODEL2} ${DUMMYPROP} ${M} hpes -find -multi >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTBUILD}; time python3 ${BUILDTRAJ} ${D1} ${D2}  ${TRAJ} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTSOLVE}; time ${SOLVEQBF} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}


### uncomment to run SpecExcu_v2
( echo "\n\n===== SpecExcu_v2 =====" ) | tee -a ${WRITETIME} | tee -a ${WRITELOG}
DUMMYPROP=ccs22_cases/speculative_execution/se_prop.hq
M=7
D1=3
D2=6
TRAJ=9
MODEL1=ccs22_cases/speculative_execution/se_v2_nse.smv
MODEL2=ccs22_cases/speculative_execution/se_v2_se.smv
BUILDTRAJ=${BUILD_SNI}
( printf ${PRINTGEN}; time ${GENMODEL} ${MODEL1} ${MODEL2} ${DUMMYPROP} ${M} hpes -find -multi >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
( printf ${PRINTBUILD}; time python3 ${BUILDTRAJ} ${D1} ${D2} ${TRAJ} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
( printf ${PRINTSOLVE}; time ${SOLVEQBF} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}


### uncomment to run SpecExcu_v3
# ( echo "\n\n===== SpecExcu_v3 =====" ) | tee -a ${WRITETIME} | tee -a ${WRITELOG}
# M=7
# D1=3
# D2=6
# TRAJ=9
# MODEL1=ccs22_cases/speculative_execution/se_v3_nse.smv
# MODEL2=ccs22_cases/speculative_execution/se_v3_se.smv
# BUILDTRAJ=${BUILD_SNI}
# ( printf ${PRINTGEN}; time ${GENMODEL} ${MODEL1} ${MODEL2} ${DUMMYPROP} ${M} hpes -find -multi >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTBUILD}; time python3 ${BUILDTRAJ} ${D1} ${D2} ${TRAJ} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTSOLVE}; time ${SOLVEQBF} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}



### uncomment to run SpecExcu_v4
# ( echo "\n\n===== SpecExcu_v4 =====" ) | tee -a ${WRITETIME} | tee -a ${WRITELOG}
# M=7
# D1=3
# D2=6
# TRAJ=9
# MODEL1=ccs22_cases/speculative_execution/se_v4_nse.smv
# MODEL2=ccs22_cases/speculative_execution/se_v4_se.smv
# BUILDTRAJ=${BUILD_SNI}
# ( printf ${PRINTGEN}; time ${GENMODEL} ${MODEL1} ${MODEL2} ${DUMMYPROP} ${M} hpes -find -multi >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTBUILD}; time python3 ${BUILDTRAJ} ${D1} ${D2} ${TRAJ} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTSOLVE}; time ${SOLVEQBF} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}


### uncomment to run SpecExcu_v5
# ( echo "\n\n===== SpecExcu_v5 =====" ) | tee -a ${WRITETIME} | tee -a ${WRITELOG}
# M=7
# D1=3
# D2=6
# TRAJ=9
# MODEL1=ccs22_cases/speculative_execution/se_v5_nse.smv
# MODEL2=ccs22_cases/speculative_execution/se_v5_se.smv
# BUILDTRAJ=${BUILD_SNI}
# ( printf ${PRINTGEN}; time ${GENMODEL} ${MODEL1} ${MODEL2} ${DUMMYPROP} ${M} hpes -find -multi >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTBUILD}; time python3 ${BUILDTRAJ} ${D1} ${D2} ${TRAJ} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTSOLVE}; time ${SOLVEQBF} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}


### uncomment to run SpecExcu_v6
# ( echo "\n\n===== SpecExcu_v6 =====" ) | tee -a ${WRITETIME} | tee -a ${WRITELOG}
# M=7
# D1=3
# D2=7
# TRAJ=10
# MODEL1=ccs22_cases/speculative_execution/se_v6_nse.smv
# MODEL2=ccs22_cases/speculative_execution/se_v6_se.smv
# BUILDTRAJ=${BUILD_SNI}
# ( printf ${PRINTGEN}; time ${GENMODEL} ${MODEL1} ${MODEL2} ${DUMMYPROP} ${M} hpes -find -multi >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTBUILD}; time python3 ${BUILDTRAJ} ${D1} ${D2} ${TRAJ} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTSOLVE}; time ${SOLVEQBF} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}



### uncomment to run SpecExcu_v7
# ( echo "\n\n===== SpecExcu_v7 =====" ) | tee -a ${WRITETIME} | tee -a ${WRITELOG}
# M=7
# D1=3
# D2=7
# TRAJ=10
# MODEL1=ccs22_cases/speculative_execution/se_v7_nse.smv
# MODEL2=ccs22_cases/speculative_execution/se_v7_se.smv
# BUILDTRAJ=${BUILD_SNI}
# ( printf ${PRINTGEN}; time ${GENMODEL} ${MODEL1} ${MODEL2} ${DUMMYPROP} ${M} hpes -find -multi >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTBUILD}; time python3 ${BUILDTRAJ} ${D1} ${D2} ${TRAJ} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTSOLVE}; time ${SOLVEQBF} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}


########################
#   optimiazation      #
########################

############
#   DBE    #
############
### uncomment to run example original optimization _ DBE
# ( echo "\n\n===== Optimization: DBE =====" ) | tee -a ${WRITETIME} | tee -a ${WRITELOG}
# M=4
# D1=4
# D2=4
# TRAJ=8
# MODEL1=ccs22_cases/optimization/original/dbe/DBE_source.smv
# MODEL2=ccs22_cases/optimization/original/dbe/DBE_target.smv
# BUILDTRAJ=${BUILD_AAE2}
# ( printf ${PRINTGEN}; time ${GENMODEL} ${MODEL1} ${MODEL2} ${DUMMYPROP} ${M} hpes -find -multi >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTBUILD}; time python3 ${BUILDTRAJ} ${D1} ${D2} ${TRAJ} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTSOLVE}; time ${SOLVEQBF} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}


######################
#   DBE: with_ndet
######################
### OPTIMIZATION NEW: uncomment to run DBE new correct
# ( echo "\n\n===== Optimization: DBE_ndet =====" ) | tee -a ${WRITETIME} | tee -a ${WRITELOG}
# M=13
# D1=13
# D2=13
# TRAJ=26
# MODEL1=ccs22_cases/optimization/with_ndet/dbe/DBE_source_ndet.smv
# MODEL2=ccs22_cases/optimization/with_ndet/dbe/DBE_target_ndet.smv
# BUILDTRAJ=${BUILD_AAAE}
# ( printf ${PRINTGEN}; time ${GENMODEL} ${MODEL1} ${MODEL2} ${DUMMYPROP} ${M} hpes -find -multi >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTBUILD}; time python3 ${BUILDTRAJ} ${D1} ${D2} ${TRAJ} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTSOLVE}; time ${SOLVEQBF} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}


##########################
#   DBE: with_ndet w/bug
#########################
# ### OPTIMIZATION NEW: uncomment to run DBE new wrong
# ( echo "\n\n===== Optimization: DBE_ndet w/bugs =====" ) | tee -a ${WRITETIME} | tee -a ${WRITELOG}
# M=13
# D1=13
# D2=13
# TRAJ=26
# MODEL1=ccs22_cases/optimization/with_ndet/dbe/DBE_source_ndet.smv
# MODEL2=ccs22_cases/optimization/with_ndet/dbe/DBE_target_wrong_ndet.smv
# BUILDTRAJ=${BUILD_AAAE}
# ( printf ${PRINTGEN}; time ${GENMODEL} ${MODEL1} ${MODEL2} ${DUMMYPROP} ${M} hpes -find -multi >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTBUILD}; time python3 ${BUILDTRAJ} ${D1} ${D2} ${TRAJ} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTSOLVE}; time ${SOLVEQBF} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}






############
#    LP    #
############
### uncomment to run example original optimization _ LP
# ( echo "\n\n===== Optimization: LP =====" ) | tee -a ${WRITETIME} | tee -a ${WRITELOG}
# M=22
# D1=22
# D2=22
# TRAJ=44
# MODEL1=ccs22_cases/optimization/original/lp/LP_source.smv
# MODEL2=ccs22_cases/optimization/original/lp/LP_target.smv
# BUILDTRAJ=${BUILD_AAE2}
# ( printf ${PRINTGEN}; time ${GENMODEL} ${MODEL1} ${MODEL2} ${DUMMYPROP} ${M} hpes -find -multi >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTBUILD}; time python3 ${BUILDTRAJ} ${D1} ${D2} ${TRAJ} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTSOLVE}; time ${SOLVEQBF} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}


######################
#   LP:  with_ndet   #
######################
# ###  OPTIMIZATION NEW: uncomment to run LP new correct
# ( echo "\n\n===== Optimization: LP_ndet =====" ) | tee -a ${WRITETIME} | tee -a ${WRITELOG}
# M=17
# D1=17
# D2=17
# TRAJ=34
# MODEL1=ccs22_cases/optimization/with_ndet/lp/LP_source_ndet.smv
# MODEL2=ccs22_cases/optimization/with_ndet/lp/LP_target_ndet.smv
# BUILDTRAJ=${BUILD_AAAE}
# ( printf ${PRINTGEN}; time ${GENMODEL} ${MODEL1} ${MODEL2} ${DUMMYPROP} ${M} hpes -find -multi >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTBUILD}; time python3 ${BUILDTRAJ} ${D1} ${D2} ${TRAJ} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTSOLVE}; time ${SOLVEQBF} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}


############################
#   LP: with_ndet 2loops   #
############################
### OPTIMIZATION NEW: uncomment to run LP new correct with 2 loops
# ( echo "\n\n===== Optimization: LP_ndet =====" ) | tee -a ${WRITETIME} | tee -a ${WRITELOG}
# M=35
# D1=33
# D2=35
# TRAJ=68
# MODEL1=ccs22_cases/optimization/with_ndet_2loops/lp/LP_source_ndet.smv
# MODEL2=ccs22_cases/optimization/with_ndet_2loops/lp/LP_target_ndet.smv
# BUILDTRAJ=${BUILD_AAAE}
# ( printf ${PRINTGEN}; time ${GENMODEL} ${MODEL1} ${MODEL2} ${DUMMYPROP} ${M} hpes -find -multi >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTBUILD}; time python3 ${BUILDTRAJ} ${D1} ${D2} ${TRAJ} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTSOLVE}; time ${SOLVEQBF} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}


#############################
#   LP:  with_ndet w/ bugs  #
#############################
# ### uncomment to run LP new incorrect
# ( echo "\n\n===== Optimization: LP_ndet w/bugs =====" ) | tee -a ${WRITETIME} | tee -a ${WRITELOG}
# M=17
# D1=17
# D2=17
# TRAJ=34
# MODEL1=ccs22_cases/optimization/with_ndet/lp/LP_source_ndet.smv
# MODEL2=ccs22_cases/optimization/with_ndet/lp/LP_target_wrong_ndet.smv
# BUILDTRAJ=${BUILD_AAAE}
# ( printf ${PRINTGEN}; time ${GENMODEL} ${MODEL1} ${MODEL2} ${DUMMYPROP} ${M} hpes -find -multi >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTBUILD}; time python3 ${BUILDTRAJ} ${D1} ${D2} ${TRAJ} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTSOLVE}; time ${SOLVEQBF} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}





##############
#   EFLP     #
##############
### uncomment to run example original optimization _ EFLP
# ( echo "\n\n===== Optimization: EFLP =====" ) | tee -a ${WRITETIME} | tee -a ${WRITELOG}
# M=32
# D1=32
# D2=32
# TRAJ=64
# MODEL1=ccs22_cases/optimization/original/eflp/EFLP_source.smv
# MODEL2=ccs22_cases/optimization/original/eflp/EFLP_target.smv
# BUILDTRAJ=${BUILD_AAE2}
# ( printf ${PRINTGEN}; time ${GENMODEL} ${MODEL1} ${MODEL2} ${DUMMYPROP} ${M} hpes -find -multi >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTBUILD}; time python3 ${BUILDTRAJ} ${D1} ${D2} ${TRAJ} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTSOLVE}; time ${SOLVEQBF} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}


#######################
#   EFLP: with_ndet   #
#######################
### OPTIMIZATION NEW: uncomment to run EFLP new correct
# ( echo "\n\n===== Optimization: EFLP_ndet =====" ) | tee -a ${WRITETIME} | tee -a ${WRITELOG}
# M=22
# D1=18
# D2=22
# TRAJ=40
# MODEL1=ccs22_cases/optimization/with_ndet/eflp/EFLP_source_ndet.smv
# MODEL2=ccs22_cases/optimization/with_ndet/eflp/EFLP_target_ndet.smv
# BUILDTRAJ=${BUILD_AAAE}
# ( printf ${PRINTGEN}; time ${GENMODEL} ${MODEL1} ${MODEL2} ${DUMMYPROP} ${M} hpes -find -multi >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTBUILD}; time python3 ${BUILDTRAJ} ${D1} ${D2} ${TRAJ} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTSOLVE}; time ${SOLVEQBF} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}


##############################
#   with_ndet: EFLP-2loops   #
##############################
### OPTIMIZATION NEW: uncomment to run EFLP new correct with 2 loops
# ( echo "\n\n===== Optimization: EFLP_ndet w/loops =====" ) | tee -a ${WRITETIME} | tee -a ${WRITELOG}
# M=54
# D1=37
# D2=54
# TRAJ=91
# MODEL1=ccs22_cases/optimization/with_ndet_2loops/eflp/EFLP_source_ndet.smv
# MODEL2=ccs22_cases/optimization/with_ndet_2loops/eflp/EFLP_target_ndet.smv
# BUILDTRAJ=${BUILD_AAAE}
# time ${GENMODEL} ${MODEL1} ${MODEL2} ${DUMMYPROP} ${M} hpes -find -multi
# time python3 ${BUILDTRAJ} ${D1} ${D2} ${TRAJ}
# time ${SOLVEQBF}
# ( printf ${PRINTGEN}; time ${GENMODEL} ${MODEL1} ${MODEL2} ${DUMMYPROP} ${M} hpes -find -multi >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTBUILD}; time python3 ${BUILDTRAJ} ${D1} ${D2} ${TRAJ} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTSOLVE}; time ${SOLVEQBF} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}





# ###########################
# #   cache timing attack   #
# ###########################
# # ### uncomment to run cache-based timinig attack original
# ( echo "\n\n===== Cache-based Timing Attack =====" ) | tee -a ${WRITETIME} | tee -a ${WRITELOG}
# M=13
# D1=13
# D2=13
# TRAJ=26
# MODEL1=ccs22_cases/cache_timing_attack/cache_attack.smv
# MODEL2=ccs22_cases/cache_timing_attack/cache_attack.smv
# BUILDTRAJ=${BUILD_AAE}
# ( printf ${PRINTGEN}; time ${GENMODEL} ${MODEL1} ${MODEL2} ${DUMMYPROP} ${M} hpes -find -multi >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTBUILD}; time python3 ${BUILDTRAJ} ${D1} ${D2} ${TRAJ} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTSOLVE}; time ${SOLVEQBF} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}


# ###################################
# #   cache timing attack -- ndet   #
# ###################################
# # ### uncomment to run cache-based timinig attack with ndet
# ( echo "\n\n===== Cache-based Timing Attack_ndet =====" ) | tee -a ${WRITETIME} | tee -a ${WRITELOG}
# M=16
# D1=16
# D2=16
# TRAJ=32
# MODEL1=ccs22_cases/cache_timing_attack/cache_attack_ndet.smv
# MODEL2=ccs22_cases/cache_timing_attack/cache_attack_ndet.smv
# BUILDTRAJ=${BUILD_AAAE}
# ( printf ${PRINTGEN}; time ${GENMODEL} ${MODEL1} ${MODEL2} ${DUMMYPROP} ${M} hpes -find -multi >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTBUILD}; time python3 ${BUILDTRAJ} ${D1} ${D2} ${TRAJ} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTSOLVE}; time ${SOLVEQBF} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}


###########################################
#   cache timing attack -- ndet - loops   #
###########################################
# ### uncomment to run cache-based timinig attack with ndet
# ( echo "\n\n===== Cache-based Timing Attack_ndet w/loops =====" ) | tee -a ${WRITETIME} | tee -a ${WRITELOG}
# M=35
# D1=35
# D2=35
# TRAJ=70
# MODEL1=ccs22_cases/cache_timing_attack/cache_attack_ndet_loops.smv
# MODEL2=ccs22_cases/cache_timing_attack/cache_attack_ndet_loops.smv
# BUILDTRAJ=${BUILD_AAAE}
# ( printf ${PRINTGEN}; time ${GENMODEL} ${MODEL1} ${MODEL2} ${DUMMYPROP} ${M} hpes -find -multi >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTBUILD}; time python3 ${BUILDTRAJ} ${D1} ${D2} ${TRAJ} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
# ( printf ${PRINTSOLVE}; time ${SOLVEQBF} >> ${WRITELOG} ) 2>&1 | tee -a ${WRITETIME}
