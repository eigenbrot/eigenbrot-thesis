FILENAME = eigenbrot_thesis
TEX = pdflatex
BIB = bibtex
INTRO=Introduction/Introduction
FRD = FRD/FRD
GPB = Pak_build/Pak_build
8911 = 891_1/891_1

all: 
	$(TEX) $(FILENAME).tex
	cd Introduction && $(BIB) Introduction
	cd FRD && $(BIB) FRD
	cd Pak_build && $(BIB) Pak_build
	cd 891_1 && $(BIB) 891_1
	$(TEX) $(FILENAME).tex
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
	$(TEX) '\includeonly{$(FRD)}\input{$(FILENAME)}'

Pak::
	$(TEX) '\includeonly{$(GPB)}\input{$(FILENAME)}'
	cd Pak_build && $(BIB) Pak_build
	$(TEX) '\includeonly{$(GPB)}\input{$(FILENAME)}'
	$(TEX) '\includeonly{$(GPB)}\input{$(FILENAME)}'
	$(TEX) '\includeonly{$(GPB)}\input{$(FILENAME)}'

8911::
	$(TEX) '\includeonly{$(8911)}\input{$(FILENAME)}'
	cd 891_1 && $(BIB) 891_1
	$(TEX) '\includeonly{$(8911)}\input{$(FILENAME)}'
	$(TEX) '\includeonly{$(8911)}\input{$(FILENAME)}'
	$(TEX) '\includeonly{$(8911)}\input{$(FILENAME)}'	

clean::
	rm -fv *.aux *.log *.bbl *.blg *.toc *.lof *.lot *.out
	rm -fv */*.aux */*.log */*.bbl */*.blg */*.toc */*.lof */*.lot */*.out
