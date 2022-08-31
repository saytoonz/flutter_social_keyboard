import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_social_keyboard_platform_interface.dart';

/// An implementation of [FlutterSocialKeyboardPlatform] that uses method channels.
class MethodChannelFlutterSocialKeyboard extends FlutterSocialKeyboardPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_social_keyboard');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
