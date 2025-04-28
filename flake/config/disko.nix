{config, ...}: {
  disko.devices = {
    disk."main" = {
      content = {
        partitions = {
          boot = {
            alignment = 3;
            content = {
              format = "vfat";
              mountpoint = "/boot";
              type = "filesystem";
            };
            name = "boot";
            size = "200M";
            start = "1M";
            type = "EF00";
          };
          swap = {
            alignment = 2;
            content = {
              type = "swap";
            };
            name = "swap";
            size = "500M";
          };
          zfs = {
            alignment = 1;
            content = {
              pool = "zroot";
              type = "zfs";
            };
            name = "zfs";
            size = "100%";
          };
        };
        type = "gpt";
      };
      device = "/dev/sda";
      imageSize = "3G";
      type = "disk";
    };
    zpool."zroot" = {
      datasets = {
        "nix" = {
          mountpoint = "/nix";
          options.mountpoint = "legacy";
          type = "zfs_fs";
        };
        "root" = {
          mountpoint = "/";
          options.mountpoint = "legacy";
          type = "zfs_fs";
        };
        "tmp" = {
          mountpoint = "/tmp";
          options.mountpoint = "legacy";
          type = "zfs_fs";
        };
      };
      preCreateHook = ''
        mkdir -p /etc
        hostid=${config.networking.hostId}
        printf "\\x${hostid:0:2}\\x${hostid:2:2}\\x${hostid:4:2}\\x${hostid:6:2}" > /etc/hostid
      '';
      postCreateHook = ''
        zpool set multihost=on zroot
      '';
      options = {
        ashift = "12";
        autotrim = "on";
      };
      rootFsOptions = {
        acltype = "posixacl";
        atime = "off";
        compression = "zstd";
        normalization = "none";
        xattr = "sa";
      };
      type = "zpool";
    };
  };
}
