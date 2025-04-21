{
  inputs',
  pkgs,
  ...
}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    # Misc
    jsonfmt
    lefthook
    mdformat
    treefmt
    taplo

    # Nix
    alejandra
    nil

    # Yaml
    yamlfmt

    inputs'.nixos-anywhere.packages.nixos-anywhere
  ];

  shellHook = ''
    lefthook install
  '';
}
