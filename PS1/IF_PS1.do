* import data
cd "/Users/changjay/Desktop/International Finance/PS1/"
import delimited "IF_1.3.csv", varnames(1) numericcols(5 6 7 8) clear
keep if seriesname == "Gross domestic savings (% of GDP)" | seriesname == "Gross fixed capital formation (% of GDP)"
drop seriescode
save "IF_1.3.dta", replace

* clean data
cd "/Users/changjay/Desktop/International Finance/PS1/"
use "IF_1.3.dta", clear
reshape long yr, i(countryname countrycode seriesname) j(year)
rename yr variable_
replace seriesname = "SAV" if seriesname == "Gross domestic savings (% of GDP)"
replace seriesname = "INV" if seriesname == "Gross fixed capital formation (% of GDP)"
reshape wide variable, i(countryname countrycode year) j(seriesname) string

* scatter plot
graph twoway (scatter variable_SAV variable_INV if year == 1960, msize(medsmall)) ///
(lfit variable_SAV variable_INV), ///
legend (label(1 "SAV") label(2 "Fitted Regression Line")) title("1960 SAV-INV Scatter Plot with fitted line") ytitle("Gross domestic savings") xtitle("Gross fixed capital formation")
graph export "1960.png", replace

graph twoway (scatter variable_SAV variable_INV if year == 1980, msize(medsmall)) ///
(lfit variable_SAV variable_INV), ///
legend (label(1 "SAV") label(2 "Fitted Regression Line")) title("1980 SAV-INV Scatter Plot with fitted line") ytitle("Gross domestic savings") xtitle("Gross fixed capital formation")
graph export "1980.png", replace

graph twoway (scatter variable_SAV variable_INV if year == 2000, msize(medsmall)) ///
(lfit variable_SAV variable_INV), ///
legend (label(1 "SAV") label(2 "Fitted Regression Line")) title("2000 SAV-INV Scatter Plot with fitted line") ytitle("Gross domestic savings") xtitle("Gross fixed capital formation")
graph export "2000.png", replace

graph twoway (scatter variable_SAV variable_INV if year == 2019, msize(medsmall)) ///
(lfit variable_SAV variable_INV), ///
legend (label(1 "SAV") label(2 "Fitted Regression Line")) title("2019 SAV-INV Scatter Plot with fitted line") ytitle("Gross domestic savings") xtitle("Gross fixed capital formation")
graph export "2019.png", replace

* correlation
correlate variable_SAV variable_INV if year == 1960
correlate variable_SAV variable_INV if year == 1980
correlate variable_SAV variable_INV if year == 2000
correlate variable_SAV variable_INV if year == 2019

* regression
reg variable_SAV variable_INV if year == 1960, vce(robust)
eststo reg_1960
reg variable_SAV variable_INV if year == 1980, vce(robust)
eststo reg_1980
reg variable_SAV variable_INV if year == 2000, vce(robust)
eststo reg_2000
reg variable_SAV variable_INV if year == 2019, vce(robust)
eststo reg_2019
esttab reg_1960 reg_1980 reg_2000 reg_2019 using "regression.tex", b se ar2 mtitle replace














