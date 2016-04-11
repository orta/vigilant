#import <Foundation/Foundation.h>

/// By default, vigilant will log out errors, if you want to really be vigilant
/// then you should call `startExpecting` which will assert instead.

@interface Vigilant : NSObject

/// Don't log, assert. Hard mode.

+ (void)startExpecting;

@end
