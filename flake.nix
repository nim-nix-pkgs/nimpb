{
  description = ''A Protocol Buffers library for Nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."nimpb-master".dir   = "master";
  inputs."nimpb-master".owner = "nim-nix-pkgs";
  inputs."nimpb-master".ref   = "master";
  inputs."nimpb-master".repo  = "nimpb";
  inputs."nimpb-master".type  = "github";
  inputs."nimpb-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nimpb-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}