with (import <nixpkgs> {});
let
    basePackages = [
        darwin.apple_sdk.frameworks.Security
        pkgs.cargo
        pkgs.cmake
        pkgs.libiconv
        pkgs.protobuf
        pkgs.python310
        pkgs.rustc
    ];
    extensionPath = ./local.nix;
    inputs = basePackages
             ++ lib.optional (builtins.pathExists extensionPath) (import extensionPath {}).inputs;

    baseHooks = ''
        unset SOURCE_DATE_EPOCH
    '';

    shellHooks = baseHooks
                 + lib.optionalString (builtins.pathExists extensionPath) (import extensionPath {}).hooks;
in mkShell {
    buildInputs = inputs;
    shellHooks = shellHooks;
}
