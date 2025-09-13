##
# Project Title
#
# @file
# @version 0.1

NIXOS_HOST=$(shell hostname)
# NIXOS_HOST_CONFIG=./hosts/$(NIXOS_HOST)/configuration.nix

# make NIXOS_HOST=helius buildthis

.PHONY: build switch repl
build:
	nixos-rebuild build --flake ".#nixosConfigurations.$(NIXOS_HOST)"

switch:
	sudo nixos-rebuild build --flake ".#nixosConfigurations.$(NIXOS_HOST)"

repl:
	nix repl ".#nixosConfigurations.$(NIXOS_HOST)"

.PHONY:
nhbuild:
	nh os switch . -- --show-trace

# end
