{
  config,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    substitute = true;
    auto-optimise-store = true;
  };
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./devices/laptop.nix
    ./imports/core-pkgs.nix
    ./imports/other.nix
    ./imports/games.nix
    #./imports/env.nix
    ./imports/smb.nix
    ./imports/nixvim-config/nixvim.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #  boot.kernelParams = [ "i915.enable_psr=0" ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  networking.networkmanager.enable = true;

  time.timeZone = "Pacific/Auckland";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_NZ.UTF-8";
    LC_IDENTIFICATION = "en_NZ.UTF-8";
    LC_MEASUREMENT = "en_NZ.UTF-8";
    LC_MONETARY = "en_NZ.UTF-8";
    LC_NAME = "en_NZ.UTF-8";
    LC_NUMERIC = "en_NZ.UTF-8";
    LC_PAPER = "en_NZ.UTF-8";
    LC_TELEPHONE = "en_NZ.UTF-8";
    LC_TIME = "en_NZ.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  #  Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.libinput.enable = true;
  #  Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jordan = {
    isNormalUser = true;
    description = "Jordan";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "jordan";
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  networking.firewall = {
    allowedTCPPorts = [8080];
    allowedUDPPorts = [8080];
  };

  boot.supportedFilesystems = ["zfs"];
  boot.zfs.forceImportRoot = false;
  services.thermald.enable = true;

  fonts.fontDir.enable = true;
  fonts.fontconfig.enable = true;
}
