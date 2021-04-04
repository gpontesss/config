DOTS_SRC = .config .local .tmux.conf .Xresources .profile .bashrc
DOTS_DST = $(HOME)
DOTS_TARGETS = $(addprefix $(DOTS_DST)/,$(shell find $(DOTS_SRC) -type f))

ACPI_SRC = acpi
ACPI_DST = /etc
ACPI_TARGETS = $(addprefix $(ACPI_DST)/,$(shell find $(ACPI_SRC) -type f))

.PHONY: all
all: dotfiles acpi

dotfiles: $(DOTS_TARGETS)

$(DOTS_DST)/%: %
	@echo "Linking $^ dotfile"
	@mkdir -p $(dir $@)
	@ln -fs $(abspath $^) $@

.PHONY: acpi
acpi: $(ACPI_TARGETS)

$(ACPI_DST)/%: %
	@echo "Linking $^ acpi file"
	@mkdir -p $(dir $@)
	@ln -fs $(abspath $^) $@

.PHONY: clean-dotfiles
clean-dotfiles:
	rm -rf $(DOTS_TARGETS)

.PHONY: clean-acpi
clean-acpi:
	rm -rf $(ACPI_TARGETS)

.PHONY: clean
clean: clean-dotfiles clean-acpi
