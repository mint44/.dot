{
  description = "littlemac flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    # mac-app-util.url = "github:hraban/mac-app-util";
    # Optional: Declarative tap management
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle, ... }:
  let
    configuration = { pkgs, config, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ 
            pkgs.vim
            pkgs.neovim
            pkgs.btop
            pkgs.kitty
            pkgs.yabai
            pkgs.skhd

        ];
      homebrew={
        enable = true;
      	casks = [
          "visual-studio-code"
          "karabiner-elements"
          # "bettertouchtool"
          "hammerspoon"
          "discord"
          "lulu"
          "spotify"
          "vlc"
          "notion"
          # "zoom"
          # "teamviewer"
          # "zotero"
          # "google-drive"
          # "transmission"
          # "slidepilot"
          # "audacity"
          # "slack"
          # "steam"
          # "ollama"
	      ];
	    onActivation.cleanup = "zap";
      };
      services.yabai.enable = true;
      services.yabai.enableScriptingAddition = true;
      # services.yabai.config 
      services.skhd.enable = true;
      # services.skhd.skhdConfig =" string concated with \n"



      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;
      programs.zsh.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."littlemac" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
	    #apple silicon
            enableRosetta = true;
            user = "minhb";

            # Optional: Declarative tap management
            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
              "homebrew/homebrew-bundle" = homebrew-bundle;
            };
            mutableTaps = false;

          };
        }

       ];
    };
  };
}
