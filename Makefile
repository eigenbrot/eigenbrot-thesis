FILENAME = eigenbrot_thesis
TEX = pdflatex
BIB = bibtex
INTRO=Introduction/Introduction
FRD = FRD/FRD
GPB = Pak_build/Pak_build
8911 = 891_1/891_1
8912 = 891_2/891_2
CONC = Conclusion/Conclusion

all: 
	$(TEX) $(FILENAME).tex
	cd Introduction && $(BIB) Introduction
	cd FRD && $(BIB) FRD
	cd Pak_build && $(BIB) Pak_build
	cd 891_1 && $(BIB) 891_1
	cd 891_2 && $(BIB) 891_2
	cd Appendix && $(BIB) Appendix
	cd Appendix && $(BIB) tau_model
	$(TEX) $(FILENAME).tex
	$(TEX) $(FILENAME).tex

intro::
	$(TEX) '\includeonly{$(INTRO)}\input{$(FILENAME)}'
	cd Introduction && $(BIB) Introduction
	$(TEX) '\includeonly{$(INTRO)}\input{$(FILENAME)}'
	$(TEX) '\includeonly{$(INTRO)}\input{$(FILENAME)}'

FRD:: 
	$(TEX) '\includeonly{$(FRD)}\input{$(FILENAME)}'
	cd FRD && $(BIB) FRD
	$(TEX) '\includeonly{$(FRD)}\input{$(FILENAME)}'
	$(TEX) '\includeonly{$(FRD)}\input{$(FILENAME)}'

Pak::
	$(TEX) '\includeonly{$(GPB)}\input{$(FILENAME)}'
	cd Pak_build && $(BIB) Pak_build
	$(TEX) '\includeonly{$(GPB)}\input{$(FILENAME)}'
	$(TEX) '\includeonly{$(GPB)}\input{$(FILENAME)}'

8911::
	$(TEX) '\includeonly{$(8911)}\input{$(FILENAME)}'
	cd 891_1 && $(BIB) 891_1
	$(TEX) '\includeonly{$(8911)}\input{$(FILENAME)}'
	$(TEX) '\includeonly{$(8911)}\input{$(FILENAME)}'	

conclusion::
	$(TEX) '\includeonly{$(CONC)}\input{$(FILENAME)}'
#	cd Conclusion && $(BIB) Conclusion
	$(TEX) '\includeonly{$(CONC)}\input{$(FILENAME)}'
	$(TEX) '\includeonly{$(CONC)}\input{$(FILENAME)}'

new::
	$(TEX) '\includeonly{$(INTRO),$(CONC)}\input{$(FILENAME)}'
	cd Introduction && $(BIB) Introduction
	$(TEX) '\includeonly{$(INTRO),$(CONC)}\input{$(FILENAME)}'
	$(TEX) '\includeonly{$(INTRO),$(CONC)}\input{$(FILENAME)}'

clean::
	rm -fv *.aux *.log *.bbl *.blg *.toc *.lof *.lot *.out
	rm -fv */*.aux */*.log */*.bbl */*.blg */*.toc */*.lof */*.lot */*.out
