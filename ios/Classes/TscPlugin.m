#import "TscPlugin.h"
#if __has_include(<tsc/tsc-Swift.h>)
#import <tsc/tsc-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "tsc-Swift.h"
#endif

@implementation TscPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTscPlugin registerWithRegistrar:registrar];
}
@end
