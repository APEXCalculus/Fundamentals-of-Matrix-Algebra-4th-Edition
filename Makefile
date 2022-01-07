# Makefile for the LaTeX document.
# This file, on Unix-like systems, will compile the document up to 8(!) times,
# halting when -egrep- no longer finds "hey, you might need to re-run this."

#title=booktest
title = Fundamentals_of_Matrix_Algebra

all: $(title).pdf

pdf: $(title).pdf

$(title).pdf: clean $(title).tex
	xelatex $(title).tex
	latex_count=8 ;\
	while egrep -s 'Package rerunfilecheck Warning' $(title).log && [ $$latex_count -gt 0 ] ;\
	do \
    	echo "Rerunning xelatex...." ;\
		xelatex $(title).tex ;\
		latex_count=`expr $$latex_count - 1`;\
	done
	while egrep -s 'LaTeX Warning: Label(s) may have changed.' $(title).log && [ $$latex_count -gt 0 ] ;\
	do \
		echo "Rerunning xelatex...." ;\
		xelatex $(title).tex ;\
		latex_count=`expr $$latex_count - 1` ;\
		xelatex $(title).tex ;\
	done
	while egrep -s 'LaTeX Warning: There were undefined references.' $(title).log && [ $$latex_count -gt 0 ] ;\
	do \
		echo "Rerunning xelatex...." ;\
		xelatex $(title).tex ;\
		latex_count=`expr $$latex_count - 1` ;\
		xelatex $(title).tex ;\
	done

clean:
	rm -f $(title).ps $(title).dvi $(title).aux $(title).toc $(title).idx $(title).ind $(title).ilg $(title).log $(title).out $(title).brf $(title).blg $(title).bbl $(title).pdf
