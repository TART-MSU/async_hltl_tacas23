# Artifact of TACAS'23 Paper Submission:
``Bounded Model Checking for Asynchronous Hyperproperties''

We present our empirical evaluation of bounded model checking for Asynchronous Hyperproperties.

We use the existing tool HyperQube (see HyperQube-master) to run our experiments. 

STEP1:
Our artifact runs the tool HyperQube, which requires the installation of docker first:
	Install [docker](https://docs.docker.com/get-docker/)


STEP2:
We create the following two scripts to easily run all the experiments preseted in the paper:

1. `./RUN_table2.sh`
Execute all cases on table 2, in the same order of the table presentation. The output files are the followings:

	(1) table2_TIME.txt: contains all the execution time for each cases including: genQBF, buildTr, and solveQBF.

	(2) table2_LOG: contains all detail execution information for each steps, including:
		- model generation data such as unrolling diameters;
		- trajectory building such as sizes of trajectory variables;
		- QBF solving data such as the partial assignments.  


2. `./RUN_each.sh`
This is the same script as RUN_table2.sh, but with everything commented out. To run a specific case, navigate to the case according to its title and uncomment the corresponding block (indicated in the script too), to reproduce a specific case.
