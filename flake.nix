{
	description			= "A flake for building my swapmods plugin for interception-tools";
	inputs.nixpkgs.url	= "github:NixOS/nixpkgs/nixos-unstable";

	outputs = { self, nixpkgs, ... }:
	{
		packages.x86_64-linux.default = 
			with import nixpkgs { system = "x86_64-linux"; };

		stdenv.mkDerivation rec {
			name	= "swapmods";
			version	= "0.0.1";
			src		= self;

			installPhase = ''
				mkdir -p $out/bin
				cp swapmods $out/bin/
			'';

			meta = with lib; {
				homepage	= "https://github.com/minego/swapmods";
				description	= "Swap alt and super";
				license		= licenses.asl20; # Apache-2.0
				platforms	= platforms.linux;
			};
		};

		overlay = final: prev: {
			swapmods = self.packages.x86_64-linux.default;
		};
	};
}
