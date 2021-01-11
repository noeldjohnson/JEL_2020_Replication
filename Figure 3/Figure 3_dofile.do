
ssc install outreg2
ssc install coefplot
use Data_Figure_3.dta


local geo "avtemp15001600 elevation cerealclosest potatolowclosest pastoral_weak_closest dist2AMNB_10 rivers_10 longitude latitude"
local ecogeo "lpop1300 lma1300_speed2_38 DMajorRomRoad_10 DAnyRomRoad_10 DMajRomIntersection_10 DAnyRmRdIntersection_10 dist2landroute_10 dist2landrouteint_10 fair_all HansaFixed aqueduct_10 university"
local pol "monarchy Bcapital representative1300 parliament1300_yn lDParliament dist2bat13001350_100"


reg mortality `geo' `ecogeo' `pol' if year == 1400 & sample == 1, robust
outreg2 * using table2.xls, se tex(landscape) side nocons coefastr dec(2) noni nolabel bracket title(Effect, "") nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append

 coefplot, drop(_cons) xline(0) nolabels
