cd "C:\Users\remij\Desktop\Pandemics JEL 07292020\Replication Files\Figures 4 5 6"

****************
****************
*** FIGURE 4 ***
****************
****************

*****************
*** FIGURE 4A ***
*****************

* Population data from McEvedy and Jones (see text for details).
* Data compiled from the book directly. 
use countrypops, clear
* What is called UK in the data set is "England & Wales" from McEvedy & Jones 
replace countryname = "EnglandWales" if countryname == "United Kingdom"
keep if countryname == "Spain" | countryname == "Italy" | countryname == "The Netherlands" | countryname == "EnglandWales"
replace countryname = "Holland" if countryname == "The Netherlands"
keep if year >= 1200 & year <= 1850
set obs `=_N+1'
replace year = 1350 if year == . 
replace countryname = "EnglandWales" if year == 1350 & countryname == ""
set obs `=_N+1'
replace year = 1350 if year == . 
replace countryname = "Italy" if year == 1350 & countryname == ""
set obs `=_N+1'
replace year = 1350 if year == . 
replace countryname = "Holland" if year == 1350 & countryname == ""
set obs `=_N+1'
replace year = 1350 if year == . 
replace countryname = "Spain" if year == 1350 & countryname == ""
sort countryname year
bysort countryname: replace mortalityc = mortalityc[_n-1] if year == 1350
bysort countryname: replace totpop = totpop[_n-1]*(1-mortalityc) if year == 1350
keep countryname year totpop 
reshape wide totpop, i(year) j(countryname) string
set obs `=_N+1'
replace year = 1250 if year == .
sort year
foreach X in Holland Italy Spain EnglandWales {
ipolate totpop`X' year, gen(totpop`X'_i) 
replace totpop`X' = totpop`X'_i
}
sort year
save totpop1, replace

