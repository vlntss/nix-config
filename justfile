spectre-deploy:
    nix --extra-experimental-features 'nix-command flakes' run github:nix-community/nixos-anywhere -- --disko-mode disko --flake .#spectre --target-host nixos@spectre

spectre-rebuild:
    nixos-rebuild switch --flake .#spectre --target-host vlntss@spectre --sudo