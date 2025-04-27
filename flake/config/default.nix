{pkgs, ...}: {
  imports = [
    ./boot.nix
    ./disko.nix
    ./hardware.nix
  ];

  # Choose your bootloader
  boot.loader.systemd-boot.enable = true;

  networking = {
    hostId = "11111111";
    hostName = "TestVM";
    firewall.allowPing = true;
  };

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    curl
    gitMinimal
    microfetch
    zfs
  ];

  users.users = {
    michael = {
      password = "apassword";
      isNormalUser = true;
    };
    "root" = {
      openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO/pisGSPtuU1/zUPCn88LU7zzbbG00xc+4M1C5lXFvB"];
      password = "apassword";
    };
  };
}
