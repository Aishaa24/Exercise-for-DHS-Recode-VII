*w_papsmear	Women received a pap smear  (1/0)
gen w_papsmear = (s1110_g==1) if s1110_f==1
replace w_papsmear=. if s1110_g==. 

*w_mammogram	Women received a mammogram (1/0)
gen w_mammogram = (s1110_c  ==1) 
replace w_mammogram=. if s1110_c  ==. 

