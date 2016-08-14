#!/bin/bash

FILES="introduction2.tex data2.tex basic_anal.tex LOS.tex SSP.tex chisq.tex SSP_err.tex results2.tex conclusion2.tex"

for f in $FILES; do 
    echo ../891_paper/$f
    FIGS=`grep \includegraphics ../891_paper/$f | sed -n -e '/^\s/ s/.*figs\/\(.*\)\}/\1/p'`
    for ff in $FIGS; do
	printf '\t%s\n' ../891_paper/figs/$ff
	cp ../891_paper/figs/$ff 891_2/figs/
    done
done
