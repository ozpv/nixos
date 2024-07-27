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
  networking.firewall.enable = true;

  # touchpad
  services.libinput.enable = true;
  services.libinput.touchpad.naturalScrolling = false; 
  services.libinput.touchpad.middleEmulation = true; 
  services.libinput.touchpad.tapping = true;

  # graphics
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      # Make sure to use the correct Bus ID values for your system!
      amdgpuBusId = "PCI:115:0:0"; 
      nvidiaBusId = "PCI:1:0:0";
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  # boot.kernelParams = [ "module_blacklist=amdgpu" "module_blacklist=i915" ];

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
        rev = "5d98b0dc24040979851c8e70bec5605bbc54a3e1";
      };
    };
    xkb.layout = "us";
    xkb.variant = "";
  };

  # compostior
  services.picom.enable = true; 

  # login
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
  '';

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
    libinput-gestures
    brightnessctl
    vim
    (st.overrideAttrs {
      src = fetchGit {
        url = "https://github.com/ozpv/st.git";
        rev = "3a3cb60a329fc9dd139cd7a38e73307be791b480";
      };
    })
    (dmenu.overrideAttrs {
      src = fetchGit {
        url = "https://github.com/ozpv/dmenu.git";
        rev = "d22280f3dc99dd71b5c86c1a6ce584bdee7cd8eb";
      };
    })
    (slstatus.overrideAttrs {
      src = fetchGit {
        url = "https://github.com/ozpv/slstatus.git";
        rev = "d8a6d891cba4217d52e325b4107072473c174e45";
      };
    })
    (callPackage ./apps/powermenu.nix {})
    networkmanager_dmenu
    maim
    sxiv
    xwallpaper
    wget
    git
    home-manager
  ];

  # neovim
  programs.neovim.enable = true;
  environment.variables.EDITOR = "nvim";

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
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

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
