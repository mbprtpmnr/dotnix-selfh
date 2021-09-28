{
  description = "mbprtpmnr's NixOS System";

  inputs = {
    oldstable.url = "github:NixOS/nixpkgs?ref=nixos-20.09";
    stable.url = "github:NixOS/nixpkgs?ref=nixos-21.05";
    unstable.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    master.url = "github:NixOS/nixpkgs?ref=master";
    nix-doom-emacs = {
      url = "github:vlaci/nix-doom-emacs";
      inputs.nixpkgs.follows = "unstable";
      inputs.flake-utils.follows = "fu";
    };
    nix = {
      url = "github:NixOS/nix";
      inputs.nixpkgs.follows = "unstable";
    };
    agenix.url = "github:ryantm/agenix";
    devshell.url = "github:numtide/devshell";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "unstable";
    };
    fu.url = "github:numtide/flake-utils";
    fup = {
      url = "github:gytis-ivaskevicius/flake-utils-plus/1.3.0";
      inputs.flake-utils.follows = "fu";
    };
    npgh = {
      url = "github:seppeljordan/nix-prefetch-github";
      inputs.nixpkgs.follows = "unstable";
      inputs.flake-utils.follows = "fu";
    };
    vim-horizon = {
      url = "github:ntk148v/vim-horizon";
      flake = false;
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "unstable";
    };
  };

  outputs = { self, stable, nix-doom-emacs, nur, unstable, master, agenix, home-manager, fu, fup, ... }@inputs:
    fup.lib.mkFlake {
      inherit self inputs;
  
      channels.nixpkgs = {
        input = unstable;
        config = {
          allowUnfree = true;
        };
      };
  
      channels.stable = {
        input = stable;
        config = {
          allowUnfree = true;
        };
      };
  
      hostDefaults.modules = [
        inputs.agenix.nixosModules.age
        inputs.sops-nix.nixosModules.sops
        inputs.home-manager.nixosModule {
          home-manager = {
            extraSpecialArgs = { inherit inputs self; };
            useGlobalPkgs = true;
          };
        }
      ];
  
      channels.nixpkgs.overlaysBuilder = channels: [
        (final: prev: { inherit (channels) stable; })
        self.overlay
        inputs.devshell.overlay
        inputs.fup.overlay
      ];
  
      hosts = {
        nixos = {
          modules = [
            ./system/configuration.nix
          ];
        };

        iso = {
          builder = unstable.lib.makeOverridable unstable.lib.nixosSystem;
          modules = [
            ./system/modules/iso.nix
            {
              home-manager.users.mbprtpmnr.imports = [
                ./home/home.nix
              ];
            }
          ];
        };
      };
      
      homeConfigurations = let
        username = "mbprtpmnr";
        homeDirectory = "/home/${username}";
        system = "x86_64-linux";
        pkgs = self.pkgs.${system}.nixpkgs;
        stateVersion = "21.11";
        extraSpecialArgs = { inherit inputs self; };
        generateHome = inputs.home-manager.lib.homeManagerConfiguration;
        nixpkgs = {
          config = { allowUnfree = true; };
        };
      in {
        "mbprtpmnr@nixos" = generateHome {
          inherit system homeDirectory username stateVersion pkgs extraSpecialArgs;
          configuration = {
            imports = [ nix-doom-emacs.hmModule ./home/home.nix ];
            inherit nixpkgs;
          };
        };
      };
  
      nixos = inputs.self.nixosConfigurations.nixos.config.system.build.toplevel;
      
      sharedOverlays = [
        self.overlay
        nur.overlay
      ];

      overlay = import ./system/overlays/packages.nix;
      overlays = fup.lib.exportOverlays {
        inherit (self) pkgs inputs;
      };

      outputsBuilder = channels: {
        packages = fup.lib.exportPackages self.overlays channels;
        devShell = channels.nixpkgs.devshell.mkShell {
          packages = with channels.nixpkgs; [ nixpkgs-fmt rnix-lsp ];
          name = "dots";
        };
      };
    };
}
