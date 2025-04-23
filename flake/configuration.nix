{
  modulesPath,
  lib,
  pkgs,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
  ];

  boot.loader = {
    grub.enable = lib.mkForce false;
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  networking.hostId = "8425e349";

  services.openssh.enable = true;

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
  ];

  users.users."root" = {
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO/pisGSPtuU1/zUPCn88LU7zzbbG00xc+4M1C5lXFvB"];
    password = "password";
  };

  fileSystems."/".neededForBoot = true;

  system.stateVersion = "24.11";
}
