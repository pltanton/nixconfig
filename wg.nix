{ config, pkgs, ... }:

{
  networking.wireguard.interfaces = {
    wg0-kaliwe = {
      ips = [ "10.0.0.2/24" ];
      privateKeyFile = "/root/nixos/wg/kaliwe";

      peers = [
        {
          publicKey = "tP01hSbQlw5sy8jKPnfF/LjWWuggHSS/7H6Cf4ZI3AE=";
          allowedIPs = [ "10.0.0.0/24" ];
          endpoint = "kaliwe.ru:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}

