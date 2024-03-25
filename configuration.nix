# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }: {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = false; 
    displayManager.startx.enable = true;
    windowManager.dwm.enable = true;
    windowManager.dwm.package = pkgs.dwm.overrideAttrs {
      src = fetchGit {
        url = "https://github.com/ozpv/dwm.git";
        rev = "179c9d06abc44fae3ce35e47e9865ba243b75298";
      };
    };
    xkb.layout = "us";
    xkb.variant = "";
  };

  # compostior
  services.picom.enable = true; 

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ozpv = {
    isNormalUser = true;
    description = "ozpv";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  # lock screen
  programs.slock.enable = true;

  home-manager = {
    users.ozpv = {
      imports = [ ./home.nix ];
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    neovim
    (st.overrideAttrs {
      src = fetchGit {
        url = "https://github.com/ozpv/st.git";
        rev = "a74788fe9617d8b995b61ba9d194a7c12cdd119b";
      };
    })
    (dmenu.overrideAttrs {
      src = fetchGit {
        url = "https://github.com/ozpv/dmenu.git";
        rev = "29255fd85845d66ce625b050ae9ab2751e382b73";
      };
    })
    (slstatus.overrideAttrs {
      src = fetchGit {
        url = "https://github.com/ozpv/slstatus.git";
        rev = "9e533dcb56f3d34a85b5ba7f279c2870ebcc4034";
      };
    })
    (callPackage ./apps/powermenu.nix {})
    networkmanager_dmenu
    maim
    sxiv
    xwallpaper
    lf
    wget
    git
    home-manager
  ];

  # gtk
  programs.dconf.enable = true;

  # browser
  programs.firefox.enable = true;

  # tmux
  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g prefix C-a
      bind-key l select-pane -L
      bind-key h select-pane -R
      bind-key k select-pane -U
      bind-key j select-pane -D
    ''; 
  };

  # fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [ "JetBrainsMono" ];
    })
  ];

  # bluetooth
  hardware.bluetooth.enable = false;

  # audio
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # shell
  programs.zsh.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
