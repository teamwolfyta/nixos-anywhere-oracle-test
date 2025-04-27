{
  config,
  lib,
  ...
}: let
  inherit (lib) mkForce mkIf;
  ldr = config.boot.loader;
in {
  systemd.services."serial-getty@ttyS0".enable = true;

  boot = {
    # First build/import needs to be forced to ensure the meta data is correct
    # Remove after successfully launching
    zfs.forceImportAll = mkForce true;
    zfs.forceImportRoot = mkForce true;

    initrd = {
      availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "xhci_pci" "ahci"];
      kernelModules = [];
    };
    kernelModules = ["kvm-amd" "zfs"];
    extraModulePackages = [];
    kernelParams = [
      "console=tty0"
      "console=ttyS0,115200n8"
      "boot.trace=1"
      "loglevel=7"
      "break=initrd" # Optional: stop early for manual inspection
    ];

    loader = {
      grub = mkIf (ldr.grub.enable) {
        efiSupport = true;
        efiInstallAsRemovable = true;
        device = "nodev";
        extraConfig = ''
          serial --unit=0 --speed=115200 --word=8 --parity=no --stop=1
          terminal_output serial console
        '';
      };
      efi = mkIf (ldr.systemd-boot.enable) {
        canTouchEfiVariables = true;
      };
    };
  };
}
