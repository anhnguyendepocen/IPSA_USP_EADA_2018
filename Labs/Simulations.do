*     ***************************************************************** *
*     ***************************************************************** *
*       File-Name:      SIMULATIONS.do                                  *
*       Date:           01/11/2018                                      *
*       Last Update:    01/11/2018                                      *
*       Author:         Flavio D.S. Souza                               *
*       Email Address:  fsouza@tamu.edu                                 *
*       Purpose:        Intro to Simulations for IPSA USP Summer 2018   *
*       Input File:     none                                            *
*       Output File:    none                                            *
*       Data Output:    various	                                        *
*       Previous file:  None                                            *
*       Machine:        MacBook                                         *
*     ****************************************************************  *
*     ****************************************************************  *

*** PART 1: Intro to Simulations ***
/* We will now be working with simulated data. The main advantage in using 
simulated data is that we can manipulate the data generating process (DGP)*/

clear //Start by clearing the data from memory

set obs 1000 //We need to tell Stata how many observations we are looking to simulate

egen id = fill(1 2 3 4) /*Egen is a useful command that generates values that 
DIFFER across observations fill is a function that allows for a pattern to be created.*/
egen id_2 = fill(100 99 98) //Another pattern

gen x=. //This generates a missing value variable x

gen y=. //Same as above except that this time we're generating y

gen z=.

replace x=41.8 //x is constant across all observations

replace y=23.5 if id<=50 //if is a very useful operator in Stata

replace z=38.4 if id_2==4 | id_2==100

replace z=48.4 if id==6 & id_2==95

drop id //This deletes all observations in a variable

drop x y z id_2

*Random function generator
/* Stata has MANY random-number functions and I encourage you to look up this PDF 
https://www.stata.com/manuals/fnrandom-numberfunctions.pdf for more info */
clear
set obs 1000
set seed 36273 //Ironically, this makes any RANDOM number generation process reproducible
gen x = runiform(0,1) //Uniform distribution from 0 to 1
kdensity x
gen y = rexponential(0.5)
kdensity y

//Simulations for illustrating the central limit theorem
	//10 Distributions with the SAME of number of observations
clear
set seed 35356
drawnorm r1 r2 r3 r4 r5 r6 r7 r8 r9 r10, n(100) //Notice: 100 observations
*Producing a graph
twoway kdensity r1 || kdensity r2 || kdensity r3 || kdensity r4 || kdensity r5 ///
 || kdensity r6 || kdensity r7 || kdensity r8 || kdensity r9 || kdensity r10, xline(0)
 
	//10 Distributions with a DIFFERENT number of observations
clear
set seed 242536
set obs 5
drawnorm r1
set obs 10
drawnorm r2
set obs 15
drawnorm r3
set obs 50
drawnorm r4
set obs 100
drawnorm r5
set obs 500
drawnorm r6
set obs 1000
drawnorm r7
set obs 5000
drawnorm r8
set obs 10000
drawnorm r9
set obs 50000
drawnorm r10
twoway kdensity r1 || kdensity r2 || kdensity r3 || kdensity r4 || kdensity r5 ///
 || kdensity r6 || kdensity r7 || kdensity r8 || kdensity r9 || kdensity r10, xline(0)


*******Sample Distribution of a Parameter********
//36 Observations

clear
set obs 5000
set seed 682941
gen hdi=rexponential(0.66)
save "/Users/fsouza/Dropbox/TAMU/Projects/IPSA_2018/TA/Data/hdi.dta", replace
clear
forvalues v = 1/10000 {
use "/Users/fsouza/Dropbox/TAMU/Projects/IPSA_2018/TA/Data/hdi.dta", clear
sample 36, count
su hdi
gen mean=.
replace mean=r(mean) if [_n]==1
drop hdi
save "/Users/fsouza/Dropbox/TAMU/Projects/IPSA_2018/TA/Data/`v'.dta", replace
}
clear
use "/Users/fsouza/Dropbox/TAMU/Projects/IPSA_2018/TA/Data/1.dta"
forvalues v = 2/10000 {
append using "/Users/fsouza/Dropbox/TAMU/Projects/IPSA_2018/TA/Data/`v'.dta"
}
drop if mean==.
rename mean Thirty_Six
egen id=fill(1 2 3)
save "/Users/fsouza/Dropbox/TAMU/Projects/IPSA_2018/TA/Data/Thirty_Six.dta", replace
forvalues v = 1/10000 {
capture erase "/Users/fsouza/Dropbox/TAMU/Projects/IPSA_2018/TA/Data/`v'.dta"
}
//100 observations

