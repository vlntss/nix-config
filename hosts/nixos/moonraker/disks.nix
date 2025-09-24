# Disk configuration file for disko for the host 'moonraker'.
# There are some specific configurations in this disko
# file that are needed for my impermanence setup to work.
# The primary btrfs volume needs to be labelled 'nixos'
# using the extraArgs = ["-L" "nixos" "-f"]; setting,
# and I also use a postCreateHook to generate a blank
# root snapshot when the host is first created.
{
  config,
  inputs,
  outputs,
  ...
}: let
  diskId = "/dev/disk/by-id/nvme-Sabrent_SB-RKT5-2TB_48836385600606";
  hostname = config.networking.hostName;
in {
  imports = [
    inputs.disko.nixosModules.disko
  ];
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "${diskId}";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1024M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                # These options can improve performance on NVMe drives by adjusting
                # how LUKS handles I/O operations. They are not essential but can
                # provide a noticeable boost in disk speed.
                extraOpenArgs = [
                  "--allow-discards"
                  "--perf-no_read_workqueue"
                  "--perf-no_write_workqueue"
                ];
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "btrfs";
                  extraArgs = ["-L" "${hostname}" "-f"];
                  postCreateHook = ''
                    mount -t btrfs /dev/disk/by-label/${hostname} /mnt
                    btrfs subvolume snapshot -r /mnt /mnt/root-blank
                    umount /mnt
                  '';
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = [
                        "subvol=root"
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "subvol=nix"
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/persist" = {
                      mountpoint = "/persist";
                      mountOptions = [
                        "subvol=persist"
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/swap" = {
                      mountpoint = "/.swapvol";
                      swap.swapfile.size = "48G";
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
  fileSystems."/persist".neededForBoot = true;
}
