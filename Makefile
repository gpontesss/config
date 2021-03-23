MOUNT = $(HOME)
DOTSDIR = .config
DOTSABSDIR = $(PWD)/$(DOTSDIR)

# du for autism (plus, find is quite confusing)
DOTS = $(shell du -a $(DOTSDIR)/* | cut -d'	' -f2 -)
DOTS_SRC = $(addprefix $(PWD)/,$(DOTS))
DOTS_DST = $(addprefix $(MOUNT)/,$(DOTS))


.PHONY: all
all: $(DOTS_DST)

$(MOUNT)/$(DOTSDIR)/%: $(DOTSABSDIR)/%
	@echo "Linking $^ dotfile"
	@mkdir -p $(dir $@)
	@ln -fs $^ $@

.PHONY: clean-dotfiles
clean-dotfiles:
	@rm -rf $(DOTS_DST)

.PHONY: clean
clean: clean-dotfiles
