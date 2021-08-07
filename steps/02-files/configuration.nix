{ config, lib, pkgs, ... }:

  {
    imports = [
      ./hardware-configuration.nix

      ....
      # virtualisation
      ./docker.nix

    ];

....
