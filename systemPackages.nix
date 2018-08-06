{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    acpi 
    docker
    gcc 
    git

    libpulseaudio
    light
    pamixer
    pass
    pavucontrol

    pcmanfm
    xfce.tumbler
    ffmpegthumbnailer

    pypi2nix

    exfat
    ntfs3g
    nfs-utils
    suidChroot
    xboxdrv

    vim

    wireguard
    sshfs
  ];
}
