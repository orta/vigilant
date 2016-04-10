@import Foundation;
@import Quick;
@import Nimble;
@import ObjectiveC;

#import "Vigilent.h"

static BOOL ORVigilentShouldAssert = false;
static BOOL ORVigilentConfigurationHasRunExpectations;

@implementation Vigilent

+ (void)startExpecting
{
    ORVigilentShouldAssert = true;
}

@end

/// Creates an class which Quick will pick up to support
/// adding beforeEach / afterEach blocks.

@interface ORVigilentConfiguration: QuickConfiguration
@end

@implementation ORVigilentConfiguration

+ (void)configure:(Configuration *)configuration
{
    /// For info on what's going on: see
    /// https://www.mikeash.com/pyblog/friday-qa-2010-11-6-creating-classes-at-runtime-in-objective-c.html
    NSMutableDictionary *threadDict = [NSThread currentThread].threadDictionary;

    /// We want to dynamically create a subclass of the dictionary for the current thread
    Class orMutableDict = objc_allocateClassPair([threadDict class], "ORVigilentMutableDictionary", 0);

    /// We do this, because every time a nimble matcher is ran
    /// it makes changes to the "NimbleEnvironment" key
    Method indexOfObject = class_getInstanceMethod(NSMutableDictionary.class, @selector(setObject:forKeyedSubscript:));

    /// By doing this we can hook in to find out if any `expect`s have been ran.
    const char *types = method_getTypeEncoding(indexOfObject);
    class_addMethod(orMutableDict, @selector(setObject:forKeyedSubscript:), (IMP)ORVigilentCustomSetObject, types);

    /// So we register our new subclass in the objc runtime
    objc_registerClassPair(orMutableDict);

    /// And dynamically set the thread dict's class to the new one
    object_setClass(threadDict, orMutableDict);

    // Before any tests are ran, make sure that we've set the check to false,
    //
    [configuration beforeEach:^{
        ORVigilentConfigurationHasRunExpectations = NO;
    }];

    // We now look after a test to see if there were any changes to the
    // Nimble Environment during the test run.
    [configuration afterEachWithMetadata:^(ExampleMetadata * _Nonnull metadata) {
        if (ORVigilentConfigurationHasRunExpectations == false) {
            NSString *expectationName = [metadata.example name];
            NSString *errorString = [NSString stringWithFormat:@"Vigilent: Did not see any `expect`s in the test: '%@'", expectationName];
            if (ORVigilentShouldAssert) {
                @throw errorString;
            } else {
                NSLog(@"\n\n%@\n\n", errorString);
            }
        }
    }];
}

static void ORVigilentCustomSetObject(NSMutableDictionary *self, SEL _cmd, id anObject, id<NSCopying>key)
{
    // We're overwriting setObject:forKeyedSubscript:
    // Which, hopefully, just calls setObject:forKey under the hood :)
    [self setObject:anObject forKey:key];

    // Check for whether the key was a change to the Nimble Environment
    if ([@"NimbleEnvironment" isEqual:key]) {
        ORVigilentConfigurationHasRunExpectations = YES;
    }
}


@end
