{inputs, ...}: {
  systems = import inputs.systems;

  perSystem = {
    inputs',
    pkgs,
    ...
  }: {
    devShells.default = import ./shell.nix {inherit inputs' pkgs;};
  };

  flake = {
    nixosConfigurations = {
      "instance-20250420-1819" = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          inputs.disko.nixosModules.disko
          ./configuration.nix
          ./hardware-configuration.nix
        ];
      };
    };
  };
}
