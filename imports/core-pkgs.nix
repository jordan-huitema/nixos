{
  config,
  pkgs,
  ...
}: {
  #  shellCustom = import ( builtins.fetchUrl "https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh")
  services = {
    #supergfxd = {
    #  enable = true;
    #};
    asusd = {
      enable = true;
      enableUserService = true;
    };
  };
  environment.systemPackages = with pkgs; [
    wget
    curl
    firefox
    vlc
    git
    git-lfs
    htop
    btop
    thermald
    gnomeExtensions.x11-gestures
    gnomeExtensions.tophat
    zfs
    niv
    alejandra
  ];
 
  services.thermald.enable = true;
}
