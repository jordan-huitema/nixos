{ config, pkgs, ...}: 
{
  # For mount.cifs, required unless domain name resolution is not needed.
  environment.systemPackages = [ pkgs.cifs-utils ];
  fileSystems."/mnt/array" = {
    device = "//10.1.1.101/array/share";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "gid=users,uid=jordan,x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

    in ["${automount_opts},credentials=/home/jordan/secrets/smb-secrets"];
  };
}
