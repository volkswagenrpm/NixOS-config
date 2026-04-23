{ self, inputs, ... }:
{

  flake.nixosModules.myMachineConfiguration =
    { pkgs, lib, ... }:
    {

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      environment.systemPackages = with pkgs; [
        neovim
        pear-desktop
        equibop
	fastfetch
	cava
	cmatrix
	git
	whitesur-icon-theme
	whitesur-cursors
	librsvg
	glib
	adwaita-icon-theme
	gnome-tweaks
	gnome-extension-manager
	sassc
	gearlever
	ripgrep
	fd
	lazygit
	gcc
	gnumake
	unimatrix
	fzf
	bat
	tldr
	httpie
	zoxide
	tmux
	glances
	ranger
	gdu
	hollywood
	lolcat
	cool-retro-term
	asciiquarium
	mission-center
	obsidian
	joplin-desktop
	super-productivity
	ulauncher
	localsend
	gimp
	obs-studio
	amberol
	vlc
	pipes
	cbonsai
	pywal
	chafa
	peaclock
	glances
	pokemon-colorscripts
	genact
	ghostty
	kitty
	tty-clock
	libreoffice
	thunderbird
	emacs
	vim
	vis
	krita
	audacity
	vscode
	vscodium
	inkscape
	fortune
	heroic
	lutris
	mangohud
	protonup-qt
	wget
	unzip
	zip
	# KDE Packages
	kdePackages.kdenlive
	# neovim plugins

	vimPlugins.LazyVim
      ];
      programs.firefox.enable = true;

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      system.stateVersion = "25.11";

      # you need a user, lol
      users.users.terminator = {
        isNormalUser = true;
        description = "terminator";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        packages = with pkgs; [
          #  thunderbird
        ];
      };

      # networking
      networking.hostName = "nixos"; # Define your hostname.
      networking.networkmanager.enable = true;

      # timezone and locale and keyboard
      services.xserver.xkb = {
        layout = "us";
        variant = "";
      };
      time.timeZone = "Africa/Cairo";
      i18n.defaultLocale = "en_US.UTF-8";
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
      };

      # audio
      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      # printing
      services.printing.enable = true;


      # Enable SDDM
      services.displayManager.sddm.enable = true;
      services.displayManager.sddm.wayland.enable = true;

      # Enable GNOME
      services.xserver.enable = true;
      services.xserver.desktopManager.gnome.enable = true;

      # Fix/Disable network disconnects when closing the lid of laptop
      services.logind.lidSwitch = "ignore";
      services.logind.lidSwitchDocked = "ignore";
      services.logind.lidSwitchExternalPower = "ignore";

      # Enable Flatpak
      services.flatpak.enable = true;

      # Enable the usage of unfree software/packages
      nixpkgs.config.allowUnfree = true;

      # Setup steam
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true; # Optional: for Remote Play
        dedicatedServer.openFirewall = true; # Optional: for Dedicated Servers
        localNetworkGameTransfers.openFirewall = true; # Optional: for Local Network Transfers
      };

      # Enable gamemode
      programs.gamemode.enable = true;

      # Enable gamescope
      programs.steam.gamescopeSession.enable = true;

      # Install/Enable proton ge
      programs.steam.extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];

    };

}
