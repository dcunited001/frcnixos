##
# Project Title
#
# @file
# @version 0.1

NIXOS_HOST=$(shell hostname)
# NIXOS_HOST_CONFIG=./hosts/$(NIXOS_HOST)/configuration.nix

# make NIXOS_HOST=helius buildthis

.PHONY: buildthis switchthis replthis
buildthis:
	nixos-rebuild build --flake ".#nixosConfigurations.$(NIXOS_HOST)"

switchthis:
	sudo nixos-rebuild build --flake ".#nixosConfigurations.$(NIXOS_HOST)"

replthis:
	nix repl ".#nixosConfigurations.$(NIXOS_HOST)"

.PHONY:
nhbuild:
	nh os switch . -- --show-trace

# end
