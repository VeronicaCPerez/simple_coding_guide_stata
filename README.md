# Coding guide

While writting your code please keep in mind to keep an organized structure. I'm going to give a list of Do's and Don'ts of a do-file based on Emmanuel Milet's ["The Do’s and Don’ts of a Do-file"](https://www.parisschoolofeconomics.eu/docs/yin-remi/do-file.pdf)


## **DO's and Don'ts**


### **Naming and general purpose**

#### 1.  Give explicit titles to your do-files
#### 2.  Every do-file has one and only one purpose
#### 3.  Enumerate the do-files 

For example, think you're merging two datasets: tv_data, family_data; and then you wan't to produce a few graphs with the merged dataset. First you would need to clean both datasets, then do the merge and then make the graphs. Instead of making one 1000 thousand line do-file that does all of this do the following: `0_clean_tv_data.do`, `0_clean_family_data.do`, `1_merge_tv_family_data.do`, `2_analysis_tv_family_data.do`. Not that the first 2 do-files have the same level `0` which means that the order in which you run them won't matter, because they don't depend on eachother, while the next do-file is `1` which means I need the outputs from `0` before running this file. 

Also, you can note that the names of the do-files are telling me not only in which order to run them, but what I'm doig inside. I know that `0_clean_tv_data.do` is cleanng this dataset, and so on. Keeping tasks in separate do-files allows you to go back and make corrections without having to run a do-file that could take hours.

### **Making great self-contained do-files**

#### 4. Make a header

In the `Template_dofile.do` you can notice that there's a complete *NOTES* and *Preamble* section. This should be in all do-files. All code should be self-documented, I should be able to open any do-file or script and understand: what you're doing, what data are you using, and what output are you producing. Without this information it's hard for the reader/coder to understand the code.

Specify all paths as relative in the preamble, every coder would only need to change the main `workindir` for the code to work.

**Do not** write paths to your local machine after the preamble.
**Avoid** changing the directory, for multiple reasons, establishing a `cd` in your workflow can be misleadig, i.e. your graphs are saved in folder `workindir/Figures` however you were working in another project with `cd` in which there's also a `Figures/` folder. Perhaps your code didn't run as expected, and it failed to define the `cd` and you end up saving your things into another project's folder. In general avoid changing the directory and work with relative paths in locals.

**Avoid** having so many globals. Ideally, you should only work with locals. global macros could be problematic if re-defined by mistake.  


#### 5. Make sections and comments and more comments

Organize your code in sections, if you're writting one do-file with the analysis and making graphs, and tables and regressions, give each of them section and write down what you're doing.

For example **Don't** do this:

``` 
    bcuse wage2, clear 

	graph bar (mean) wage, over(married)

	scatter wage hours

	reg wage hours
	
	twoway (scatter wage  hours) (qfit wage hours)

	gen hours2 = hours^2
	 
	reg wage hours hours2
	reg wage hours hours2 married 

```

Instead, **Do** the following:

```

/* =========== 1. importing the dataset =========== */
	
	
	bcuse wage2, clear
	describe
	
	///Always describe the dataset so the current description 
	/// of the data is showed in the log
	
/* =========== 2. Creating Variables =========== */

	gen hours2 = hours^2
	 
	// Ideally this would be done in a previous do-file 
	// where the .dta was cleaned but sometimes you need it here
	
	
/* =========== 3. Graphs =========== */

	*Average wage over married and not married
	graph bar (mean) wage, over(married)
	
	
	*scatter plot between wage and hours with a cuadratic fitted line
	twoway (scatter wage  hours) (qfit wage hours)

/* =========== 4. Regressions =========== */
	
	*specification 1
	reg wage hours	
	
	*specification 2: added hours^2
	reg wage hours hours2
	
	*specification 3: added married var to spec 2.
	reg wage hours hours2 married 

```

### **Variable naming and labels**

#### 6. Give explicit name to your variables and add labels
#### 7. Whenever you create a variable, that's not obvious what it is, please describe the process.

For example, if you're creating a variabl called `age_std` that is the standardized age, say it in the code and add in the label which is the original variable. (This is a simplified example, sometimes transformations are more complicated)

#### 8. follow the same pattern for your variable names

Avoid using capitalized letters, if you're going to use `_` to replace spaces in variable names, do it for all variables. But **do not** use `exports1999` and then `exports_2000`. And label all your variables.


### **Regressions and Tables**

Here everyone uses their own commands. Whichever one you prefer, make sure to let others now if they need to install something and try to describe what each part of the export is doing enough so someone else can follow your code and make changed to the table if needed.

#### 9. Document what you want to show in given table and the process you're following to create it. 

Especially if it's the first time you use the command in the project. For example I use `frmttable` which is relatively less known in comparison with stuff like `outreg2`


```
/* ========================= 5. Tables ========================= */


**To export tables I'm using frmttable, if not installed run the following line:

// findit frmttable


**Frequency table for married not married people
**************************************************
	
	*create freq table from tab
	tab married, matcell(table_frmt)
	
	matrix list table_frmt
	
	** exporting table as .tex
	frmttable using "$outputs/tables/married_frequency.tex", ///
	statmat(table_frmt) tex fragment /// matrix with data, format
	ctitles(" ", "Freq") /// coltitles
	title("Frequency Table of married peopke") /// tab titles
	rtitles("Single"\ "Married") replace ///rowtitles


```

#### 10. Save merge results!! 

Everytime you run a merge or another important task that has a result in the `results` window, copy and paste as a comment in your code with the date you ran the code. It will help you keep track if you get different results and need to check why there are changes.

```

// merge on july 7th 2022
//
//     Result                      Number of obs
//     -----------------------------------------
//     Not matched                           524
//         from master                       343  (_merge==1)
//         from using                        181  (_merge==2)
//
//     Matched                               148  (_merge==3)
//     -----------------------------------------
//

```

### **General advice**

#### 11. Don't write lines of code after the vertical line in the do-file (unless you have to). Most screens won't be able to fit it.
#### 12. Temporary files are your friend, if something doesn't need to be seen later it doesn't need to be saved. Use [tempfiles](https://libguides.library.nd.edu/data-analysis-stata/temp-files) in STATA to avoid innecesary files
#### 13. Save your stuff in final folders that make sense. **Don't** make an **outputs** folder with 100 files and tables and graphs, instead split your data in: *input*, *intermediate* and *final*, and make another folder for outputs.

### **Optional**

#### 14. Use the same format for all graphs, we can work on this
#### 15. For data resulting from do-files what I do is I save them starting with the number of the do

For example, a .dta resulting from `0_clean_tv_data.do` would be named `0_tv_data_cleaned.dta` and the data resulting from `1_merge_tv_family_data.do` would be named `1_tv_family_data_merged.dta`. This is slightly to keep track easily of where each thing comes from, but it's not necessary.
