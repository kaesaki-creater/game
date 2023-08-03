*0. Run this section before you run any analysis
	// define folder
	global work "YOUR FOLDER"

	use "$work/data.dta", clear
	
	//
	global job student spouse self part unemployed
	global marital2 married2 havechild2 divorce2
	global jobind job4r_1 job4r_2 job4r_3 job4r_4 job4r_5 job4r_6 job4r_7 job4r_8 job4r_9 job4r_10 job4r_11 job4r_12 job4r_13
	global guess guess_1 guess_2 guess_3 guess_4 guess_5
	global round round_1 round_2 round_3 round_4 round_5	
	
	/
	
	//
	/*
	Notes on variable names.
	
	1. njoin_member is the number of times joining game console lotteries.
	
	2. guess_1 guess_2 guess_3 guess_4 guess_5 are the five dummies of gaming preferenecs.
	
	3. marital_1 married or not.
		marital_2 had child or not.
		marital_3 divorced or not.
	
	4. jobind: dummies of job industry variables.	
	
	5. win: dummy of winning a game console lottery.
	
	6. pref: dummies of prefecture of residence.
		round: dummies of survey rounds.
	
	7. happiness: SWLS
		k6: K6.
	
	8. lottery: dummy indicating joining game console lotteries.
	
	9. other variables.
		age: age
		gender: male=1
		
	10. game engagement variables
		switch: Nintendo Switch Ownership.
		play1m_switch: Nintendo Switch Usage over the last 30 days.
		ps5: PS5 Ownership
		play1m_ps5: PS5 Usage over the last 30 days.
		averageplaytime1: Time spent playing video games.
		
	11. round and round_*: survey rounds.	
	
	*/


