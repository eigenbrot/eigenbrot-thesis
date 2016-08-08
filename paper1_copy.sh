#!/bin/bash

FILES="ms_n891_paper1.tex introduction1.tex gradpak.tex obs.tex redux.tex maps.tex results1.tex conclusion1.tex appendix1.tex"

for f in $FILES; do 
    echo ../891_paper/$f
    FIGS=`grep \includegraphics ../891_paper/$f | sed -n -e '/^\s/ s/.*figs\/\(.*\)\}/\1/p'`
    for ff in $FIGS; do
	printf '\t%s\n' ../891_paper/figs/$ff
	cp ../891_paper/figs/$ff 891_1/figs/
    done
done
