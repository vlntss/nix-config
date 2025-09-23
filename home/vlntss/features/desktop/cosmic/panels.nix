{
  config,
  lib,
  pkgs,
  inputs,
  cosmicLib,
  ...
}: {
  wayland.desktopManager.cosmic.panels = [
    {
      anchor = cosmicLib.cosmic.mkRON "enum" "Top";
      anchor_gap = false;
      autohide = cosmicLib.cosmic.mkRON "optional" null;
      background = cosmicLib.cosmic.mkRON "enum" "ThemeDefault";
      expand_to_edges = true;
      name = "Panel";
      opacity = 0.8;
      output = cosmicLib.cosmic.mkRON "enum" "All";
      plugins_center = cosmicLib.cosmic.mkRON "optional" [
        #"com.system76.CosmicPanelWorkspacesButton"
        "com.system76.CosmicAppletTime"
        #"com.system76.CosmicPanelAppButton"
      ];
      plugins_wings = cosmicLib.cosmic.mkRON "optional" (
        cosmicLib.cosmic.mkRON "tuple" [
          [
            "com.system76.CosmicAppletWorkspaces"
            #"com.system76.CosmicAppList"
          ]
          [
            "com.system76.CosmicAppletTiling"
            "com.system76.CosmicAppletNotifications"
            "com.system76.CosmicAppletAudio"
            "com.system76.CosmicAppletBluetooth"
            "com.system76.CosmicAppletNetwork"
            "com.system76.CosmicAppletBattery"
            "com.system76.CosmicAppletPower"
          ]
        ]
      );
      size = cosmicLib.cosmic.mkRON "enum" "XS";
    }
  ];
}
