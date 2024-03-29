SCRIPT_DST = /usr/local/bin

DOTS_SRC = .config .local .tmux.conf .profile .bashrc
DOTS_DST = $(HOME)
DOTS_TARGETS = $(addprefix $(DOTS_DST)/,$(shell find $(DOTS_SRC) -type f))

ACPI_SRC = acpi
ACPI_DST = /etc
ACPI_TARGETS = $(addprefix $(ACPI_DST)/,$(shell find $(ACPI_SRC) -type f))

TRANSMISSION_HOME = /var/lib/transmission/.config/transmission-daemon
TRANSMISSION_TARGETS  = $(TRANSMISSION_HOME)/settings.json

.PHONY: all
all: $(SCRIPT_DST)/cfg dotfiles acpi transmission

$(SCRIPT_DST)/cfg: cfg
	@echo "Installing cfg script"
	@ln -fs $(abspath $^) $@

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

.PHONY: transmission
transmission: $(TRANSMISSION_TARGETS)

$(TRANSMISSION_HOME)/%: transmission/%
	@-systemctl stop transmission
	@mkdir -p $(dir $@)
	@cp "$^" "$@"
	@chown transmission:transmission "$@"
	@-systemctl start transmission

.PHONY: clean-dotfiles
clean-dotfiles:
	rm -rf $(DOTS_TARGETS)

.PHONY: clean-acpi
clean-acpi:
	rm -rf $(ACPI_TARGETS)

.PHONY: clean-transmission
clean-transmission:
	@rm -rf $(TRANSMISSION_TARGETS)

.PHONY: clean
clean: clean-dotfiles clean-acpi clean-transmission
