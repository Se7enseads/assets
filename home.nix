{ config, lib, ... }:

with lib;

let cfg = config.programs.wallpapers;
in {

  config = mkIf cfg.enable {
    home.file."${cfg.wallpaperTargetDir}".source = ./wallpapers;
  };

  options.programs.wallpapers = {
    enable = mkEnableOption "Enable wallpaper setup";

    # Dynamic target directory where the wallpapers will go
    wallpaperTargetDir = mkOption {
      type = types.path;
      default = "~/.wallpapers"; # Default target directory for wallpapers
      description = "Directory where wallpapers will be placed.";
    };
  };
}
