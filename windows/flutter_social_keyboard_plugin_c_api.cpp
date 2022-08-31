#include "include/flutter_social_keyboard/flutter_social_keyboard_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_social_keyboard_plugin.h"

void FlutterSocialKeyboardPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_social_keyboard::FlutterSocialKeyboardPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
