import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_social_keyboard/flutter_social_keyboard.dart';
import 'package:flutter_social_keyboard/flutter_social_keyboard_platform_interface.dart';
import 'package:flutter_social_keyboard/flutter_social_keyboard_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterSocialKeyboardPlatform
    with MockPlatformInterfaceMixin
    implements FlutterSocialKeyboardPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterSocialKeyboardPlatform initialPlatform = FlutterSocialKeyboardPlatform.instance;

  test('$MethodChannelFlutterSocialKeyboard is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterSocialKeyboard>());
  });

  test('getPlatformVersion', () async {
    FlutterSocialKeyboard flutterSocialKeyboardPlugin = FlutterSocialKeyboard();
    MockFlutterSocialKeyboardPlatform fakePlatform = MockFlutterSocialKeyboardPlatform();
    FlutterSocialKeyboardPlatform.instance = fakePlatform;

    expect(await flutterSocialKeyboardPlugin.getPlatformVersion(), '42');
  });
}
