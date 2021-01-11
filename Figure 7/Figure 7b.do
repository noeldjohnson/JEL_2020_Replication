cd "/Users/noeljohnson/Dropbox/Research/Plague City Growth/JEL Symposium/Replication Files/Figure 7"


****************
** FIGURE 7b ***
****************

* Data set created for Figures 7a and 7b using R. Code is in file "BD_Figure_7ab.R" in folder "Figure 7".
use "boundaries_400km.dta", clear
gen temp=area/1000000
drop area
rename temp area
gen sov13001500 = bordercount_1500-bordercount_1300
gen sov13001700 = bordercount_1700-bordercount_1300
gen sov15001700 = bordercount_1700-bordercount_1500
reg sov13001500 area bordercount_1300
predict sov13001500_res, r
reg pred_mortality area bordercount_1300
predict pred_mortality_res, r
reg sov13001500_res pred_mortality_res
reg sov13001700 area bordercount_1300
predict sov13001700_res, r
reg sov13001700_res pred_mortality_res
graph twoway (lpoly sov13001700_res pred_mortality_res, bw(7)) (lpoly sov13001500_res pred_mortality_res, bw(7))
* We modify manually
graph use "figure7b.gph"