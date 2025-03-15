{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    musikcube
    bambu-studio
    freecad
    handbrake
    shotcut
  ];
}
