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
	kitty
	whitesur-icon-theme
	whitesur-cursors
	librsvg
	glib
	adwaita-icon-theme
	gnome-tweaks
	gnome-extension-manager
	sassc
	glib
	gearlever
	ripgrep
	fd
	lazygit
	gcc
	gnumake
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
      services.xserver.desktopManager.gnome.enable = true;
      services.xserver.enable = true;

      # Fix/Disable Network disconnects when closing the lid of the laptop
      services.logind.lidSwitch = "ignore";
      services.logind.lidSwitchDocked = "ignore";

    };

}
