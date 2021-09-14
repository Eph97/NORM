// log handling
cd "~/Documents/IPA"
cls
log using power_calculations.log, name(power_calculations) replace

// estimated using 2 week interval between Thursday September 9th and Thursday August 26th of change in number of first doses administered
// Using two week interval estimated baseline = (550694661-468130627)/1.366 billion (2019 population)
local basline = 0.06

//scenario 1
// Assumed baseline of 0.025 however I found baseline to be closer to 6%
foreach i in 0.03 0.05 0.1 0.2 {
	power twoproportions `basline', diff(`i')
}

// Scenario 2
// let var(between) = (0.05)^2 = 0.0025
// let var(within) = 0.025 x (1-0.025) = (0.025 x 0.975) = 0.024
//asssuming ICC = rho = var(between)/(var(between) + var(within)) = 0.0025/(0.024 + 0.0025) = 0.09434

foreach i in 0.03 0.05 0.1 {
	power twoproportions `basline', diff(`i') m1(1500) m2(1500) rho(0.09434)
}


// now let var(between) = (0.025)^2 = 0.000625
// let var(within) = 0.025 x (1-0.025) = (0.025 x 0.975) = 0.024
//ICC_v2 = 0.000625/(.024 + 0.000625) = 0.02538 

foreach i in 0.03 0.05 0.1 {
	power twoproportions `basline', diff(`i') m1(1500) m2(1500) rho(0.02538)
}

// log commands
log close power_calculations
translate power_calculations.log power_calculations.pdf, replace
