{
 description = " first flake" ;
 
 inputs = {
   nixpkgs.url = "nixpkgs/nixos-23.11" ;
   hyprland.url = "github:hyprwm/Hyprland" ;
   home-manager.url = "github:nix-community/home-manager/release-23.11" ;
   home-manager.inputs.nixpkgs.follows =  "nixpkgs" ;
 };
 
 
 outputs = {self, nixpkgs, home-manager, hyprland, ...}:
   let
     lib = nixpkgs.lib;
     system = "x86_64-linux";
     pkgs = nixpkgs.legacyPackages.${system};
   in {
   nixosConfigurations = {
     nixos = lib.nixosSystem {
       inherit system ;
       modules = [ ./configuration.nix ];
      };
    };
     homeConfigurations = {
     tarrens = home-manager.lib.homeManagerConfiguration {
       inherit pkgs;
       modules = [ ./home.nix
                            hyprland.homeManagerModules.default
                           { wayland.windowManager.hyprland.enable = true; }

                          ];
       };
     };
     
     
     
   }; 
 
}
