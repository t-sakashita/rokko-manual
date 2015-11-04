BASENAME = master
SRC = ${BASENAME}-en.tex style/*.sty #style/*.bb
SRC-JP = ${BASENAME}-jp.tex style/*.sty #style/*.bb

default: ${BASENAME}-en.pdf

try:  ${BASENAME}-en.tex ${SRC}
	TEXINPUTS=.:./style//: pdflatex ${BASENAME}-en.tex

en: ${BASENAME}-en.pdf
jp: ${BASENAME}-jp.pdf

${BASENAME}-en.pdf: ${BASENAME}-en.tex ${SRC}
	TEXINPUTS=.:./style//: pdflatex -shell-escape ${BASENAME}-en.tex
	bibtex ${BASENAME}-en
	TEXINPUTS=.:./style//: pdflatex ${BASENAME}-en.tex
	TEXINPUTS=.:./style//: pdflatex ${BASENAME}-en.tex

${BASENAME}-jp.dvi: ${BASENAME}-jp.tex ${SRC-JP}
	TEXINPUTS=.:./style//: platex -shell-escape ${BASENAME}-jp.tex
	pbibtex ${BASENAME}-jp
	TEXINPUTS=.:./style//: platex ${BASENAME}-jp.tex
	TEXINPUTS=.:./style//: platex ${BASENAME}-jp.tex

${BASENAME}-jp.pdf: ${BASENAME}-jp.dvi
	TEXINPUTS=.:./style//: dvipdfmx ${BASENAME}-jp.dvi

clean:
	rm -f ${BASENAME}*.aux ${BASENAME}*.dvi ${BASENAME}*.log ${BASENAME}*.nav ${BASENAME}*.out ${BASENAME}*.snm ${BASENAME}*.toc ${BASENAME}*.vrb
	rm -rf auto *.xbb ./figure/*.xbb ./style/*.xbb

distclean: clean
	rm -f ${BASENAME}-en.pdf ${BASENAME}-jp.pdf
