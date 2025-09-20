{ pkgs, config, ... }:

{
  nixpkgs.config = { allowUnfree = true; };

  imports = [
    # CLI
    ../modules/ghostty
    ../modules/starship
    ../modules/git

    # Dev
    ../modules/vscode
  ];

  home.username = "juan";
  home.homeDirectory = "/home/juan";

  home.packages = with pkgs; [
    # Entertainment
    # hmcl

    # ---- Coding ----
    python310
    gemini-cli
    nodejs
    pnpm
    vlc

    # Misc
    nixfmt-classic
    nixd
    yt-dlp
    ffmpeg
    # Custom bin
    (pkgs.writeShellScriptBin "rebuild" ''
      sudo nixos-rebuild switch --flake ~/turret#default
    '')
  ];

  # CLI
  programs.btop.enable = true;
  programs.bash.enable = true;
  programs.lsd.enable = true;

  # Desktop Apps
  programs.vesktop.enable = true;
  programs.thunderbird.enable = true;
  programs.thunderbird.profiles.juan.isDefault = true;
  programs.brave.enable = true;
  programs.firefox.enable = true;

  # Code
  programs.go.enable = true;
  programs.bun.enable = true;

  # Background
  home.file.".config/backgrounds/sekiro.jpg".source =
    config.lib.file.mkOutOfStoreSymlink ../backgrounds/sekiro.jpg;

  # DConf
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/background" = {
        picture-uri =
          "file://${config.home.homeDirectory}/.config/backgrounds/sekiro.jpg";
        picture-uri-dark =
          "file://${config.home.homeDirectory}/.config/backgrounds/sekiro.jpg";
      };

      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions;
          [ blur-my-shell.extensionUuid ];
      };

      "org/gnome/desktop/default-applications/terminal" = {
        exec = "'${pkgs.ghostty}/bin/ghostty'";
        exec-arg = "'-e'";
      };

      "org/gnome/shell/extensions/blur-my-shell" = {
        brightness = 0.75;
        noise-amount = 0;
      };
    };
  };

  # GTK
  gtk = {
    enable = true;
    theme = {
      name = "whitesur-gtk-theme";
      package = pkgs.whitesur-gtk-theme;
    };
  };

  # Custom services
  systemd.user.services.pahome-lxd-tunnel = {
    Unit = {
      Description = "SSH Tunnel for LXD";
      After = "network.target";
    };

    Service = {
      ExecStart = "${pkgs.openssh}/bin/ssh -q -N -L 8443:localhost:8443 pahome";
      StandardOutput = "journal";
      StandardError = "journal";
      WorkingDirectory = "/home/juan";
    };

    Install = { WantedBy = [ "default.target" ]; };
  };

  # Alias
  home.shellAliases = { tree = "ls --tree"; };

  home.sessionVariables = {
    EDITOR = "code";
    #ANDROID_SDK_ROOT =
    #  "${pkgs.androidenv.androidPkgs.androidsdk}/libexec/android-sdk";
    LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:${
        pkgs.lib.makeLibraryPath [
          pkgs.stdenv.cc.cc
          pkgs.linuxPackages.nvidiaPackages.stable
        ]
      }";
  };

  home.sessionPath = [ "$HOME/.local/bin" ];

  home.stateVersion = "25.05";
}
