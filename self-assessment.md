## Automate
### Running the entire analysis requires rendering one Quarto document
-Not yet.
I have not completed the main quarto doc where all info and results show up. I have data cleaning and plotting in their own plots, not sure if that will count or not if I just put the results in the main quarto doc from an output that was saved elsewhere and done in a separate doc. I could maybe link to folders that have the scripts where stuff was run?

### The analysis runs without errors
-Meets. All code runs without errors right now. :)

### The analysis produces the expected output
-Meets. 
Data cleaning produce the output I would expect, and the plot looks as I imagined it too. I think it will exceed if the plot is very close to the figure in the paper (similar look, axes the same, legend and title the same, etc) with slight variations in the data since we don't have exact protocol.

### Data import/cleaning is handled in its own script(s)
-Meets. 
All data import and cleaning is in one script.

## Organize
### Raw data is contained in its own folder
-Meets. 
All raw data is kept in the data folder, in a subfolder named "data_raw"

### Intermediate outputs are created and saved to a separate folder from raw data
-Meets.
The final clean data set after moving average calculation was done is saved in a separate "data_clean" folder in the "data"" folder.

### At least one piece of functionality has been refactored into a function in its own file
-Meets.
The moving average function is saved in its own R script in "R". I think I could exceed this if I create a for loop for the moving average analysis and save that in its own, and maybe if I create a function for my ggplot settings and save that elsewhere too.

## Document
### The repo has a README that explains where to find (1) data, (2) analysis script, (3) supporting code, and (4) outputs
-Not yet.
I need to update the readme with all the folder explanations which will explain where all the data (raw and clean) are, where the R scripts for data cleaning and plots are, where figures are kept, and where the final quarto doc is kept.

### The README includes a flowchart and text explaining how the analysis works
-Not yet.
There is no flowchart yet :)

### The code is appropriately commented
-Not yet. 
I have not commented much as I am still refining code. I should go back through and comment what I have done so far. Could exceed by adding titles, many descriptive comments, and sources on EVERY script (including scratch)

### Variable and function names are descriptive and follow a consistent naming convention
-Meets.
All variables and functions are descriptive of their site and what the data contain. It could exceed if I further follow tidy syntax to better describe what I did to the data when assigning it.

## Scale
### Running the environment initialization script installs all required packages
-Not yet.
There is nowhere in code to install packages. Not sure where to put that? Should it be commented out?

### The analysis script runs without errors
-Meets. All code runs without errors right now. :)
