{
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
