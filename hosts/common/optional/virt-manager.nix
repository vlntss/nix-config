{pkgs, ...}: {
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        # Enable software TPM for QEMU
        swtpm.enable = true;
        # Enable OVMF with Secure Boot and TPM support
        ovmf = {
          enable = true;
          packages = [
            (pkgs.OVMF.override {
              secureBoot = true;
              tpmSupport = true;
            }).fd
          ];
        };
      };
    };
  };

  services = {
    spice-autorandr.enable = true;
    spice-vdagentd.enable = true;
  };

  networking.firewall.trustedInterfaces = ["br0"];

  programs.virt-manager = {
    enable = true;
    package = pkgs.virt-manager;
  };

  environment.persistence."/persist" = {
    directories = [
      "/var/cache/libvirt"
      "/var/lib/libvirt"
      "/var/lib/qemu"
    ];
  };
}
