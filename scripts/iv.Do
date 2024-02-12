use "C:\Users\52998\Desktop\LongTermEffectSlavery\data\slave_trade_QJE.dta" 

// Model 1
ivregress 2sls ln_maddison_pcgdp2000 (ln_export_area = atlantic_distance_minimum indian_distance_minimum saharan_distance_minimum red_sea_distance_minimum), vce(robust)
estimates store Model1

// Model 2
ivregress 2sls ln_maddison_pcgdp2000 (ln_export_area = atlantic_distance_minimum indian_distance_minimum saharan_distance_minimum red_sea_distance_minimum) colony0 colony1 colony2 colony3 colony4 colony5 colony6 colony7, vce(robust)
estimates store Model2

// Model 3
ivregress 2sls ln_maddison_pcgdp2000 (ln_export_area = atlantic_distance_minimum indian_distance_minimum saharan_distance_minimum red_sea_distance_minimum) colony0 colony1 colony2 colony3 colony4 colony5 colony6 colony7 abs_latitude longitude rain_min humid_max low_temp ln_coastline_area, vce(robust)
estimates store Model3

* Make a copy of the current dataset in memory
preserve

* Drop observations from the specified countries
drop if country == "Morocco" | country == "Algeria" | country == "Tunisia" | country == "Libya" | country == "Egypt" | country == "Seychelles" | country == "Mauritius" | country == "Comoros" | country == "Sao Tome & Principe" | country == "Cape Verde Islands"

// Model 4
ivregress 2sls ln_maddison_pcgdp2000 (ln_export_area = atlantic_distance_minimum indian_distance_minimum saharan_distance_minimum red_sea_distance_minimum) colony0 colony1 colony2 colony3 colony4 colony5 colony6 abs_latitude longitude rain_min humid_max low_temp ln_coastline_area, vce(robust)
estimates store Model4

* Restore the original dataset
restore

// Display Results
esttab Model1 Model2 Model3 Model4 using "my_iv_results.txt", replace se

//Model A
regress ln_export_area atlantic_distance_minimum indian_distance_minimum saharan_distance_minimum red_sea_distance_minimum
estimates store FSModel1

//Model B
regress ln_export_area atlantic_distance_minimum indian_distance_minimum saharan_distance_minimum red_sea_distance_minimum colony0 colony1 colony2 colony3 colony4 colony5 colony6 colony7
estimates store FSModel2

//Model C
regress ln_export_area atlantic_distance_minimum indian_distance_minimum saharan_distance_minimum red_sea_distance_minimum colony0 colony1 colony2 colony3 colony4 colony5 colony6 colony7 abs_latitude longitude rain_min humid_max low_temp ln_coastline_area
estimates store FSModel3

* Make a copy of the current dataset in memory
preserve

* Drop observations from the specified countries
drop if country == "Morocco" | country == "Algeria" | country == "Tunisia" | country == "Libya" | country == "Egypt" | country == "Seychelles" | country == "Mauritius" | country == "Comoros" | country == "Sao Tome & Principe" | country == "Cape Verde Islands"

// Model 4
regress ln_export_area atlantic_distance_minimum indian_distance_minimum saharan_distance_minimum red_sea_distance_minimum colony0 colony1 colony2 colony3 colony4 colony5 colony6 colony7 abs_latitude longitude rain_min humid_max low_temp ln_coastline_area
estimates store FSModel4

* Restore the original dataset
restore

esttab FSModel1 FSModel2 FSModel3 FSModel4 using "first_stage_results.txt", replace se





