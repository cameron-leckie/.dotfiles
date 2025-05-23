{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "cameron";
  home.homeDirectory = "/home/cameron";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    #########################
    ### Basic Development ###
    #########################

    gnuplot
    entr
    # g3data
    # zed-editor # waiting for stable release

    ##################
    ### Networking ###
    ##################
    vpnc # For strath vpn
    
    #################
    ### Aesthetic ###
    #################
    fastfetch
    
    ##############
    ### Office ###
    ##############
    zotero
    libsForQt5.kruler

    #############
    ### Games ###
    #############
    libsForQt5.kmines

    # Adds the 'hello' command to your environment. It prints a friendly
    # "Hello, world!" when run.
    hello

    # It is sometimes useful to fine-tune packages, for example, by applying
    # overrides. You can do that directly here, just don't forget the
    # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # fonts?
    (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # You can also create simple shell scripts directly inside your
    # configuration. For example, this adds a command 'my-hello' to your
    # environment:
    (writeShellScriptBin "my-hello" ''
      echo "Hello, ${config.home.username}!"
    '')
    
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/cameron/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Start Config here
  programs = {
    # Let Home Manager isntall and manage itself
    home-manager = {
      enable = true;
    };

    bash = {
      enable = true;
      shellAliases = { 
	cat = "bat";
	cd = "z";
        grep = "rg";
	PYTHON = "nix-shell -p python312 python312Packages.numpy python312Packages.scipy python312Packages.matplotlib python312Packages.sympy python312Packages.pandas --command \"python\"";

	# nonNixPrograms
        matlab = "nix-shell /home/cameron/nonNixBin/matlab-symbolicMathToolbox/matlab.nix";
        thinlinc = "nix-shell /home/cameron/nonNixBin/thinlinc/thinlinc.nix";

	# ssh shortuts
	wildebeest = "ssh -Y jjb20148@wildebeest.phys.strath.ac.uk";
	tcad = "ssh -Y tcad@130.159.216.57";
      };
      initExtra = "fastfetch";

    };

    git = {
      enable = true;
      userEmail = "cdl.public@proton.me";
      userName = "cameron-leckie";
    };

    neovim = { enable = true; };
    vim = { enable = true; };
    firefox = { enable = true; };
    fzf = { enable = true; };
    eza = { enable = true; };
    ripgrep = { enable = true; };
    zoxide = { enable = true; };

    bat = { 
      enable = true;
      config = { pager = "never"; };
    };
  };
}
