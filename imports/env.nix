{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    pyenv
    python3Full
    python312Full
    gcc-unwrapped
    libstdcxx5
    stdenv.cc.cc
  ];
}
