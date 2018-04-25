{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    sac-core

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

    vim

    wireguard
  ];
}