*1. Figure 1

	*The estimates for eFigures 4-8 are also conducted.
	
	*(1) Regressions
	
	*Note. Column (2), (4), (6) are used in Figure 1.
	
					//preparation for outreg2
					local save "/figures/all/reg1"					
					capture erase "$work/figures/all/reg1.txt"				
			
					*1. k6
					local outcome k6			

					//Switch
					reghdfe `outcome' win if lottery == 1 & inrange(round,1,1), absorb(pref) vce(cluster pref)
						local coef=round(el(r(table),1,1),.000001)
						local se=round(el(r(table),2,1),.000001)
						sum `outcome' if e(sample) == 1
						local mean = round(r(mean),.001)
						local sd = round(r(sd),.001)						
						local temp1 = `coef' / `sd'
						local temp2 = `se' / `sd'
						local standcoef = round(`temp1',.0001)
						local standse = round(`temp2',.0001)
						
						outreg2 using "$work`save'.xls", dec(3) fmt(gc) addtext(Controls, No, Prefecture FE, Yes, Mean, "`mean'", SD, "`sd'", Coef, "`coef'", SE, "`se'", Standardized Coef, "`standcoef'", Standardized SE, "`standse'", Lottery, Switch) keep(win) nocon label nonotes append						
						
					reghdfe `outcome' win njoin_member guess_2 guess_3 guess_4 guess_5 age gender $job $marital2 $jobind if lottery == 1 & inrange(round,1,1), absorb(pref) vce(cluster pref)
						local coef=round(el(r(table),1,1),.000001)
						local se=round(el(r(table),2,1),.000001)
						local temp1 = `coef' / `sd'
						local temp2 = `se' / `sd'
						local standcoef = round(`temp1',.0001)
						local standse = round(`temp2',.0001)				
						outreg2 using "$work`save'.xls", dec(3) fmt(gc) addtext(Controls, Yes, Prefecture FE, Yes, Mean, "`mean'", SD, "`sd'", Coef, "`coef'", SE, "`se'", Standardized Coef, "`standcoef'", Standardized SE, "`standse'", Lottery, Switch) keep(win njoin_member) nocon label nonotes append
					
					//PS5
					reghdfe `outcome' win i.round if lottery == 1 & inrange(round,2,5), absorb(pref) vce(cluster pref)
						local coef=round(el(r(table),1,1),.000001)
						local se=round(el(r(table),2,1),.000001)
						sum `outcome' if e(sample) == 1
						local mean = round(r(mean),.001)
						local sd = round(r(sd),.001)						
						local temp1 = `coef' / `sd'
						local temp2 = `se' / `sd'
						local standcoef = round(`temp1',.0001)
						local standse = round(`temp2',.0001)
						
						outreg2 using "$work`save'.xls", dec(3) fmt(gc) addtext(Controls, No, Prefecture FE, Yes, Mean, "`mean'", SD, "`sd'", Coef, "`coef'", SE, "`se'", Standardized Coef, "`standcoef'", Standardized SE, "`standse'", Lottery, PS5) keep(win) nocon label nonotes append		
						
					reghdfe `outcome' win i.round njoin_member guess_2 guess_3 guess_4 guess_5 age gender $job $marital2 $jobind if lottery == 1 & inrange(round,2,5), absorb(pref) vce(cluster pref)
						local coef=round(el(r(table),1,1),.000001)
						local se=round(el(r(table),2,1),.000001)
						local temp1 = `coef' / `sd'
						local temp2 = `se' / `sd'
						local standcoef = round(`temp1',.0001)
						local standse = round(`temp2',.0001)
						outreg2 using "$work`save'.xls", dec(3) fmt(gc) addtext(Controls, Yes, Prefecture FE, Yes, Mean, "`mean'", SD, "`sd'", Coef, "`coef'", SE, "`se'", Standardized Coef, "`standcoef'", Standardized SE, "`standse'", Lottery, PS5) keep(win njoin_member) nocon label nonotes append						
						
					*2. happiness	
					local outcome happiness			

					reghdfe `outcome' win if lottery == 1, absorb(pref) vce(cluster pref)
						local coef=round(el(r(table),1,1),.000001)
						local se=round(el(r(table),2,1),.000001)
						sum `outcome' if e(sample) == 1
						local mean = round(r(mean),.001)
						local sd = round(r(sd),.001)						
						local temp1 = `coef' / `sd'
						local temp2 = `se' / `sd'
						local standcoef = round(`temp1',.0001)
						local standse = round(`temp2',.0001)
						
						outreg2 using "$work`save'.xls", dec(3) fmt(gc) addtext(Controls, No, Prefecture FE, Yes, Mean, "`mean'", SD, "`sd'", Coef, "`coef'", SE, "`se'", Standardized Coef, "`standcoef'", Standardized SE, "`standse'", Lottery, PS5) keep(win) nocon label nonotes append				
								
					reghdfe `outcome'  win i.round njoin_member guess_2 guess_3 guess_4 guess_5 age gender $job $marital2 $jobind if lottery == 1, absorb(pref) vce(cluster pref)
						local coef=round(el(r(table),1,1),.000001)
						local se=round(el(r(table),2,1),.000001)
						local temp1 = `coef' / `sd'
						local temp2 = `se' / `sd'
						local standcoef = round(`temp1',.0001)
						local standse = round(`temp2',.0001)
						
						outreg2 using "$work`save'.xls", dec(3) fmt(gc) addtext(Controls, No, Prefecture FE, Yes, Mean, "`mean'", SD, "`sd'", Coef, "`coef'", SE, "`se'", Standardized Coef, "`standcoef'", Standardized SE, "`standse'", Lottery, PS5) keep(win njoin_member) nocon label nonotes append	
						
						
	*(2) PSM	
	
	*****CAUTION******************************************************************
	*The PSM algorithm for selecting variables is time consuming and requires a high-performance computer.
	******************************************************************************
	
	
	**********************************		
	//Following Imbens (2015)
	**********************************	
	
	**********************************	
	*A. PSM Estimation for PS5 (R2-R5)
	**********************************		
	
	//1. Preparation for trimming: selecting variables
	
		//To save your time, skip psestimate
		psestimate win if inlist(round,2,3,4,5), totry(age gender $marital2 $job $guess $jobind njoin_member round_*)
		
		//First
		/*
		Result: 
		Selected first order covariates are: njoin_member round_2 part job4r_3 spouse job4r_1 guess_4 job4r_7 unemployed self age job4r_5 job4r_9 job4r_2 round_5
		Selected second order covariates are: c.njoin_member#c.njoin_member c.job4r_3#c.round_2 c.job4r_7#c.njoin_member c.job4r_2#c.round_2 c.round_5#c.self c.job4r_5#c.round_2 c.guess_4#c.spouse c.age#c.spouse c.job4r_3#c.part c.job4r_9#c.self c.job4r_9#c.njoin_member c.age#c.njoin_member
		*/
	
		gen interaction1 = c.njoin_member#c.njoin_member
		gen interaction2 = c.job4r_3#c.round_2
		gen interaction3 = c.job4r_7#c.njoin_member
		gen interaction4 = c.job4r_2#c.round_2
		gen interaction5 = c.round_5#c.self
		gen interaction6 = c.job4r_5#c.round_2
		gen interaction7 = c.guess_4#c.spouse
		gen interaction8 = c.age#c.spouse
		gen interaction9 = c.job4r_3#c.part
		gen interaction10 = c.job4r_9#c.self 
		gen interaction11 = c.job4r_9#c.njoin_member
		gen interaction12 = c.age#c.njoin_member
		
		global first njoin_member round_2 part job4r_3 spouse job4r_1 guess_4 job4r_7 unemployed self age job4r_5 job4r_9 job4r_2 round_5
		global imbens $first interaction*
		
		psmatch2 win $imbens if lottery == 1 & inlist(round,2,3,4,5), out(k6 happiness) common noreplacement descending logit		
	
	//2. Trimming
		drop if !inrange(_pscore,0.1,0.9) & !mi(_pscore)
		
	//3. Running PSM to estimate causal effects: begin with selecting variables
	
		//To save your time, skip psestimate	
		psestimate win if inlist(round,2,3,4,5), totry(age gender $marital2 $job $guess $jobind njoin_member round_*)	
	
		//Second
		/*
		Result: 
		Selected first order covariates are: njoin_member round_2 part job4r_3 guess_4 spouse job4r_1 job4r_7 unemployed self job4r_5 age round_5
		Selected second order covariates are: c.njoin_member#c.njoin_member c.job4r_3#c.round_2 c.round_5#c.self c.job4r_7#c.njoin_member c.job4r_5#c.round_2 c.spouse#c.guess_4 c.age#c.spouse c.job4r_3#c.part	
		*/
		drop interaction*
		gen interaction1 = c.njoin_member#c.njoin_member
		gen interaction2 = c.job4r_3#c.round_2 
		gen interaction3 = c.round_5#c.self
		gen interaction4 = c.job4r_7#c.njoin_member
		gen interaction5 = c.job4r_5#c.round_2
		gen interaction6 = c.spouse#c.guess_4
		gen interaction7 = c.age#c.spouse
		gen interaction8 = c.job4r_3#c.part
		
		global first njoin_member round_2 part job4r_3 guess_4 spouse job4r_1 job4r_7 unemployed self job4r_5 age round_5		
				
		global imbens $first interaction*		
	
	//4. Running PSM to estimate causal effects	
		local excel psmR2_R5
		
		//psmatch2 #1
		set seed 1
		psmatch2 win $imbens if lottery == 1 & inlist(round,2,3,4,5), out(k6 happiness) ate ties logit ai(2) neighbor(2)
		
			scalar att_k6 = r(att_k6)
			scalar att_happiness = r(att_happiness)
			scalar seatt_k6 = r(seatt_k6)
			scalar seatt_happiness = r(seatt_happiness)
			
			scalar ate_k6 = r(ate_k6)
			scalar ate_happiness = r(ate_happiness)
			scalar seate_k6 = r(seate_k6)
			scalar seate_happiness = r(seate_happiness)
			
			sum k6 if e(sample) == 1
			scalar mean1 = r(mean)
			scalar sd1 = r(sd)
			sum happiness if e(sample) == 1
			scalar mean2 = r(mean)
			scalar sd2 = r(sd)
			
			//matrix M = r(table)
			putexcel set "$work/figures/all/`excel'", replace
			putexcel A2 = "ATT"
			putexcel A3 = "SE"
			putexcel A4 = "Mean"
			putexcel A5 = "SD"
			putexcel A6 = "Standardized ATT"
			putexcel A7 = "Standardized SE"
			
			putexcel A8 = "ATE"
			putexcel A9 = "SE of ATE"
			putexcel A10 = "Standardized ATE"
			putexcel A11 = "Standardized SE"
			
			putexcel B1 = "k6"
			putexcel C1 = "happiness"
			
			putexcel D1 = "Option of psmatch2"
			putexcel D2 = "ate ties logit ai(2) neighbor(2)"
			
			scalar stand_att1 = att_k6 / sd1
			scalar stand_att2 = att_happiness / sd2
			scalar stand_seatt1 = seatt_k6 / sd1
			scalar stand_seatt2 = seatt_happiness / sd2
			scalar stand_ate1 = ate_k6 / sd1
			scalar stand_ate2 = ate_happiness / sd2
			scalar stand_seate1 = seate_k6 / sd1
			scalar stand_seate2 = seate_happiness / sd2			
			
			matrix result = (att_k6,att_happiness\seatt_k6,seatt_happiness\mean1,mean2\sd1,sd2\stand_att1,stand_att2\stand_seatt1,stand_seatt2\ate_k6,ate_happiness\seate_k6,seate_happiness\stand_ate1,stand_ate2\stand_seate1,stand_seate2)
			matrix list result
			putexcel B2 = matrix(result)
		
		psgraph, graphregion(color(white)) ytitle(Density)
		graph save "Graph" "$work\figures\all\overlap_`excel'_neighbor2.gph", replace
		graph export "$work\figures\all\overlap_`excel'_neighbor2.png", as(png) name("Graph") replace	width(2000)	
		pstest $imbens, graph both label ylabel(,labsize(vsmall)) graphregion(color(white))
		gr_edit .grpaxis.style.editstyle majorstyle(tickstyle(show_labels(yes))) editcopy 
		gr_edit .grpaxis.style.editstyle majorstyle(tickstyle(textstyle(size(vsmall)))) editcopy
		
		graph save "Graph" "$work\figures\all\balance_`excel'_neighbor2.gph", replace
		graph export "$work\figures\all\balance_`excel'_neighbor2.png", as(png) name("Graph") replace	width(2000)
		
		//psmatch2 #2
		//local excel psmR2_R5		
		set seed 1
		psmatch2 win $imbens if lottery == 1 & inlist(round,2,3,4,5), out(k6 happiness) common descending logit noreplacement ai(2)
			scalar att_k6 = r(att_k6)
			scalar att_happiness = r(att_happiness)
			scalar seatt_k6 = r(seatt_k6)
			scalar seatt_happiness = r(seatt_happiness)
			
			sum k6 if e(sample) == 1
			scalar mean1 = r(mean)
			scalar sd1 = r(sd)
			sum happiness if e(sample) == 1
			scalar mean2 = r(mean)
			scalar sd2 = r(sd)
			
			//matrix M = r(table)
			putexcel set "$work/figures/all/`excel'", modify //, replace
			putexcel A12 = "ATT"
			putexcel A13 = "SE"
			putexcel A14 = "Mean"
			putexcel A15 = "SD"
			putexcel A16 = "Standardized ATT"
			putexcel A17 = "Standardized SE"
			
			putexcel D12 = "common descending logit noreplacement ai(2)"			
			
			scalar stand_att1 = att_k6 / sd1
			scalar stand_att2 = att_happiness / sd2
			scalar stand_seatt1 = seatt_k6 / sd1
			scalar stand_seatt2 = seatt_happiness / sd2		
			
			matrix result2 = (att_k6,att_happiness\seatt_k6,seatt_happiness\mean1,mean2\sd1,sd2\stand_att1,stand_att2\stand_seatt1,stand_seatt2)
			putexcel B12 = matrix(result2)		
			
			psgraph, graphregion(color(white)) ytitle(Density)
			graph save "Graph" "$work\figures\all\overlap_`excel'_noreplacement.gph", replace
			graph export "$work\figures\all\overlap_`excel'_noreplacement.png", as(png) name("Graph") replace	width(2000)	
			pstest $imbens, graph both label ylabel(,labsize(vsmall)) graphregion(color(white))
			gr_edit .grpaxis.style.editstyle majorstyle(tickstyle(show_labels(yes))) editcopy 
			gr_edit .grpaxis.style.editstyle majorstyle(tickstyle(textstyle(size(vsmall)))) editcopy
			
			graph save "Graph" "$work\figures\all\balance_`excel'_noreplacement.gph", replace
			graph export "$work\figures\all\balance_`excel'_noreplacement.png", as(png) name("Graph") replace	width(2000)					
			
		//psmatch2 #3 1:1 match
		//local excel psmR2_R5		
		set seed 1
		psmatch2 win $imbens if lottery == 1 & inlist(round,2,3,4,5), out(k6 happiness) ate ties logit ai(2) neighbor(1)
		
			scalar att_k6 = r(att_k6)
			scalar att_happiness = r(att_happiness)
			scalar seatt_k6 = r(seatt_k6)
			scalar seatt_happiness = r(seatt_happiness)
			
			scalar ate_k6 = r(ate_k6)
			scalar ate_happiness = r(ate_happiness)
			scalar seate_k6 = r(seate_k6)
			scalar seate_happiness = r(seate_happiness)
			
			sum k6 if e(sample) == 1
			scalar mean1 = r(mean)
			scalar sd1 = r(sd)
			sum happiness if e(sample) == 1
			scalar mean2 = r(mean)
			scalar sd2 = r(sd)
			
			//matrix M = r(table)
			putexcel set "$work/figures/all/`excel'", modify
			putexcel A18 = "ATT"
			putexcel A19 = "SE"
			putexcel A20 = "Mean"
			putexcel A21 = "SD"
			putexcel A22 = "Standardized ATT"
			putexcel A23 = "Standardized SE"
			
			putexcel A24 = "ATE"
			putexcel A25 = "SE of ATE"
			putexcel A26 = "Standardized ATE"
			putexcel A27 = "Standardized SE"
			
			putexcel D18 = "ate ties logit ai(2) neighbor(1)"
			
			scalar stand_att1 = att_k6 / sd1
			scalar stand_att2 = att_happiness / sd2
			scalar stand_seatt1 = seatt_k6 / sd1
			scalar stand_seatt2 = seatt_happiness / sd2
			scalar stand_ate1 = ate_k6 / sd1
			scalar stand_ate2 = ate_happiness / sd2
			scalar stand_seate1 = seate_k6 / sd1
			scalar stand_seate2 = seate_happiness / sd2			
			
			matrix result3 = (att_k6,att_happiness\seatt_k6,seatt_happiness\mean1,mean2\sd1,sd2\stand_att1,stand_att2\stand_seatt1,stand_seatt2\ate_k6,ate_happiness\seate_k6,seate_happiness\stand_ate1,stand_ate2\stand_seate1,stand_seate2)
			matrix list result3
			putexcel B18 = matrix(result3)		

			psgraph, graphregion(color(white)) ytitle(Density)
			graph save "Graph" "$work\figures\all\overlap_`excel'_neighbor1.gph", replace
			graph export "$work\figures\all\overlap_`excel'_neighbor1.png", as(png) name("Graph") replace	width(2000)	
			pstest $imbens, graph both label ylabel(,labsize(vsmall)) graphregion(color(white))
			gr_edit .grpaxis.style.editstyle majorstyle(tickstyle(show_labels(yes))) editcopy 
			gr_edit .grpaxis.style.editstyle majorstyle(tickstyle(textstyle(size(vsmall)))) editcopy
			
			graph save "Graph" "$work\figures\all\balance_`excel'_neighbor1.gph", replace
			graph export "$work\figures\all\balance_`excel'_neighbor1.png", as(png) name("Graph") replace	width(2000)		
	
	
	**********************************
	*B. PSM Estimation for Switch (R1)		
	**********************************	
	//1. Preparation for trimming: selecting variables
	
		//To save your time, skip psestimate	
		psestimate win if inlist(round,1), totry(age gender $marital2 $job $guess $jobind njoin_member)
	
		//Selected first order covariates are: njoin_member guess_3 gender married2 job4r_6 job4r_3 guess_5 job4r_2 job4r_8 self job4r_7 guess_2 job4r_12
		//Selected second order covariates are: c.njoin_member#c.njoin_member c.job4r_2#c.njoin_member c.job4r_2#c.married2 c.guess_2#c.job4r_6 c.self#c.njoin_member c.guess_2#c.married2 c.job4r_6#c.married2		
		gen interaction1 = c.njoin_member#c.njoin_member
		gen interaction2 = c.job4r_2#c.njoin_member
		gen interaction3 = c.job4r_2#c.married2
		gen interaction4 = c.guess_2#c.job4r_6
		gen interaction5 = c.self#c.njoin_member
		gen interaction6 = c.guess_2#c.married2
		gen interaction7 = c.job4r_6#c.married2
		
		global first njoin_member guess_3 gender married2 job4r_6 job4r_3 guess_5 job4r_2 job4r_8 self job4r_7 guess_2 job4r_12
		global imbens $first interaction*

		psmatch2 win $imbens if lottery == 1 & inlist(round,1), out(k6) common noreplacement logit descending		
	//2. Trimming
		drop if !inrange(_pscore,0.1,0.9) & !mi(_pscore)
		
	//3. Running PSM to estimate causal effects: begin with selecting variables
	
		//To save your time, skip psestimate	
		psestimate win if inlist(round,1), totry(age gender $marital2 $job $guess $jobind njoin_member)		

		//Selected first order covariates are: njoin_member guess_3 gender married2 guess_2 job4r_3 job4r_6 self job4r_7 job4r_12 guess_5 job4r_8
		//Selected second order covariates are: c.njoin_member#c.njoin_member c.job4r_6#c.guess_2 c.job4r_6#c.married2 c.guess_2#c.married2 c.self#c.njoin_member
		drop interaction*
		gen interaction1 = c.njoin_member#c.njoin_member
		gen interaction2 = c.job4r_6#c.guess_2
		gen interaction3 = c.job4r_6#c.married2
		gen interaction4 = c.guess_2#c.married2
		gen interaction5 = c.self#c.njoin_member
		
		global first njoin_member guess_3 gender married2 guess_2 job4r_3 job4r_6 self job4r_7 job4r_12 guess_5 job4r_8
		global imbens $first interaction*	

	//4. Running PSM to estimate causal effects		
		local excel psmR1
		
		//psmatch2 #1
		set seed 1
		psmatch2 win $imbens if lottery == 1 & inlist(round,1), out(k6) ate ties logit ai(2) neighbor(2)	
	
			scalar att_k6 = r(att_k6)
			scalar seatt_k6 = r(seatt_k6)
			
			scalar ate_k6 = r(ate_k6)
			scalar seate_k6 = r(seate_k6)
			
			sum k6 if e(sample) == 1
			scalar mean1 = r(mean)
			scalar sd1 = r(sd)	
	
			putexcel set "$work/figures/all/`excel'", replace
			putexcel A2 = "ATT"
			putexcel A3 = "SE"
			putexcel A4 = "Mean"
			putexcel A5 = "SD"
			putexcel A6 = "Standardized ATT"
			putexcel A7 = "Standardized SE"
			
			putexcel A8 = "ATE"
			putexcel A9 = "SE of ATE"
			putexcel A10 = "Standardized ATE"
			putexcel A11 = "Standardized SE"
			
			putexcel B1 = "k6"
			putexcel C1 = "happiness"
			
			putexcel D1 = "Option of psmatch2"
			putexcel D2 = "ate ties logit ai(2) neighbor(2)"
			
			scalar stand_att1 = att_k6 / sd1
			scalar stand_seatt1 = seatt_k6 / sd1
			scalar stand_ate1 = ate_k6 / sd1
			scalar stand_seate1 = seate_k6 / sd1
			
			matrix result = (att_k6\seatt_k6\mean1\sd1\stand_att1\stand_seatt1\ate_k6\seate_k6\stand_ate1\stand_seate1)
			matrix list result
			putexcel B2 = matrix(result)	
			
			psgraph, graphregion(color(white)) ytitle(Density)
			graph save "Graph" "$work\figures\all\overlap_`excel'_neighbor2.gph", replace
			graph export "$work\figures\all\overlap_`excel'_neighbor2.png", as(png) name("Graph") replace	width(2000)	
			pstest $imbens, graph both label ylabel(,labsize(vsmall)) graphregion(color(white))
			gr_edit .grpaxis.style.editstyle majorstyle(tickstyle(show_labels(yes))) editcopy 
			gr_edit .grpaxis.style.editstyle majorstyle(tickstyle(textstyle(size(vsmall)))) editcopy
			
			graph save "Graph" "$work\figures\all\balance_`excel'_neighbor2.gph", replace
			graph export "$work\figures\all\balance_`excel'_neighbor2.png", as(png) name("Graph") replace	width(2000)			

		//psmatch2 #2
		//local excel psmR1		
		set seed 1
		psmatch2 win $imbens if lottery == 1 & inlist(round,1), out(k6) common descending logit noreplacement ai(2)
		
			scalar att_k6 = r(att_k6)
			scalar seatt_k6 = r(seatt_k6)
			
			sum k6 if e(sample) == 1
			scalar mean1 = r(mean)
			scalar sd1 = r(sd)

			putexcel set "$work/figures/all/`excel'", modify
			putexcel A12 = "ATT"
			putexcel A13 = "SE"
			putexcel A14 = "Mean"
			putexcel A15 = "SD"
			putexcel A16 = "Standardized ATT"
			putexcel A17 = "Standardized SE"
			
			putexcel D12 = "common descending logit noreplacement ai(2)"			
			
			scalar stand_att1 = att_k6 / sd1
			scalar stand_seatt1 = seatt_k6 / sd1
			
			matrix result2 = (att_k6\seatt_k6\mean1\sd1\stand_att1\stand_seatt1)
			putexcel B12 = matrix(result2)	
			
			psgraph, graphregion(color(white)) ytitle(Density)
			graph save "Graph" "$work\figures\all\overlap_`excel'_noreplacement.gph", replace
			graph export "$work\figures\all\overlap_`excel'_noreplacement.png", as(png) name("Graph") replace	width(2000)	
			pstest $imbens, graph both label ylabel(,labsize(vsmall)) graphregion(color(white))
			gr_edit .grpaxis.style.editstyle majorstyle(tickstyle(show_labels(yes))) editcopy 
			gr_edit .grpaxis.style.editstyle majorstyle(tickstyle(textstyle(size(vsmall)))) editcopy
			
			graph save "Graph" "$work\figures\all\balance_`excel'_noreplacement.gph", replace
			graph export "$work\figures\all\balance_`excel'_noreplacement.png", as(png) name("Graph") replace	width(2000)				
			
		//psmatch2 #3 1:1 match
		//local excel psmR1				
		set seed 1
		psmatch2 win $imbens if lottery == 1 & inlist(round,1), out(k6) ate ties logit ai(2) neighbor(1)
		
			scalar att_k6 = r(att_k6)
			scalar seatt_k6 = r(seatt_k6)
			
			scalar ate_k6 = r(ate_k6)
			scalar seate_k6 = r(seate_k6)
			
			sum k6 if e(sample) == 1
			scalar mean1 = r(mean)
			scalar sd1 = r(sd)

			putexcel set "$work/figures/all/`excel'", modify
			putexcel A18 = "ATT"
			putexcel A19 = "SE"
			putexcel A20 = "Mean"
			putexcel A21 = "SD"
			putexcel A22 = "Standardized ATT"
			putexcel A23 = "Standardized SE"
			
			putexcel A24 = "ATE"
			putexcel A25 = "SE of ATE"
			putexcel A26 = "Standardized ATE"
			putexcel A27 = "Standardized SE"
			
			putexcel D18 = "ate ties logit ai(2) neighbor(1)"
			
			scalar stand_att1 = att_k6 / sd1
			scalar stand_seatt1 = seatt_k6 / sd1
			scalar stand_ate1 = ate_k6 / sd1
			scalar stand_seate1 = seate_k6 / sd1
			
			matrix result3 = (att_k6\seatt_k6\mean1\sd1\stand_att1\stand_seatt1\ate_k6\seate_k6\stand_ate1\stand_seate1)
			matrix list result3
			putexcel B18 = matrix(result3)		
		
		psgraph, graphregion(color(white)) ytitle(Density)
		graph save "Graph" "$work\figures\all\overlap_`excel'_neighbor1.gph", replace
		graph export "$work\figures\all\overlap_`excel'_neighbor1.png", as(png) name("Graph") replace	width(2000)	
		pstest $imbens, graph both label ylabel(,labsize(vsmall)) graphregion(color(white))
		gr_edit .grpaxis.style.editstyle majorstyle(tickstyle(show_labels(yes))) editcopy
		gr_edit .grpaxis.style.editstyle majorstyle(tickstyle(textstyle(size(vsmall)))) editcopy
		
		graph save "Graph" "$work\figures\all\balance_`excel'_neighbor1.gph", replace
		graph export "$work\figures\all\balance_`excel'_neighbor1.png", as(png) name("Graph") replace	width(2000)					
			
			
*2. Figure 2			

//IV instrumental variable
	//Use the whole data (not after trimmed).
	
	*1.
	//preparation for outreg2
	local save "/figures/all/reg3"	
	capture erase "$work/figures/all/reg3.txt"	

		foreach endogenous of varlist switch play1m_switch {
		*1. k6
		foreach outcome of varlist k6 {
		//local endogenous switch
			ivreghdfe `outcome' (`endogenous' = win) if lottery == 1 & inrange(round,1,1), absorb(pref round) cluster(pref) first
				local coef=round(el(e(b),1,1),.000001)
				local t1=el(e(V),1,1)
				local t2=`t1'^(1/2)
				local se=round(`t2',.000001)
				display `se'
				sum `outcome' if e(sample) == 1
				local mean = round(r(mean),.001)
				local sd = round(r(sd),.001)						
				local temp1 = `coef' / `sd'
				local temp2 = `se' / `sd'
				local standcoef = round(`temp1',.0001)
				local standse = round(`temp2',.0001)
							local pvaltemp = (2 * ttail(e(df_r), abs(_b[`endogenous'] / _se[`endogenous']) ) )
							local pval = round(`pvaltemp',.000001)
							local stars = cond(`pval'<0.01,"***",cond(`pval'<0.05,"**",cond(`pval'<0.1,"*","empty")))
							local low = `standcoef' - 1.96*`standse'
							local hi = `standcoef' + 1.96*`standse'					
					outreg2 using "$work`save'.xls", dec(3) fmt(gc) addtext(Controls, No, Prefecture FE, Yes, Mean, "`mean'", SD, "`sd'", Coef, "`coef'", SE, "`se'", Standardized Coef, "`standcoef'", Standardized SE, "`standse'", "P-value", "`pval'", Stars, `stars', Low, `low', Hi, `hi', Lottery, Switch) adds("Kleibergen-Paap rk Wald F statistic", e(widstat)) keep(`endogenous') nor2 nocon label nonotes append		
		
			ivreghdfe `outcome' (`endogenous' = win) njoin_member guess_2 guess_3 guess_4 guess_5 age gender $job $marital2 $jobind if lottery == 1 & inrange(round,1,1), absorb(pref round) cluster(pref) first
				local coef=round(el(e(b),1,1),.000001)
				local t1=el(e(V),1,1)
				local t2=`t1'^(1/2)
				local se=round(`t2',.000001)
				display `se'
				sum `outcome' if e(sample) == 1
				local mean = round(r(mean),.001)
				local sd = round(r(sd),.001)						
				local temp1 = `coef' / `sd'
				local temp2 = `se' / `sd'
				local standcoef = round(`temp1',.0001)
				local standse = round(`temp2',.0001)
							local pvaltemp = (2 * ttail(e(df_r), abs(_b[`endogenous'] / _se[`endogenous']) ) )
							local pval = round(`pvaltemp',.000001)
							local stars = cond(`pval'<0.01,"***",cond(`pval'<0.05,"**",cond(`pval'<0.1,"*","empty")))
							local low = `standcoef' - 1.96*`standse'
							local hi = `standcoef' + 1.96*`standse'					
					outreg2 using "$work`save'.xls", dec(3) fmt(gc) addtext(Controls, Yes, Prefecture FE, Yes, Mean, "`mean'", SD, "`sd'", Coef, "`coef'", SE, "`se'", Standardized Coef, "`standcoef'", Standardized SE, "`standse'", "P-value", "`pval'", Stars, `stars', Low, `low', Hi, `hi', Lottery, Switch) adds("Kleibergen-Paap rk Wald F statistic", e(widstat)) keep(`endogenous') nor2 nocon label nonotes append			
		}
		}

		foreach outcome of varlist k6 happiness {		
		foreach endogenous of varlist ps5 play1m_ps5 averageplaytime1 {
		*k6 and SWLS

		//local outcome k6

			ivreghdfe `outcome' (`endogenous' = win) if lottery == 1 & inrange(round,2,5), absorb(pref round) cluster(pref) first
				local coef=round(el(e(b),1,1),.000001)
				local t1=el(e(V),1,1)
				local t2=`t1'^(1/2)
				local se=round(`t2',.000001)
				display `se'
				sum `outcome' if e(sample) == 1
				local mean = round(r(mean),.001)
				local sd = round(r(sd),.001)						
				local temp1 = `coef' / `sd'
				local temp2 = `se' / `sd'
				local standcoef = round(`temp1',.0001)
				local standse = round(`temp2',.0001)
							local pvaltemp = (2 * ttail(e(df_r), abs(_b[`endogenous'] / _se[`endogenous']) ) )
							local pval = round(`pvaltemp',.000001)
							local stars = cond(`pval'<0.01,"***",cond(`pval'<0.05,"**",cond(`pval'<0.1,"*","empty")))
							local low = `standcoef' - 1.96*`standse'
							local hi = `standcoef' + 1.96*`standse'	
					outreg2 using "$work`save'.xls", dec(3) fmt(gc) addtext(Controls, Yes, Prefecture FE, Yes, Mean, "`mean'", SD, "`sd'", Coef, "`coef'", SE, "`se'", Standardized Coef, "`standcoef'", Standardized SE, "`standse'", "P-value", "`pval'", Stars, `stars', Low, `low', Hi, `hi', Lottery, PS5) adds("Kleibergen-Paap rk Wald F statistic", e(widstat)) keep(`endogenous') nor2 nocon label nonotes append			
		
			ivreghdfe `outcome' (`endogenous' = win) njoin_member guess_2 guess_3 guess_4 guess_5 age gender $job $marital2 $jobind if lottery == 1 & inrange(round,2,5), absorb(pref round) cluster(pref) first
				local coef=round(el(e(b),1,1),.000001)
				local t1=el(e(V),1,1)
				local t2=`t1'^(1/2)
				local se=round(`t2',.000001)
				display `se'
				sum `outcome' if e(sample) == 1
				local mean = round(r(mean),.001)
				local sd = round(r(sd),.001)						
				local temp1 = `coef' / `sd'
				local temp2 = `se' / `sd'
				local standcoef = round(`temp1',.0001)
				local standse = round(`temp2',.0001)
							local pvaltemp = (2 * ttail(e(df_r), abs(_b[`endogenous'] / _se[`endogenous']) ) )
							local pval = round(`pvaltemp',.000001)
							local stars = cond(`pval'<0.01,"***",cond(`pval'<0.05,"**",cond(`pval'<0.1,"*","empty")))
							local low = `standcoef' - 1.96*`standse'
							local hi = `standcoef' + 1.96*`standse'	
					outreg2 using "$work`save'.xls", dec(3) fmt(gc) addtext(Controls, Yes, Prefecture FE, Yes, Mean, "`mean'", SD, "`sd'", Coef, "`coef'", SE, "`se'", Standardized Coef, "`standcoef'", Standardized SE, "`standse'", "P-value", "`pval'", Stars, `stars', Low, `low', Hi, `hi', Lottery, PS5) adds("Kleibergen-Paap rk Wald F statistic", e(widstat)) keep(`endogenous') nor2 nocon label nonotes append			
		}
		}


