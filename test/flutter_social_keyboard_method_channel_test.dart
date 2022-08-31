import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_social_keyboard/flutter_social_keyboard_method_channel.dart';

void main() {
  MethodChannelFlutterSocialKeyboard platform = MethodChannelFlutterSocialKeyboard();
  const MethodChannel channel = MethodChannel('flutter_social_keyboard');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