* Real Wages and GDP data for England (see text for details on sources)
use "GDP_Wages.dta", replace
* We add total population * 
sort year
merge year using totpop1
tab _m
tab year if _m == 2
drop if year == 1200 | year == 1850
drop _m
sort year
* Base 100 in 1347
foreach X in real_wage_london_unskilled gdppc_england {
gen `X'BD = `X' if year == 1347
egen max`X'BD = max(`X'BD)
replace `X' = `X'/max`X'BD*100
sum `X' if year == 1347
}
keep year totpopEnglandWales real_wage_london_unskilled gdppc_england
graph twoway (line totpopEnglandWales year if year<=1800, lcolor(gs8) lwidth(thick) lpattern(longdash) yaxis(1))(lpoly real_wage_london_unskilled year if year<=1800, bw(2) lcolor(black) lwidth(thick) lpattern(solid) yaxis(2))(lpoly gdppc_england year if year<=1800, bw(2) lcolor(black) lwidth(thick) lpattern(dash) yaxis(2)), legend(order(1 "Pop." 2 "Real Wage" 3 "Real Per Cap. GDP") row(1)) xlabel(1250(50)1800) xline(1347, lwidth(medthick) lpattern(longdash) lcolor(gs5)) ytitle(Real Wage / pcGDP (Base 100 1347; Local Polynomial), margin(medsmall) axis(2)) ytitle(Total Population (Millions), axis(1) margin(medsmall)) graphregion(margin(small) fcolor(white) lcolor(white) ifcolor(white) ilcolor(white)) xtitle(.) xtitle(, size(zero) color(none))
graph export figure4a.png, replace width(2620) height(1908)
graph export figure4a.pdf, replace 
graph export figure4a.eps, replace 

*****************
*** FIGURE 4B ***
*****************

* Real Wages and GDP data for Northern Italy (see text for details on sources)
use "GDP_Wages.dta", replace
* We add total population * 
sort year
merge year using totpop1
tab _m
tab year if _m == 2
drop if year == 1200 | year == 1850
drop _m
sort year
* Base 100 in 1347
foreach X in real_wage_nitaly_unskilled gdppc_italy {
gen `X'BD = `X' if year == 1347
egen max`X'BD = max(`X'BD)
replace `X' = `X'/max`X'BD*100
sum `X' if year == 1347
}
keep year totpopItaly real_wage_nitaly_unskilled gdppc_italy 
graph twoway (line totpopItaly year if year<=1800, lcolor(gs8) lwidth(thick) lpattern(longdash) yaxis(1))(lpoly real_wage_nitaly_unskilled year if year<=1800, bw(2) lcolor(black) lwidth(thick) lpattern(solid) yaxis(2))(lpoly gdppc_italy year if year<=1800, bw(2) lcolor(black) lwidth(thick) lpattern(dash) yaxis(2)), legend(order(1 "Pop." 2 "Real Wage" 3 "Real Per Cap. GDP") row(1)) xlabel(1250(50)1800) xline(1347, lwidth(medthick) lpattern(longdash) lcolor(gs5)) ytitle(Real Wage / pcGDP (Base 100 1347; Local Polynomial), margin(medsmall) axis(2)) ytitle(Total Population (Millions), axis(1) margin(medsmall)) graphregion(margin(small) fcolor(white) lcolor(white) ifcolor(white) ilcolor(white)) xtitle(.) xtitle(, size(zero) color(none))
graph export figure4b.png, replace width(2620) height(1908)
graph export figure4b.pdf, replace 
graph export figure4b.eps, replace 

*****************
*** FIGURE 4C ***
*****************

* Real Wages and GDP data for Spain (see text for details on sources)
use "GDP_Wages.dta", replace
* We add total population * 
sort year
merge year using totpop1
tab _m
tab year if _m == 2
drop if year == 1200 | year == 1850
drop _m
sort year
* Base 100 in 1347
foreach X in real_wage_spain gdppc_spain {
gen `X'BD = `X' if year == 1347
egen max`X'BD = max(`X'BD)
replace `X' = `X'/max`X'BD*100
sum `X' if year == 1347
}
graph twoway (line totpopSpain year if year<=1800, lcolor(gs8) lwidth(thick) lpattern(longdash) yaxis(1))(lpoly real_wage_spain year if year<=1800, bw(2) lcolor(black) lwidth(thick) lpattern(solid) yaxis(2))(lpoly gdppc_spain year if year<=1800, bw(2) lcolor(black) lwidth(thick) lpattern(dash) yaxis(2)), legend(order(1 "Pop." 2 "Real Wage" 3 "Real Per Cap. GDP") row(1)) xlabel(1250(50)1800) xline(1347, lwidth(medthick) lpattern(longdash) lcolor(gs5)) ytitle(Real Wage / pcGDP (Base 100 1347; Local Polynomial), margin(medsmall) axis(2)) ytitle(Total Population (Millions), axis(1) margin(medsmall)) graphregion(margin(small) fcolor(white) lcolor(white) ifcolor(white) ilcolor(white)) xtitle(.) xtitle(, size(zero) color(none))
graph export figure4c.png, replace width(2620) height(1908)
graph export figure4c.pdf, replace 
graph export figure4c.eps, replace 

****************
****************
*** FIGURE 5 ***
****************
****************

*****************
*** FIGURE 5A ***
*****************

* Database of interest rates. See text for details on sources. 
import excel "interestrates.xlsx", sheet("Sheet1") firstrow clear
twoway (scatter rate year if City == 1, mcolor(gs4) msize(medsmall) msymbol(circle_hollow)) (scatter rate year if Territorial == 1, mcolor(gs8) msize(small) msymbol(square_hollow)), ytitle(Nominal Interest Rate) ytitle(, margin(small)) xtitle(.) xtitle(, size(zero)) xline(1347, lwidth(medthick) lpattern(longdash) lcolor(gs8)) xlabel(1250(50)1800) legend(order(1 "City-States" 2 "Territorial States")) graphregion(margin(small) fcolor(white) lcolor(white) ifcolor(white) ilcolor(white))
graph export figure5a.png, replace width(2620) height(1908)
graph export figure5a.pdf, replace
graph export figure5a.eps, replace

*****************
*** FIGURE 5B ***
*****************

* Database of returns of capital. See text for details on sources. 
import excel "Table 7 Macroagg.xlsx", sheet("Sheet1") firstrow clear
twoway (connected ReturnCapital Decade, mcolor(black) msize(medium) msymbol(circle) lcolor(black) lwidth(medthick)), ytitle(Estimated Return on Capital (%)) ytitle(, margin(small)) xtitle(.) xtitle(, size(zero) color(none)) xline(1340, lwidth(medthick) lpattern(longdash) lcolor(gs7)) xlabel(1200(50)1850) graphregion(margin(small) fcolor(white) lcolor(white) ifcolor(white) ilcolor(white))
graph export figure5b.png, replace width(2620) height(1908)
graph export figure5b.pdf, replace
graph export figure5b.eps, replace

****************
****************
*** FIGURE 6 ***
****************
****************

* See text for details on sources. 
use "GDP_Wages.dta", replace
graph twoway (connected gdppc_england year if year<=1800, lcolor(black) lpattern(solid) lwidth(medsmall) msymbol(circle) msize(small) mcolor(black)) (line gdppc_holland year if year<=1800, lcolor(black) lpattern(solid) lwidth(medthick))  (line gdppc_italy year if year<=1800, lcolor(gs7) lpattern(solid) lwidth(medthick))(connected gdppc_spain year if year<=1800, lcolor(gs10) lpattern(solid) lwidth(medsmall) msymbol(square) msize(vsmall) mcolor(gs10)), ytitle(Real Per Capita GDP) ytitle(, margin(medsmall)) xtitle(.) xtitle(, size(zero) color(none)) xline(1347, lwidth(medthick) lpattern(longdash) lcolor(gs7)) xlabel(1300(50)1800) graphregion(margin(small) fcolor(white) lcolor(white) ifcolor(white) ilcolor(white)) legend(order(1 "England" 2 "Holland" 3 "Italy" 4 "Spain") row(1))
graph export figure6.png, replace width(2620) height(1908)
graph export figure6.pdf, replace
graph export figure6.eps, replace


