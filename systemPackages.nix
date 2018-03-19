{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    acpi 
    autorandr
    arc-icon-theme
    arc-theme
    atom
    compton
    discord
    docker
    dunst
    firefox
    gcc 
    git 
    gnumake
    gnupg 

    go 
    gocode

    jetbrains.idea-community
    kbdd
    libnotify
    libpulseaudio
    light
    lxappearance 
    lxappearance-gtk3
    nodePackages.peerflix
    openvpn
    pamixer
    pass
    pavucontrol

    pcmanfm
    xfce.tumbler
    ffmpegthumbnailer

    pypi2nix

    termite
    tmux
    wget 
    xbanish
    xclip
    xdotool
    xkblayout-state 
    xorg.xbacklight
    evince

    shared_mime_info

    exfat
    ntfs3g


    myNeovim

    # This programms used from unstable due it has some troubles in stable
    # branch.
    qutebrowser # Issue with different versions of QT
    unstable.tdesktop # Issue with different versions of QT

    (python3.withPackages(ps: with ps; [ virtualenv lldb jedi ]))

    haskellPackages.xmobar
    haskellPackages.dbus
    haskellPackages.hlint
  ];

  nixpkgs.config = {
    packageOverrides = pkgs: with pkgs; {
      unstable = import <nixos-unstable> {
        config = config.nixpkgs.config;
      };

      myVim = vim_configurable.customize {
        name = "vim";
        vimrcConfig = (import ./vim/vim.nix);
      };
      
      myNeovim = neovim.override {
        vimAlias = true;
        withPython = true;
        configure = (import ./vim/vim.nix);
      };
    };

    firefox = {
      enableGoogleTalkPlugin = true;
      # enableAdobeFlash = true;
    };

    chromium = {
      enablePepperFlash = true; # Chromium removed support for Mozilla (NPAPI) plugins so Adobe Flash no longer works 
      enablePepperPDF = true;
    };
  };
}
