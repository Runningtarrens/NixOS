# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "de";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tarrens = {
    isNormalUser = true;
    description = "tarrens";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget

     # Util
     neofetch

     #Browsing
     firefox-wayland
     brave
     
     #Desktop
     hyprland
     xwayland
     xdg-desktop-portal-hyprland
     xdg-desktop-portal-gtk
     xdg-utils
     dconf
     sddm
     

     #Programs
     kitty
     waybar
     gnome.nautilus
     gnome.gvfs
     polkit_gnome
     wlogout
     swww
     rofi
     steam
     steam-run
     mesa
     discord
     xfce.thunar
     gnome-text-editor
     cliphist
    # nwg-look     added an error while building the flake, but worked before using flakes
     swaylock
     networkmanager
     networkmanagerapplet
     pipewire
     wireplumber
     swappy
     imagemagick
     
     pavucontrol
     grim
     slurp
     
     gparted
  ];



 #hardware.opengl.enable = true;
 #hardware.opengl.driSupport32bit = true;
   hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    };
    
boot.supportedFilesystems = [ "ntfs" ];

 services.xserver.videoDrivers = ["amdgpu"];
 programs.hyprland.enable = true; 
 programs.hyprland.xwayland.enable = true;
 xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
 
 #Trash and Harddrive mounting for Nautilus/thunar
 services.gvfs.enable = true;
 
  #User rights, needed for access, writing and saving via file explorer(nautilus/thunar)
 security.polkit.enable = true;
 
 
 
 systemd = {
  user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
  };
};
 
 # Sound
 # services.pipewire.enable = true;
 # services.pipewire.audio.enable = true;
  sound.enable = true;
  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.enable = true;


 # Login service + start display 
 services.xserver.enable = true;
 services.xserver.displayManager.sddm.enable = true;
 services.xserver.displayManager.sddm.wayland.enable = true;
# services.xserver.displayManager.sddm.theme = "where_is_my_sddm_theme";
 

 

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
  
  
  nix.settings.experimental-features = [ "nix-command" "flakes"];

}
