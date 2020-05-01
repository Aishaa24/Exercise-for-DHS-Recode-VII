******************************
*** Delivery Care************* 
******************************
gen DHS_phase=substr(v000, 3, 1)
destring DHS_phase, replace

gen country_year="`name'"
gen year = regexs(1) if regexm(country_year, "([0-9][0-9][0-9][0-9])[\-]*[0-9]*[ a-zA-Z]*$")
destring year, replace
gen country = regexs(1) if regexm(country_year, "([a-zA-Z]+)")

	*c_hospdel: child born in hospital of births in last 2 years

	gen c_hospdel= ( inlist(m15,31,21,23,32) ) if   !mi(m15)     
	

	*c_facdel: child born in formal health facility of births in last 2 years
	
	gen c_facdel = (!inlist(m15,11,12)) if   !mi(m15)   

	
	*c_earlybreast: child breastfed within 1 hours of birth of births in last 2 years

	gen c_earlybreast = (inlist(m34,0,100)) if m4!=94
	replace c_earlybreast =. if m34==.
	
    *c_skin2skin: child placed on mother's bare skin immediately after birth of births in last 2 years
	gen c_skin2skin = (m77 == 1) if  inlist(m77,1,2,3)  
	replace  c_skin2skin=. if m77==8
	
	*c_sba: Skilled birth attendance of births in last 2 years: according to report doctors and nurses/midwives skilled
		gen c_sba = 0
		replace c_sba = 1 if (m3a==1 | m3b==1) 
		replace c_sba = . if m3a==. | m3b==.

	*c_sba_q: child placed on mother's bare skin and breastfeeding initiated immediately after birth among children with sba of births in last 2 years
	gen c_sba_q = (c_skin2skin == 1 & c_earlybreast == 1) if c_sba == 1
	replace c_sba_q = . if c_skin2skin == . | c_earlybreast == .
	
	*c_caesarean: Last birth in last 2 years delivered through caesarean                    
	clonevar c_caesarean = m17
	
    *c_sba_eff1: Effective delivery care (baby delivered in facility, by skilled provider, mother and child stay in facility for min. 24h, breastfeeding initiated in first 1h after birth)
	gen stay = (inrange(m61,124,166)|inrange(m61,201,261)|inrange(m61,301,325))
	replace stay = . if mi(m61) | inlist(m61,998)
	gen c_sba_eff1 = (c_facdel == 1 & c_sba == 1 & stay == 1 & c_earlybreast == 1) 
	replace c_sba_eff1 = . if c_facdel == . | c_sba == . | stay == . | c_earlybreast == . 
	
	*c_sba_eff1_q: Effective delivery care (baby delivered in facility, by skilled provider, mother and child stay in facility for min. 24h, breastfeeding initiated in first 1h after birth) among those with any SBA
	gen c_sba_eff1_q = (c_facdel==1 & c_sba == 1 & stay==1 & c_earlybreast == 1) if c_sba == 1	
	replace c_sba_eff1_q = . if c_facdel == . | c_sba == . | stay == . | c_earlybreast == . 
	
	*c_sba_eff2: Effective delivery care (baby delivered in facility, by skilled provider, mother and child stay in facility for min. 24h, breastfeeding initiated in first 1h after birth, skin2skin contact)
	gen c_sba_eff2 = (c_facdel == 1 & c_sba == 1 & stay == 1 & c_earlybreast == 1 & c_skin2skin == 1) 
	replace c_sba_eff2 = . if c_facdel == . | c_sba == . | stay == . | c_earlybreast == . | c_skin2skin == .
	
	*c_sba_eff2_q: Effective delivery care (baby delivered in facility, by skilled provider, mother and child stay in facility for min. 24h, breastfeeding initiated in first 1h after birth, skin2skin contact) among those with any SBA
	gen c_sba_eff2_q = (c_facdel == 1 & c_sba == 1 & stay == 1 & c_earlybreast == 1 & c_skin2skin == 1) if c_sba == 1	
	replace c_sba_eff2_q = . if c_facdel == . | c_sba == . | stay == . | c_earlybreast == . | c_skin2skin == .
	
	



	