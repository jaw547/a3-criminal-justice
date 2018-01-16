//Set Command Directory, Create a log (replaces old version) and use the dataset, set autotabgraphs
	cd "C:\Users\Michael Ho\Documents\HGSE\Fall 2017 Courses\DPI 691MA Programming and Data for Policymakers"
	capture log close
	log using "C:\Users\Michael Ho\Documents\HGSE\Fall 2017 Courses\DPI 691MA Programming and Data for Policymakers\Final.log", replace
	use "CRDC201314", clear

//Do some necessary graph cleaning and prepping
	set autotabgraphs on
	clear matrix
	
//Label Initial Variables used
	label var tot_enr_m "Total Males Enrolled"
	label var tot_enr_f	"Total Females Enrolled"
	label var sch_hballegations_rac "Bullying allegations - Race"
	
//Inefficiently change string values to new numeric values for school type
	generate sch_sped = sch_status_sped =="YES"
	generate sch_magnet = sch_status_magnet =="YES"
	generate sch_charter = sch_status_charter =="YES"
	generate sch_alt = sch_status_alt =="YES"
	generate sch_trad = sch_status_sped == "NO" & sch_status_alt == "NO" & sch_status_magnet == "NO" & sch_status_charter == "NO"
		
	generate sch_type = .
	label var sch_type "School Type (1=Trad;2=Sped;3=Charter;4=Magnet;5=Alt)"
	replace sch_type = 1 if sch_trad==1
	replace sch_type = 2 if sch_sped==1
	replace sch_type = 3 if sch_charter==1
	replace sch_type = 4 if sch_magnet==1
	replace sch_type = 5 if sch_alt==1
		
	label var sch_sped "SPED School"
	label var sch_magnet "Magnet School"
	label var sch_charter "Charter School"
	label var sch_alt "Alternative School"
	label var sch_trad "Traditional School"
	
//Generate aggregate variables and log versions
	gen TOTAL_BULLY = sch_hballegations_sex + sch_hballegations_rac + sch_hballegations_dis
	gen TOTAL_ENROLLED = tot_enr_m + tot_enr_f
	
//Generate race bully percentage aggregates by category for mapping	
	gen race_bully_percent = sch_hballegations_rac/TOTAL_ENROLLED
	gen race_bully_male = tot_hbreported_rac_m/tot_enr_m
	gen race_bully_female = tot_hbreported_rac_f/tot_enr_f
	gen race_bully_LEP_male = sch_hbreported_rac_lep_m/sch_enr_lep_m
	gen race_bully_LEP_female = sch_hbreported_rac_lep_f/sch_enr_lep_f
	gen race_bully_IDEA_male = sch_hbreported_rac_idea_m/sch_enr_idea_m
	gen race_bully_IDEA_female = sch_hbreported_rac_idea_f/sch_enr_idea_f
	gen race_bully_504_male = sch_hbreported_rac_504_m/sch_enr_504_m
	gen race_bully_504_female = sch_hbreported_rac_504_f/sch_enr_504_f

//Race bully precentages by gender and ethnicity
	gen race_hs_male_percent = sch_hbreported_rac_hi_m/sch_enr_hi_m
	gen race_hs_female_percent = sch_hbreported_rac_hi_f/sch_enr_hi_f
	gen race_ai_male_percent = sch_hbreported_rac_am_m/sch_enr_am_m
	gen race_ai_female_percent = sch_hbreported_rac_am_f/sch_enr_am_f
	gen race_as_male_percent = sch_hbreported_rac_as_m/sch_enr_as_m
	gen race_as_female_percent = sch_hbreported_rac_as_f/sch_enr_as_f
	gen race_nh_male_percent = sch_hbreported_rac_hp_m/sch_enr_hp_m
	gen race_nh_female_percent = sch_hbreported_rac_hp_f/sch_enr_hp_f
	gen race_black_male_percent = sch_hbreported_rac_bl_m/sch_enr_bl_m
	gen race_black_female_percent = sch_hbreported_rac_bl_f/sch_enr_bl_f
	gen race_white_male_percent = sch_hbreported_rac_wh_m/sch_enr_wh_m
	gen race_white_female_percent = sch_hbreported_rac_wh_f/sch_enr_wh_f
	gen race_multi_male_percent = sch_hbreported_rac_tr_m/sch_enr_tr_m
	gen race_multi_female_percent = sch_hbreported_rac_tr_f/sch_enr_tr_f

