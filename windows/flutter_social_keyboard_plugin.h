#ifndef FLUTTER_PLUGIN_FLUTTER_SOCIAL_KEYBOARD_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_SOCIAL_KEYBOARD_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flutter_social_keyboard {

class FlutterSocialKeyboardPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlutterSocialKeyboardPlugin();

  virtual ~FlutterSocialKeyboardPlugin();

  // Disallow copy and assign.
  FlutterSocialKeyboardPlugin(const FlutterSocialKeyboardPlugin&) = delete;
  FlutterSocialKeyboardPlugin& operator=(const FlutterSocialKeyboardPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flutter_social_keyboard

#endif  // FLUTTER_PLUGIN_FLUTTER_SOCIAL_KEYBOARD_PLUGIN_H_
