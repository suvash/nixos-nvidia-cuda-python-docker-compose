{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    .
    .

    # gpu
    ./nvidia_gpu.nix

    .
    .

  ];

.
.
.
