{
  config,
  lib,
  pkgs,
  inputs,
  cosmicLib,
  ...
}: {
  wayland.desktopManager.cosmic.applets = {
    audio.settings.show_media_controls_in_top_panel = true;
    time.settings = {
      first_day_of_week = 0; # Monday
      military_time = true;
      show_date_in_top_panel = true;
      show_seconds = false;
      show_weekday = true;
    };
    app-list.settings.favorites = [
      "com.system76.cosmicTerm"
      "com.system76.cosmicFiles"
      "com.system76.cosmicStore"
    ];
  };
}