clear
set obs 5000
set seed 682941
gen hdi=rexponential(0.66)
save "/Users/fsouza/Dropbox/TAMU/Projects/IPSA_2018/TA/Data/hdi.dta", replace
clear
forvalues v = 1/10000 {
use "/Users/fsouza/Dropbox/TAMU/Projects/IPSA_2018/TA/Data/hdi.dta", clear
sample 100, count
su hdi
gen mean=.
replace mean=r(mean) if [_n]==1
drop hdi
save "/Users/fsouza/Dropbox/TAMU/Projects/IPSA_2018/TA/Data/`v'.dta", replace
}
clear
use "/Users/fsouza/Dropbox/TAMU/Projects/IPSA_2018/TA/Data/1.dta"
forvalues v = 2/10000 {
append using "/Users/fsouza/Dropbox/TAMU/Projects/IPSA_2018/TA/Data/`v'.dta"
}
drop if mean==.
rename mean One_Hundred
egen id=fill(1 2 3)
save "/Users/fsouza/Dropbox/TAMU/Projects/IPSA_2018/TA/Data/One_Hundred.dta", replace
forvalues v = 1/10000 {
capture erase "/Users/fsouza/Dropbox/TAMU/Projects/IPSA_2018/TA/Data/`v'.dta"
}

//1600 observations
clear
set obs 5000
set seed 682941
gen hdi=rexponential(0.66)
save "/Users/fsouza/Dropbox/TAMU/Projects/IPSA_2018/TA/Data/hdi.dta", replace
clear
forvalues v = 1/10000 {
use "/Users/fsouza/Dropbox/TAMU/Projects/IPSA_2018/TA/Data/hdi.dta", clear
sample 1600, count
su hdi
gen mean=.
replace mean=r(mean) if [_n]==1
drop hdi
save "/Users/fsouza/Dropbox/TAMU/Projects/IPSA_2018/TA/Data/`v'.dta", replace
}
clear
use "/Users/fsouza/Dropbox/TAMU/Projects/IPSA_2018/TA/Data/1.dta"
forvalues v = 2/10000 {
append using "/Users/fsouza/Dropbox/TAMU/Projects/IPSA_2018/TA/Data/`v'.dta"
}
drop if mean==.
rename mean Sixteen_Hundred
egen id=fill(1 2 3)
save "/Users/fsouza/Dropbox/TAMU/Projects/IPSA_2018/TA/Data/Sixteen_Hundred.dta", replace
forvalues v = 1/10000 {
capture erase "/Users/fsouza/Dropbox/TAMU/Projects/IPSA_2018/TA/Data/`v'.dta"
}

use "/Users/fsouza/Dropbox/TAMU/Projects/IPSA_2018/TA/Data/Sixteen_Hundred.dta", clear
merge 1:1 id using "/Users/fsouza/Dropbox/TAMU/Projects/IPSA_2018/TA/Data/One_Hundred.dta"
drop _merge
merge 1:1 id using "/Users/fsouza/Dropbox/TAMU/Projects/IPSA_2018/TA/Data/Thirty_Six.dta"
drop _merge
twoway (kdensity Thirty_Six) (kdensity One_Hundred) (kdensity Sixteen_Hundred),  xline(0.66) legend(order(1 "36" 2 "100" 3 "1600") cols(3))
