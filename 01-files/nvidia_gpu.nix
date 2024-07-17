{ config, lib, pkgs, ... }:


{
  services.xserver.videoDrivers = [ "nvidia" ];

  # If you have GPUs from multiple providers (such as Intel)
  # services.xserver.videoDrivers = [ "intel" "nvidia" ];

  # Also enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

}
