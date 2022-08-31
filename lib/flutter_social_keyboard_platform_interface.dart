import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_social_keyboard_method_channel.dart';

abstract class FlutterSocialKeyboardPlatform extends PlatformInterface {
  /// Constructs a FlutterSocialKeyboardPlatform.
  FlutterSocialKeyboardPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterSocialKeyboardPlatform _instance = MethodChannelFlutterSocialKeyboard();

  /// The default instance of [FlutterSocialKeyboardPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterSocialKeyboard].
  static FlutterSocialKeyboardPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterSocialKeyboardPlatform] when
  /// they register themselves.
  static set instance(FlutterSocialKeyboardPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
