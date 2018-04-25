{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./layout-patch/patch.nix
    ./systemPackages.nix
    ./openvpn.nix
    ./wg.nix
  ];

  nixpkgs.overlays = [ 
    (import (builtins.fetchTarball https://github.com/pltanton/nix-overlays/archive/master.tar.gz))
  ];

  boot = {
    extraModulePackages = [ config.boot.kernelPackages.wireguard ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    plymouth.enable = true;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ 22 8888 ];
  };

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "dvp";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Europe/Moscow";

  nixpkgs.config.allowUnfree = true;

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      fira-mono hack-font dejavu_fonts font-awesome-ttf terminus_font libertine
      liberation_ttf_v2_binary
    ];
  };

  hardware = {
    pulseaudio.enable = true;
    pulseaudio.package = pkgs.pulseaudioFull;
    pulseaudio.support32Bit = true;

    bluetooth.enable = true;

    opengl.driSupport32Bit = true;

    trackpoint = {
      enable = true;
      emulateWheel = true;
    };
  };

  nixpkgs.config.pulseaudio = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.liveRestore = false;

  services = {
    openssh.enable = true;
    printing.enable = true;
    printing.drivers = [ pkgs.gutenprint ];
    pcscd.enable = true;
    upower.enable = true;

    udev.extraRules = builtins.readFile ./udev;

    syncthing = {
      enable = true;
      dataDir = "/home/anton/.syncthing";
      user = "anton";
    };

    xserver = {
      enable = true;
      layout = "us,ru";
      xkbVariant = "dvp,diktor";
      xkbOptions = "eurosign:e,grp:rctrl_toggle";
      libinput.enable = true;

      displayManager.lightdm.enable = true;
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = hpkgs: [ hpkgs.xmobar hpkgs.udev hpkgs.async ];
      };

      config = pkgs.lib.mkOverride 50 (builtins.readFile ./xorg.conf);
    };
  };

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
  users.users.anton.packages = [
    pkgs.steam
  ];

  system = {
    autoUpgrade.enable = true;
    autoUpgrade.channel = "https://nixos.org/channels/nixos-unstable";
    stateVersion = "unstable";
  };
}
