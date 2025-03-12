{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    .
    .
    # nvidia gpu
    ./nvidia_gpu.nix

    # virtualisation
    ./docker.nix

    .
    .

  ];

.
.
.
