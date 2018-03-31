{ config, pkgs, ... }:

{
  environment.shellAliases = let
    openWayVpnConfigFile = pkgs.writeText "openvpn-config-OpenWayVPN"
        ''
          errors-to-stderr
          config /root/nixos/openvpn/OpenWayVPN.conf
          pkcs11-providers ${pkgs.sac-core}/lib/libeToken.so.9.1.7
          script-security 2
          up ${pkgs.update-resolv-conf}/libexec/openvpn/update-resolv-conf
          down ${pkgs.update-resolv-conf}/libexec/openvpn/update-resolv-conf
        '';
  in { 
    openvpn-OpenWayVPN = "sudo openvpn ${openWayVpnConfigFile}";
  };

  services = {
    openvpn.servers = {
      kaliweVPN = {
        config = '' config /root/nixos/openvpn/kaliweVPN.conf '';
        autoStart = false;
      };
    };
  };
}
