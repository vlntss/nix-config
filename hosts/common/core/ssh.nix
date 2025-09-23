{
  outputs,
  lib,
  config,
  ...
}: let
  hosts = lib.attrNames outputs.nixosConfigurations;
  hostname = config.networking.hostName;
  domain = config.networking.domain;
  # Sops needs acess to the keys before the persist dirs are even mounted; so
  # just persisting the keys won't work, we must point at /persist.
  hasOptinPersistence = config.environment.persistence ? "/persist";
in {
  services.openssh = {
    enable = true;
    settings = {
      # Harden.
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      # Automatically remove stale sockets.
      StreamLocalBindUnlink = "yes";
      # Allow forwarding ports to everywhere.
      GatewayPorts = "clientspecified";
      # Let WAYLAND_DISPLAY be forwarded.
      AcceptEnv = "WAYLAND_DISPLAY";
      X11Forwarding = true;
    };

    hostKeys = [
      {
        path = "${lib.optionalString hasOptinPersistence "/persist"}/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
        comment = hostname;
      }
    ];
  };

  programs.ssh = {
    # Each hosts public key.
    knownHosts = lib.genAttrs hosts (hostname: {
      publicKeyFile = ../../nixos/${hostname}/keys/id_ed25519_${hostname}.pub;
      extraHostNames =
        [
          "${hostname}.${domain}"
        ]
        ++
        # Alias for localhost if it's the same host.
        (lib.optional (hostname == config.networking.hostName) "localhost");
    });
  };

  # Passwordless sudo when SSH'ing with keys.
  security.pam.sshAgentAuth = {
    enable = true;
    authorizedKeysFiles = ["/etc/ssh/authorized_keys.d/%u"];
  };
}
