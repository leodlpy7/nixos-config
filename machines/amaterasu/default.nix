{ config, lib, pkgs, ... }:

{
  imports = [
    # public configs, not related to home manager
    ../share/programs.nix
    ../share/security.nix
    ../share/services.nix
    ../share/vars.nix
    ../share/wifi.nix

    # never forget to load the hardware config
    ./hardware-configuration.nix
  ];

  # experimental features
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    useOSProber = true;
    efiSupport = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["ntfs"];

  networking.hostName = "amaterasu";
  
  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  console.keyMap = "de";

  # user config
  users.users.lucysue = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
    ];
    shell = pkgs.fish;
  };

  # bluetooth
  hardware.bluetooth.enable = true;

  # do not change
  system.stateVersion = "23.11";
}
