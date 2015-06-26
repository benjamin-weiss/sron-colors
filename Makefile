INS = sron-colors.ins
DTX = sron-colors.dtx
STY = sron-colors.sty
PDF = sron-colors.pdf

TEXMFHOME = $(shell kpsewhich -var-value=TEXMFHOME)
INSTALL_DIR = $(TEXMFHOME)/tex/latex/sron-colors
DOC_DIR = $(TEXMFHOME)/doc/latex/sron-colors
TEMP_DIR = .temptex

TEXC := latexmk -xelatex -output-directory=$(TEMP_DIR)

.PHONY: sty doc

all: sty doc

$(STY): $(DTX) $(INS)
	@latex $(INS)

$(PDF): $(STY) $(DTX)
	@$(TEXC) $(DTX)
	@cp $(TEMP_DIR)/$(PDF) .

sty: $(STY)

doc: $(PDF)

clean:
	@git clean -xfd

install: $(STY) $(PDF)
	@mkdir -p $(INSTALL_DIR)
	@cp $(STY) $(INSTALL_DIR)
	@mkdir -p $(DOC_DIR)
	@cp $(PDF) $(DOC_DIR)

uninstall:
	@rm -f $(addprefix $(INSTALL_DIR)/, $(STY))
	@rm -f $(DOC_DIR)/$(PDF)
	@rmdir $(INSTALL_DIR)
	@rmdir $(DOC_DIR)
