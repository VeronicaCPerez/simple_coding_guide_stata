********************************************************************************
*																			   *
*								Title: 1_Template_dofile.do		 	 		   *
*																			   *
********************************************************************************


*Creation: Made by *** fill name here on *** fill date here ****** 

*Version: 1 

*Last Modified: 
//		by: 
//		Make sure to log the changes you made to the do-file on the "changes"
//		section in the notes bellow

/*  ================================  NOTES  ================================

+ PURPSOSE:
	
	In this do-file we're trying to ....
		
+ DEPENDENCIES:
	Do you need to run something else to run this?
		
+ Inputs: 

		* Note the data you are using. Remember to tell us where it comes from

		
+ Outputs
	
		* What outputs do you create. And where you put them
  
  Changed:
	*Version 1: First version, no changes to log.


 ==============================  TOP MATTER ==============================*/
 

 **************** SET MAIN DO-FILE ARGUMENTS ****************


* Clear all and set large data arguments.
clear all
// version 13.0, user
set memory 1500m
set maxvar 10000
set more off 
set seed 10101

*********************************** HEADER ***********************************/

/****************************************************************************

** Define user-specific project paths in header. Mostly when we say workingdir,
it's like the main dropbox folder 


There's different ways to do this I'm going to list a few 


****************************************************************************/

*1. with inlist
*********************************************************

// Automatically detect the file system and setup.  
local system_string `c(username)' // Get Stata dir.
display "Current user, `c(username)' `c(machine_type)' `c(os)'."

	*Main Directory: Path to the dropbox
	**************************************

	* User 1
	if inlist( "`c(username)'" , "username" , "username2" ) {

		local workingdir "path to directory"

	}

	* User 2
	else if inlist( "`c(username)'" , "username3" , "username4" ) {

		local workingdir "path to directory"

	}

	
	/* 

		New to this code?
		Add yourself by copying the lines above, being sure to add your project file. 

	*/


	* If none of above cases match, give an error
	else {
	  noisily display as error _newline "{phang}Your username [`c(username)'] could not be matched with a profile. Check do-file header and try again.{p_end}"
	  error 2222
	}

	di "This project is working from `workingdir'"


*2. with `c(username)'
*********************************************************

* User 2
if "`c(username)'"== "your username"  {
	local workingdir "path to directory"
}


*3. with `c(username)'
*********************************************************

* User 3
	
	foreach dropbox_path in "path user 1" /// User 1
			"path user 2"  /// User 2
	{	
		*Establishing cd 
		capture local cd "`dropbox_path'"
		if _rc == 0 macro def pathinit `path'
	}
	
	
*==============================================================================*


********************************** END HEADER **********************************

/*



*/


* Main project DIR:
local projectdir "`workingdir'/1_Build/Data/INDUSTRY/EU KLEMS"
di "`projectdir'"
* Setup input data and output data at top of file. Something like: 

* input,inter,final folder
local data "`projectdir'/data"

* OUTPUT
local outputs "`projectdir'/outputs"

*Logs

local logfiles "`projectdir'/logfiles"
		
	*Log: If we keep logs, with dates, we'd be able to see whatever we ran a week
	* ago and why it may run differently now.

	*in case a previous log was open, close it
	cap log close _all

	*start log: 
		* save the long with the name of the dofile 
		* `c(current_date)' will save the current date in the name
	
	di "`logfiles'"
	
	log using "`logfiles'/1_Template_dofile`c(current_date)'.log", name("template dofile") replace
	
*==============================================================================*

/*****************************************************************************
************************************ MAIN ************************************
*****************************************************************************/


/* ========================= 1. First step  ========================= */
	
	
	*Comment your code. Please make your code readable, make comments and indent-
	*tations whenever possible. 
	
	
	
/* ============== 2. Second step ================= */



*==============================================================================*

*close logfile 

log close _all




	
	
