{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    acpi 
    arc-icon-theme
    arc-theme
    atom
    cargo
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
    haskellPackages.xmobar
    kbdd
    libnotify
    libpulseaudio
    light
    lldb
    lxappearance 
    lxappearance-gtk3
    nodePackages.peerflix
    openvpn
    pamixer
    pass
    pavucontrol
    pcmanfm
    pypi2nix
    qutebrowser
    rofi
    rofi-pass
    rustc
    rxvt_unicode-with-plugins
    tdesktop
    termite
    tmux
    wget 
    xbanish
    xclip
    xdotool
    xkblayout-state 
    xorg.xbacklight
    zathura

    myNeovim

    (python3.withPackages(ps: with ps; [ virtualenv lldb jedi ]))
  ];

  nixpkgs.config = {
    packageOverrides = pkgs: with pkgs; {
      myNeovim = neovim.override {
        vimAlias = true;
        withPython = true;
        configure = import ./vim/vim.nix;
      };
    };
  };
}
