FILENAME = eigenbrot_thesis
TEX = pdflatex
BIB = bibtex
FRD = FRD/FRD
GPB = Pak_build/Pak_build

all: 
	$(TEX) $(FILENAME).tex
	cd FRD && $(BIB) FRD
	cd Pak_build && $(BIB) Pak_build
	$(TEX) $(FILENAME).tex
	$(TEX) $(FILENAME).tex
	$(TEX) $(FILENAME).tex

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

clean::
	rm -fv *.aux *.log *.bbl *.blg *.toc *.lof *.lot *.out
	rm -fv */*.aux */*.log */*.bbl */*.blg */*.toc */*.lof */*.lot */*.out