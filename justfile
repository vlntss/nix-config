moonraker-deploy:
    nix --extra-experimental-features 'nix-command flakes' run github:nix-community/nixos-anywhere -- --disko-mode disko --flake .#moonraker --target-host nixos@moonraker

moonraker-rebuild:
    nixos-rebuild switch --flake .#moonraker --target-host vlntss@moonraker --sudo

spectre-deploy:
    nix --extra-experimental-features 'nix-command flakes' run github:nix-community/nixos-anywhere -- --disko-mode disko --flake .#spectre --target-host nixos@spectre

spectre-rebuild:
    nixos-rebuild switch --flake .#spectre --target-host vlntss@spectre --sudo