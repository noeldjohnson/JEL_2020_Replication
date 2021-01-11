This is the Readme for the replication files for "The Economic Impact of the Black Death" published in the Journal of Economic Literature.

Each folder contains the sources files and do files required to recreate the corresponding figure or table in the manuscript.

This file consolidates the instructions for replication and citations and access instructions for the data sets used to create each figure or table.

Software Requirements: Stata, R (tidyverse, sf, haven, gstat, viridis, tmap), MapInfo



##########################
## Figure 1 ##############
##########################

The figure was created using the software Mapinfo. The GIS files are .tab. The file opening all files and creating Figure 1 is “FIGURE1.wor”. The original data on mortality are in "cities274.xls".

The figure and the legend were then exported and manually combined to create Figure 1 in the folder.

Data come from: Jedwab, Remi, Noel Johnson, and Mark Koyama, “Pandemics, Places, and Populations: Evidence from the Black Death,” Technical Report DP13523, C.E.P.R. Discussion Papers 2019.

The data in that paper are based on those reported in:

Christakos, George, Richardo A. Olea, Marc L. Serre, Hwa-Lung Yu, and Lin-Lin Wang, Interdisciplinary Public Health Reasoning and Epidemic Modelling: The Case of Black Death, Berlin: Springer, 2005.

ACCESS CONDITIONS: The Authors hand-coded the data on mortality from Christakos et al, 2005.


##########################
## Figure 2 ##############
##########################

The figure was created using R. The commented code is in the folder for Figure 2, "BD_Figure_2.R". The data sets are also in that folder.

Data come from: Jedwab, Remi, Noel Johnson, and Mark Koyama, “Pandemics, Places, and Populations: Evidence from the Black Death,” Technical Report DP13523, C.E.P.R. Discussion Papers 2019.

The data in that paper are based on those reported in:

Christakos, George, Richardo A. Olea, Marc L. Serre, Hwa-Lung Yu, and Lin-Lin Wang, Interdisciplinary Public Health Reasoning and Epidemic Modelling: The Case of Black Death, Berlin: Springer, 2005.

ACCESS CONDITIONS: The Authors hand-coded the mortality data from Christakos et al, 2005.

##########################
## Figure 3 ##############
##########################

The figure was created using Stata. The .do file is "Figure 3_dofile.do" and is in the Figure 3 folder. The data set for creating the figure is also in this folder and titled "Data_Figure_3.dta".

The source for the data is: Jedwab, Remi, Noel Johnson, and Mark Koyama, “Pandemics, Places, and Populations: Evidence from the Black Death,” Technical Report DP13523, C.E.P.R. Discussion Papers 2019.

ACCESS CONDITIONS: The Authors hand-coded the mortality data from Christakos et al, 2005.


#########################################
######## Figures 4, 5, and 6 ############
#########################################

These figures were created using Stata. The .do file is "Figures 4 5 6 7b.do" and is in the "Figures 4 5 6 7b" folder. The data sets for creating the figures are also in this folder.

The sources for the data used to make Figures 4a, 4b, and 4c are:

Population data for England, Northern Italy, and Spain are from: McEvedy, Colin and Richard Jones, Atlas of World Population History, New York: Facts of File, 1978.

ACCESS CONDITIONS: These data were hand-coded by the Authors from McEvedy and Jones, 1978.

GDP and Real Wage Data for England and Northern Italy are from: Allen, Robert C., “The Great Divergence in European Wages and Prices from the Middle Ages to the First World War,” Explorations in Economic History, 2001, 38, 411–447.

ACCESS CONDITIONS: The data for England and Northern Italy were emailed directly to the Authors by Robert Allen. https://nyuad.nyu.edu/en/academics/divisions/social-science/faculty/robert-allen.html

GDP and Real Wage Data for Spain are from: Leandro Prados de la Escosura, Carlos Alvarez Nogal, and Carlos Santiago-Caballero, Growth recurring in preindustrial Spain: half a millennium perspective, EHES Working Paper No. 177, March 2020.

ACCESS CONDITIONS: The Spanish data were emailed to the Authors directly by Leandro Prados de la Escosura. http://portal.uc3m.es/portal/page/portal/dpto_ciencias_sociales/home/faculty/leandro_prados_escosura


The sources for the data used to make Figures 5a and 5b are:

The data in 5a are from: Stasavage, David, “What we can learn from the early history of sovereign debt,” Explorations in Economic History, 2016, 59
(Supplement C), 1 – 16.

ACCESS CONDITIONS: The Stasavage interest rate data were emailed directly to the Authors by David Stasavage: https://its.law.nyu.edu/facultyprofiles/index.cfm?fuseaction=profile.overview&personid=47236

The data in 5b are from: Clark, Gregory, “The macroeconomic aggregates for England, 1209–2008,” in Alexander J. Field, ed., Research in Economic History, Vol. 27 Emerald Group Publishing Limited 2020/05/08 2010, pp. 51–140.

ACCESS CONDITIONS: The Clark interest rate data were hand-coded by the Authors from this version of the paper: http://faculty.econ.ucdavis.edu/faculty/gclark/papers/Macroagg2009.pdf

The sources for the data used to make Figure 6 are: Fouquet, Roger and Stephen Broadberry, “Seven Centuries of European Economic Growth and Decline,” Journal of Economic Perspectives, 2015, 29 (4), 227–244.

ACCESS CONDITIONS: These data are available for download here: https://www.openicpsr.org/openicpsr/project/113961/version/V1/view

##########################
## Figure 7a ##############
##########################

This Figure was created using R. The code is "BD_Figure_7ab.R" contained in the folder "Figure 7". The source for the map shapefiles for 1300, 1500, and 1700 is: Nussli, Christos, http://www.euratlas.com/about.html.

ACCESS CONDITIONS: The Nussli maps are avalable for purchase from this website: http://www.euratlas.com/about.html.

##########################
## Figure 7b ##############
##########################


The data for Figure 7b were created using using the code in "BD_Figure_7ab.R" contained in the folder "Figure 7". The figure was created using Stata. The code are in "Figure 7b.do" contained in the folder "Figure 7". The source for the map shapefiles for 1300, 1500, and 1700 is: Nussli, Christos, http://www.euratlas.com/about.html.

ACCESS CONDITIONS: The Nussli maps are avalable for purchase from this website: http://www.euratlas.com/about.html.

##########################
## Table 1 ##############
##########################

Table 1 is reproduced from Jedwab, Remi, Noel Johnson, and Mark Koyama, “Pandemics, Places, and Populations: Evidence from the Black Death,” Technical Report DP13523, C.E.P.R. Discussion Papers 2019.








# End File