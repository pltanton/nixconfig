#pip setuptools Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./layout-patch/patch.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true;
    nameservers = [ "8.8.8.8" ];
  };

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "dvp";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Europe/Moscow";

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    xorg.xbacklight
    xkblayout-state
    xclip
    lxappearance-gtk3
    arc-theme
    arc-icon-theme
    dunst
    pcmanfm
    wget firefox qutebrowser
    neovim termite tmux
    atom
    acpi openvpn
    lxappearance rofi pamixer light kbdd  compton
    haskellPackages.xmobar
    tdesktop
    git go gcc libpulseaudio
    rustc cargo
    gnumake
    discord
    pypi2nix
    docker
    lldb
    zathura
    xdotool
    pavucontrol

    nodePackages.peerflix

    (python3.withPackages(ps: with ps; [ pip virtualenv neovim lldb ]))
    (python3.withPackages(ps: with ps; [ lldb ]))
  ];



  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      fira-mono hack-font dejavu_fonts font-awesome-ttf terminus_font libertine
    ];
  };

  hardware = {
    pulseaudio.enable = true;
    pulseaudio.package = pkgs.pulseaudioFull;

    bluetooth.enable = true;
  };
  nixpkgs.config.pulseaudio = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:
  
  virtualisation.docker.enable = true;
  virtualisation.docker.liveRestore = false;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us,ru";
  services.xserver.xkbVariant = "dvp,diktor";
  services.xserver.xkbOptions = "eurosign:e,grp:rctrl_toggle";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    extraPackages = hpkgs: [ hpkgs.xmobar ];
  };
  # services.xserver.desktopManager.gnome3.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.zsh.enable = true;
  users.extraUsers= {
    anton = {
      isNormalUser = true;
      home = "/home/anton";
      shell = pkgs.zsh;
      extraGroups = [ "wheel" "networkmanager" "audio" "docker" ];
    };
    julsa = {
      isNormalUser = true;
      home = "/home/julsa";
      shell = pkgs.zsh;
      extraGroups = [ "wheel" "networkmanager" "audio" "docker" ];
    };
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.autoUpgrade.enable = true;
  system.autoUpgrade.channel = "https://nixos.org/channels/nixos-unstable";
  system.stateVersion = "unstable"; # Did you read the comment?

}
