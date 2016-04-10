#import <Foundation/Foundation.h>

/// By default, vigilent will log out errors, if you want to really be vigilent
/// then you should call `startExpecting` which will assertions instead.

@interface Vigilent : NSObject

/// Don't log, assert. Hard mode.

+ (void)startExpecting;

@end