// Clean Total Absent Numbers
	replace tot_absent_m = 0 if tot_absent_m<0
	replace tot_absent_f = 0 if tot_absent_f<0
	
	gen TOTAL_ABSENT = (tot_absent_m+tot_absent_f)/TOTAL_ENROLLED
	
//Fix retained numbers where -9 indicates 0 and generate total retained metric
	replace tot_ret_kg_m =0 if tot_ret_kg_m<0
	replace tot_ret_kg_f =0 if tot_ret_kg_f<0
	replace tot_ret_g01_m =0 if tot_ret_g01_m<0
	replace tot_ret_g01_f =0 if tot_ret_g01_f<0
	replace tot_ret_g02_m =0 if tot_ret_g02_m<0
	replace tot_ret_g02_f =0 if tot_ret_g02_f<0
	replace tot_ret_g03_m =0 if tot_ret_g03_m<0
	replace tot_ret_g03_f =0 if tot_ret_g03_f<0
	replace tot_ret_g04_m =0 if tot_ret_g04_m<0
	replace tot_ret_g04_f =0 if tot_ret_g04_f<0
	replace tot_ret_g05_m =0 if tot_ret_g05_m<0
	replace tot_ret_g05_f =0 if tot_ret_g05_f<0
	replace tot_ret_g06_m =0 if tot_ret_g06_m<0
	replace tot_ret_g06_f =0 if tot_ret_g06_f<0
	replace tot_ret_g07_m =0 if tot_ret_g07_m<0
	replace tot_ret_g07_f =0 if tot_ret_g07_f<0
	replace tot_ret_g08_m =0 if tot_ret_g08_m<0
	replace tot_ret_g08_f =0 if tot_ret_g08_f<0
	replace tot_ret_g09_m =0 if tot_ret_g09_m<0
	replace tot_ret_g09_f =0 if tot_ret_g09_f<0
	replace tot_ret_g10_m =0 if tot_ret_g10_m<0
	replace tot_ret_g10_f =0 if tot_ret_g10_f<0
	replace tot_ret_g11_m =0 if tot_ret_g11_m<0
	replace tot_ret_g11_f =0 if tot_ret_g11_f<0
	replace tot_ret_g12_m =0 if tot_ret_g12_m<0
	replace tot_ret_g12_f =0 if tot_ret_g12_f<0

	gen TOTAL_RETAINED = (tot_ret_kg_m + tot_ret_kg_f + tot_ret_g01_m + tot_ret_g01_f  + tot_ret_g02_m + tot_ret_g02_f ///
		 + tot_ret_g03_m + tot_ret_g03_f + tot_ret_g04_m + tot_ret_g04_f + tot_ret_g05_m + tot_ret_g05_f ///
		 + tot_ret_g06_m + tot_ret_g06_f  + tot_ret_g07_m + tot_ret_g07_f  + tot_ret_g08_m + tot_ret_g08_f ///
		 + tot_ret_g09_m + tot_ret_g09_f + tot_ret_g10_m + tot_ret_g10_f + tot_ret_g11_m + tot_ret_g11_f ///
		 + tot_ret_g12_m + tot_ret_g12_f)/TOTAL_ENROLLED
		
//Generate each race variable
	gen HISPANIC = (sch_enr_hi_m + sch_enr_hi_f)/TOTAL_ENROLLED
	gen AMINDIAN = (sch_enr_am_m + sch_enr_am_f)/TOTAL_ENROLLED
	gen ASIAN = (sch_enr_as_m + sch_enr_as_f)/TOTAL_ENROLLED
	gen HAWAIIAN = (sch_enr_hp_m + sch_enr_hp_f)/TOTAL_ENROLLED
	gen BLACK = (sch_enr_bl_m + sch_enr_bl_f)/TOTAL_ENROLLED
	gen WHITE = (sch_enr_wh_m + sch_enr_wh_f)/TOTAL_ENROLLED
	
//Drop bad data
	drop if TOTAL_ENROLLED <= 0
	drop if ASIAN<0
	drop if PPE<1
	drop if TOTAL_ABSENT > 1
