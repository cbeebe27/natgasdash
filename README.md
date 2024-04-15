(FIN-488) Fintech 3 Final Project. A class aimed to develop production-grade web apps In Finance.

Author: Connor Beebe, University of Alberta

AECO Natural Gas Dashboard
Package name: (natgasdash)
natgasdash is an interactive dashboard to explore the annual AECO data release. 

It aims to help explore relationships and trends in the data, and present it in a visual manner that is not seen in the release itself.


Installation
You can install the development version of natgasdash like this:

# install.packages("devtools")
devtools::install_github("cbeebe27/natgasdash")
Running the app
library(natgasdash)
natgasdash::run_app()
