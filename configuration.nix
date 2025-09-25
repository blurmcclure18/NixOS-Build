# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

    boot = {

	plymouth = {
		enable = true;
	};

	# Enable Systemd initrd
	initrd.systemd.enable = true;

	# Enable Silent Boot
	consoleLogLevel = 3;
	initrd.verbose = false;
	kernelParams = [
		"quiet"
		"splash"
		"boot.shell_on_fail"
		"udev.log_priority=3"
		"rd.systemd.show_status=auto"
	];

	# Hide the OS choice for bootloaders
	# It's still possible to open the bootloader list by pressing any key
	# It will just not appear on screen unless a key is pressed
	loader.timeout = 0;
    };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

   networking.hostName = "ILCP-(location)-CHK(number)"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
   networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
   time.timeZone = "America/Chicago";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
   services.xserver.enable = true;

  # Configure keymap in X11
   services.xserver.xkb.layout = "us";
   services.xserver.xkb.options = "caps:escape";

  # Enable Plasma6 desktop environment
   services.desktopManager.plasma6.enable = true;

  # Enable the SDDM display manager
   services.displayManager.sddm.enable = true;
   #services.displayManager.sddm.wayland.enable = true;
   #services.xserver.displayManger.sddm.enable = true;
   services.displayManager.defaultSession = "plasmax11";
   services.displayManager.autoLogin.enable = true;
   services.displayManager.autoLogin.user = "ilcp_user";



  # Enable CUPS to print documents.
   services.printing.enable = true;

  # Set the default shell for all users
   programs.zsh.enable = true;
   programs.zsh.autosuggestions.enable = true;
   programs.zsh.syntaxHighlighting.enable = true;
   programs.starship.enable = true;
   users.defaultUserShell = pkgs.zsh;


  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
   services.pipewire = {
     enable = true;
     pulse.enable = true;
   };

  # Enable touchpad support (enabled default in most desktopManager).
   services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.ilcp_user = {
     isNormalUser = true;
     description = "Guest User";
     hashedPassword = null;
     extraGroups = [ "networkmanager" ];
     #packages = with pkgs; [
     #  tree
     #];
   };

   users.users.ilcp_admin = {
   	isNormalUser = true;
	extraGroups = [ "wheel" ];
	};

  # programs.firefox.enable = true;

   nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
   environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     git
     curl
     neovim
     firefox
     alacritty
     vmware-horizon-client
     openconnect
   ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}

