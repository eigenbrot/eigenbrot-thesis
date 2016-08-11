#!/bin/bash

FIGS=`grep \includegraphics Appendices/appendix1.tex | sed -n -e 's/.*figs\/\(.*\)\}/\1/p'`
for ff in $FIGS; do
    printf '\t%s\n' 891_1/figs/$ff
    git mv 891_1/figs/$ff Appendices/figs/
done

