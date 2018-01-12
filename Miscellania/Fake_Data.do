*     ******************************************************************** *
*     ******************************************************************** *
*       File-Name:      Fake_Data.do                                       *
*       Date:           01/12/2018                                         *
*       Last Update:    01/12/2018                                         *
*       Author:         Flavio D.S. Souza                                  *
*       Email Address:  fsouza@tamu.edu                                    *
*       Purpose:        Reproducing Leonardo Barone's "Fake Data" R Script *
*       Input File:     none                                               *
*       Output File:    none                                               *
*       Data Output:    various	                                           *
*       Previous file:  None                                               *
*       Machine:        MacBook                                            *
*     *******************************************************************  *
*     *******************************************************************  *
clear

set seed 3697560

set obs 30

gen age=int(rnormal(35,5))

set seed 267

gen sex_i=rbinomial(1,0.4)
gen sex=.
tostring sex, replace
replace sex="Male" if sex_i==1
replace sex="Female" if sex_i==0
drop sex_i

gen educ=.
gen id=_n
tostring educ, replace
replace educ="No High School Degree" if id<=3
replace educ="High School Degree" if id>3 & id<=15
replace educ="College Incomplete" if id>15 & id<=21
replace educ="College Degree or more" if id>21 & id<=30
drop id

capture program drop randomsort //This command is to 'randomly' sort the new variable
program randomsort
set seed 252638
tempvar sortorder
gen `sortorder' = runiform()
sort `sortorder'
end

randomsort

gen inc=round(rpoisson(1)*2000+rnormal(500,300),0.01)

gen savings=round(rpoisson(1)*10000+rnormal(5000,300),0.01)

gen marriage=.
gen id=_n
tostring marriage, replace
replace marriage="Yes" if id<=15
replace marriage="No" if id>15
drop id

randomsort

gen kids=.
gen id=_n
replace kids=0 if id<=15
replace kids=1 if id>15 & id<=22.5
replace kids=2 if id>22.5 &  id<=28.5
tostring kids, replace
replace kids="more" if id>28.5
drop id

randomsort

gen party=.
gen id=_n
tostring party, replace
replace party="Conservative Party" if id<=6
replace party="Socialist Party" if id>6 & id<=12
replace party="Independent" if id>12
drop id

randomsort

gen turnout=.
gen id=_n
tostring turnout, replace
replace turnout="Yes" if id<=15
replace turnout="No" if id>15
drop id

randomsort

gen vote_history=.
gen id=_n
replace vote_history=0 if id<=9
replace vote_history=1 if id>9 & id<=12
replace vote_history=2 if id>12 & id<=15
replace vote_history=3 if id>15 & id<=21
replace vote_history=4 if id>21
drop id

randomsort

gen economy=.
gen id=_n
tostring economy, replace
replace economy="Very Good" if id<=1.5
replace economy="Good" if id>1.5 & id<=6
replace economy="About average" if id>6 & id<=15
replace economy="Bad" if id>15 & id<=24
replace economy="Very Bad" if id>24 & id<=28.5
replace economy="Don't know" if id>28.5
drop id

randomsort

gen incumbent=.
gen id=_n
tostring incumbent, replace
replace incumbent="Very Good" if id<=6
replace incumbent="Good" if id>6 & id<=12
replace incumbent="About average" if id>12 & id<=18
replace incumbent="Bad" if id>18 & id<=24
replace incumbent="Very Bad" if id>24 & id<=28.5
replace incumbent="Don't know" if id>28.5
drop id

randomsort

gen candidate=.
gen id=_n
tostring candidate, replace
replace candidate="Trampi" if id<=12
replace candidate="Rilari" if id>12 & id<=24
replace candidate="Other" if id>24 & id<=27
replace candidate="None" if id>27
drop id

randomsort

export delimited using "/Users/fsouza/Dropbox/TAMU/Projects/IPSA_2018/TA/Data/fake_data.csv", ///
	delimiter(";") quote replace
