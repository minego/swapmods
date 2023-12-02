{
	description			= "A flake for building my swapmod plugin for interception-tools";
	inputs.nixpkgs.url	= "github:NixOS/nixpkgs/nixos-unstable";

	outputs = { self, nixpkgs }: {
		overlay = self: super: {
			minego = (super.minego or {}) // {
				swapmod = super.pkgs.callPackage ./derivation.nix { };
			};
		};

		packages = {
			"x86_64-linux" = rec {
				swapmod = nixpkgs.legacyPackages."x86_64-linux".callPackage ./derivation.nix { };
				default = swapmod;
			};
			"aarch64-linux" = rec {
				swapmod = nixpkgs.legacyPackages."aarch64-linux".callPackage ./derivation.nix { };
				default = swapmod;
			};
		};
	};
}


