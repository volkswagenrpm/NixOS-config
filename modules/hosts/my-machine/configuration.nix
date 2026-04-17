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
      ];
      programs.firefox.enable = true;

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      system.stateVersion = "25.11";

      # you need a user, lol
      users.users.dude = {
        isNormalUser = true;
        description = "dude";
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

      # Enable KDE
      services.desktopManager.plasma6.enable = true;

      # Enable SDDM
      services.displayManager.sddm.enable = true;
      services.displayManager.sddm.wayland.enable = true;

    };

}
