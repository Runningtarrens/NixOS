{ config, pkgs, ... }:

{
programs.waybar = {
    # Whether to enable waybar
    enable = true;
    # The hyprland package to use
    package = pkgs.waybar;
    
     style = ''
               * {
                 font-family: "ShureTechMono Nerd Font";
                 font-size: 12pt;
                 border-radius: 10px;
                 transition-property: background-color;
                 transition-duration: 0.5s;
               }
               window#waybar {
                 background-color: transparent;
               }
               window > box {
                 margin-left: 13px;
                 margin-right: 13px;
                 margin-top: 5px;
                 background-color:#365570;
                 padding: 3px;
                 padding-left:3px;
                 border: 1px solid #7484A4;
               }
               tooltip {
                 background: #365570;
                 border: 1px solid #7484A4;
               }
               tooltip label {
                 color: #F8708C;
               }
         #custom-powerlogo {
                 font-size: 20px;
                 padding-left: 5px;
                 padding-right: 5px;
                 color:#F8708C;
               }
         #mode, #clock, #memory, #temperature,#cpu,#mpd, #custom-wall, #temperature, #backlight, #pulseaudio, #network, #battery, #custom-powermenu, #custom-cava-internal {
                 padding-left: 10px;
                 padding-right: 10px;
               }
               /* #mode { */
               /* 	margin-left: 10px; */
               /* 	background-color: rgb(248, 189, 150); */
               /*     color: rgb(26, 24, 38); */
               /* } */
         #cpu {
                 background: #365570;
                 border-radius: 4px 4px 4px 4px;
                 padding: 0px;
                 padding-left: 2px;
                 padding-right: 6px;
                 color:#F8708C;
                 border: 1px solid #F8708C;
                 margin-right: 4px;
               }
         #clock {
                 background: #365570;
                 border-radius: 20px 20px 20px 20px;
                 padding: 0px;
                 padding-left: 8px;
                 padding-right: 8px;
                 color:#F8708C;
                 border: 1px solid #F8708C;
                 
                 
                 
               }
         #temperature {
                 background: #365570;
                 border-radius: 20px 4px 4px 20px;
                 padding: 0px;
                 padding-left: 9px;
                 padding-right: 2px;
                 color:#F8708C;
                 border: 1px solid #F8708C;
                 margin-right: 4px;
               }
         #pulseaudio {
                 background: #365570;
                 border-radius: 4px 4px 4px 4px;
                 padding: 0px;
                 padding-left: 2px;
                 padding-right: 2px;
                 color:#F8708C;
                 border: 1px solid #F8708C;
                 margin-right: 4px;
               }
         #network {
                 color: #ABE9B3;
                 background: #365570;
                 border-radius: 4px 20px 20px 4px;
                 padding: 0px;
                 padding-left: 7px;
                 padding-right: 9px;
                 border: 1px solid #F8708C;
                 margin-right: 2px;
               }
         #network.disconnected {
                 color: rgb(255, 255, 255);
               }
         #custom-powermenu {
                 color: rgb(242, 143, 173);
                 padding-right: 8px;
               }

      '';

 settings = {

  mainBar = {
    layer = "top";
    position = "top";
    height = 36;
    output = [
      
      "HDMI-A-2"
    ];
    modules-left = ["custom/powerlogo"   ];
    modules-center = [ "clock"  ];
    modules-right = [ "temperature" "pulseaudio" "cpu" "network"  ];

    
 
    "custom/powerlogo" = {
          "format" = "  ///";
          "on-click" = "wlogout";
          "tooltip" = false;
          
    };
    
    
     "temperature" = {
           "tooltip" = false;
    };
    
    "clock"= {
        "format"= "{:%H:%M}  ";
        "format-alt"= "{:%A, %B %d, %Y (%R)} 󰃰 ";
        "tooltip-format"= "<tt><small>{calendar}</small></tt>";
        "calendar"= {
                    "mode"                = "year";
                    "mode-mon-col"  = 3;
                    "weeks-pos"        = "right";
                    "on-scroll"           = 1;
                    "format" = {
                              "months" =     "<span color='#ffead3'><b>{}</b></span>";
                              "days" =       "<span color='#ecc6d9'><b>{}</b></span>";
                              "weeks" =      "<span color='#99ffdd'><b>W{}</b></span>";
                              "weekdays" =   "<span color='#ffcc66'><b>{}</b></span>";
                              "today" =      "<span color='#ff6699'><b><u>{}</u></b></span>";
                              };
                    };
        "actions" =  {
                    "on-click-right" = "mode";
                    "on-click-forward" = "tz_up";
                    "on-click-backward" = "tz_down";
                    "on-scroll-up" = "shift_up";
                    "on-scroll-down" = "shift_down";
                    };
    };
    
    "pulseaudio" = {
        "format" = "{icon} {volume}%";
        "format-muted" = " off";
        "format-icons" ="";
       "on-click" = "pavucontrol";
       "on-click-right" = "pkill pavucontrol";
       "on-click-middle" = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
     #  "on-scroll-down" = "pactl set-source-volume @DEFAULT_SOURCE@ -1%";
     #  "on-scroll-up" = "pactl set-source-volume @DEFAULT_SOURCE@ +1%";
        "scroll-step"= 2;
       
       
       

   };
    
        "network"= {
        "tooltip"= true;
        "format-wifi"= " ";
        "rotate"= 0;
        "format-ethernet" = "󰈀 ";
        "tooltip-format" = "Network: <big><b>{essid}</b></big>\nSignal strength: <b>{signaldBm}dBm ({signalStrength}%)</b>\nFrequency: <b>{frequency}MHz</b>\nInterface:     <b>{ifname}</b>\nIP: <b>{ipaddr}/{cidr}</b>\nGateway: <b>{gwaddr}</b>\nNetmask: <b>{netmask}</b>";
        "format-linked"= "󰈀 {ifname} (No IP)";
        "format-disconnected"= "󰖪 ";
        "tooltip-format-disconnected"= "Disconnected";
        "format-alt"= "<span foreground='#99ffdd'> {bandwidthDownBytes}</span> <span foreground='#ffcc66'> {bandwidthUpBytes}</span>";
        "interval"= 2;
        "on-click-right" = "nm-applet";
    };
    
    "cpu" = {
        format =" {usage}%";
        tooltip = true;
    };
    
  };
 };
};
 
}
