{
  description = "My first flake!";
    
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-matlab = {
      url = "gitlab:doronbehar/nix-matlab";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-matlab, ... }: 
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      flake-overlays = [
        nix-matlab.overlay
      ];
    in {
      nixosConfigurations = {
        CL-Elitebook = lib.nixosSystem {
          inherit system;
          modules = [
            (import ./configuration.nix flake-overlays)
          ];
        };
      };
      homeConfigurations = {
        cameron = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ]; 
        };
      };
  };
}

