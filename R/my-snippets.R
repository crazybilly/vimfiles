# my snippets

snippet ie
	if( !exists("${1:object}")) {
	  source("${2:file}")
	}
	

snippet prep
	# libraries -------------------------------------------
	
	library(lubridate); library(beepr)
	library(tidyverse); library(muadc); library(magrittr)
	library(readxl); library(rlang)
	library(formattable); library(fundRaising)
	
	# data ------------------------------------------------
	
	if( !exists("lastinit") || lastinit < (now() - seconds(3) ) ) {
		initcommitsdb()
		lastinit  <- now()
	}

	
	${1:writecode}
	
	
	beep()


snippet lj
	left_join(${1:object}, by = 'pidm')

snippet ljc 
	left_join(${1:object}, by = 'pidm', copy = T)
	
snippet fi
	filter(${1:colname} = ${2:critera})

snippet mu
	mutate(${1:newcol} = ${2:critera})
	
snippet tot
	group_by(pidm) %>%
	summarize( total${1:g_or_c} = sum(${2:gift_or_commit}_amt) )

snippet recover
	save_all <- function() {
		save.image("recover.rda")
	}
	options(error = save_all)
