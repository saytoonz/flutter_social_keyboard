#import "FlutterSocialKeyboardPlugin.h"
#if __has_include(<flutter_social_keyboard/flutter_social_keyboard-Swift.h>)
#import <flutter_social_keyboard/flutter_social_keyboard-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_social_keyboard-Swift.h"
#endif

@implementation FlutterSocialKeyboardPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterSocialKeyboardPlugin registerWithRegistrar:registrar];
}
@end
