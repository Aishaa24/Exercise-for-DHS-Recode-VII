
******************************
***Postnatal Care************* 
****************************** 

*c_pnc_any : mother OR child receive PNC in first six weeks by skilled health worker	
		gen c_pnc_any = .
		
		replace c_pnc_any = 0 if m62 != . | m66 != . | m70 != . | m74 != .
		replace c_pnc_any = 1 if (m63 < 307 & inrange(m64,11,12)) | (m67 < 307 & inrange(m68,11,12)) | (m71 < 307 & inrange(m72,11,12)  | (m75 <= 304 & inrange(m76,11,12)))
		replace c_pnc_any = . if inlist(m63,998) | inlist(m67,998) | inlist(m71,998) | inlist(m75,998) | m70 == 8 
		
	*c_pnc_eff: mother AND child in first 24h by skilled health worker

		gen c_pnc_eff = .
		replace c_pnc_eff = 0 if m62 != . | m66 != . | m70 != . | m74 != .
	   	 replace c_pnc_eff = 1 if (((inrange(m63,100,124) | m63 == 201 ) & inrange(m64,11,12)) | ((inrange(m67,100,124) | m67 == 201) & inrange(m68,11,12))) & (((inrange(m71,100,124)  | m71 == 201) & inrange(m72,11,12)) | ((inrange(m75,100,124) | m75 == 201) & inrange(m76,11,12)))
		replace c_pnc_eff = . if inlist(m63,998) | inlist(m67,998) | inlist(m71,998) | inlist(m75,998) | m62 == 8 | m66 == 8 | m70 == 8 | m74 == 8
	// we consider day = 1 as the first 24h, and I add missing treatment
	
	
*c_pnc_eff_q: mother AND child in first 24h by skilled health worker among those with any PNC
	gen c_pnc_eff_q = c_pnc_eff
	replace c_pnc_eff_q = . if c_pnc_any == 0
	replace c_pnc_eff_q = . if c_pnc_any == . | c_pnc_eff == .
	

//these variables are only for recode VI as per the DHS guidlines excel sheet-should we also add for recode VII
	egen check = rowtotal(m78a m78b m78d),mi
	gen c_pnc_eff2 = c_pnc_eff
	replace c_pnc_eff2 = 0 if check != 3
	replace c_pnc_eff2 = . if c_pnc_eff == . | m78a == 8 | m78b == 8 | m78d == 8
	

	gen c_pnc_eff2_q = c_pnc_eff2
	replace c_pnc_eff2_q = . if c_pnc_any == 0
	replace c_pnc_eff2_q = . if c_pnc_any == . | c_pnc_eff2 == .
			
	
*******compare with statacompiler
preserve
keep if inrange(hm_age_mon,0,59)
restore
