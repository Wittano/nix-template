{
  inputs = { nixpkgs.url = "nixpkgs/nixos-23.05"; };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      lib = nixpkgs.lib;

      templatesDirs = builtins.attrNames
        (lib.filterAttrs (n: v: v == "directory")
          (builtins.readDir ./.));

      templates = lib.lists.forEach templatesDirs (name: {
        inherit name;

        value = { path = ./${name}; };
      });
    in {
      templates = builtins.listToAttrs templates; 
    };
}
