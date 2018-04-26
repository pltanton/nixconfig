{ config, pkgs, ... }:

{
  networking.wireguard.interfaces = {
    wg0-kaliwe = let 
      host = "89.40.118.250";
      ip = "${pkgs.iproute}/bin/ip";
      rules = action: [
        "${ip} rule ${action} to 10.101.0.0/16 lookup main pref 30" # OpenWay subnet
        "${ip} rule ${action} to ${host} lookup main pref 30"
        "${ip} rule ${action} to all lookup 80 pref 40"
        "${ip} route ${action} default dev wg0-kaliwe table 80"
      ];

    in {
      ips = [ "10.10.10.4/32" ];
      privateKeyFile = "/root/nixos/wg/kaliwe";
      allowedIPsAsRoutes = false;
      postSetup = rules "add"; 
      postShutdown = rules "del";

      peers = [
        {
          publicKey = "tP01hSbQlw5sy8jKPnfF/LjWWuggHSS/7H6Cf4ZI3AE=";
          allowedIPs = [ "0.0.0.0/0" ];
          endpoint = "${host}:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}

