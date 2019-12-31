#import "NemoPlugin.h"
#if __has_include(<nemo/nemo-Swift.h>)
#import <nemo/nemo-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "nemo-Swift.h"
#endif

@implementation NemoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNemoPlugin registerWithRegistrar:registrar];
}
@end
