{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = inputs: {
    nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
      modules = [ ./configuration.nix ./hardware.nix ];
      system = "x86_64-linux";
      specialArgs  = { inherit inputs; };
    };
  };
}
