{
	description			= "A flake for building my swapmods plugin for interception-tools";

	inputs = {
		nixpkgs.url		= "github:NixOS/nixpkgs/nixos-unstable";
		flake-utils.url	= "github:numtide/flake-utils";
	};

	outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ]  (system:
		let pkgs = nixpkgs.legacyPackages.${system}; in
	{
		packages = rec {
			swapmods = pkgs.callPackage ./derivation.nix { };
			default = swapmods;
		};

		overlay = self: super: {
			minego = (super.minego or {}) // {
				swapmods = super.pkgs.callPackage ./derivation.nix { };
			};
		};
	});
}


