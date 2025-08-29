## Exceeds spec
### At least one piece of functionality has been refactored into a function in its own file
I created two separate files that were refactored from the spaghetti code, one for the moving average function and one for the ggplot code that creates the figure. The moving average function is sourced into the data cleaning R script, and the plot is sourced into the Quarto doc. I think this created a very clean workflow where different parts of the flow are kept in distinct, separate parts of the repository. This will hopefully keep it organized and clear for future me, collaborators, or anyone trying to reproduce this workflow in the future.

### The analysis produces the expected output
The reproduced figure 3 plot (seen in README, Quarto doc, or in the figs folder) closely matches the figure produced in Shaefer et. al. 2000. I took some liberties in trying to improve the plot by changes the line types into colors to better show the trends of each site, moving the legend to the side to be more clear, and adding a title. 

### Collaboration
I felt the peer feedback was helpful! I was able to receive feedback with a different perspective that helped to move the project along more productively than if I didn't have the help. I gave feedback to Austin by looking through the README and following the destinations to actually look at and run each script to find faults I felt I could be productive in helping. I followed up on a GitHub issue with his plot, and was able to source code from my own plot to help him figure out some elements he did not know how to do yet. 

Sofia R helped to create a initial package script for workbench.
https://github.com/lsdixit/eds214-reproducible-workflow/issues/11#issue-3364680010

I suggested places for Austin to move his clean data.
https://github.com/austinmartinez12/eds214-day1-tasks1/issues/11#issuecomment-3235797642

I added an Issue to Austin's git hub suggesting extra commenting.
https://github.com/austinmartinez12/eds214-day1-tasks1/issues/13#issue-3364707690

Resolved a merge conflict.
https://github.com/lsdixit/eds214-reproducible-workflow/commit/ded063837e0cae7e7b808648756f114e614fa477