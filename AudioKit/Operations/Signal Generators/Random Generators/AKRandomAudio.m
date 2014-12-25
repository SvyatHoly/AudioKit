//
//  AKRandomAudio.m
//  AudioKit
//
//  Auto-generated on 12/25/14.
//  Copyright (c) 2014 Aurelius Prochazka. All rights reserved.
//
//  Implementation of Csound's random:
//  http://www.csounds.com/manual/html/random.html
//

#import "AKRandomAudio.h"
#import "AKManager.h"

@implementation AKRandomAudio

- (instancetype)initWithLowerBound:(AKParameter *)lowerBound
                        upperBound:(AKParameter *)upperBound
{
    self = [super initWithString:[self operationName]];
    if (self) {
        _lowerBound = lowerBound;
        _upperBound = upperBound;
    }
    return self;
}

- (instancetype)init
{
    self = [super initWithString:[self operationName]];
    if (self) {
        // Default Values
        _lowerBound = akp(0);
        _upperBound = akp(1);
    }
    return self;
}

+ (instancetype)audio
{
    return [[AKRandomAudio alloc] init];
}

- (void)setOptionalLowerBound:(AKParameter *)lowerBound {
    _lowerBound = lowerBound;
}
- (void)setOptionalUpperBound:(AKParameter *)upperBound {
    _upperBound = upperBound;
}

- (NSString *)stringForCSD {
    NSMutableString *csdString = [[NSMutableString alloc] init];

    [csdString appendFormat:@"%@ random ", self];

    if ([_lowerBound isKindOfClass:[AKControl class]] ) {
        [csdString appendFormat:@"%@, ", _lowerBound];
    } else {
        [csdString appendFormat:@"AKControl(%@), ", _lowerBound];
    }

    if ([_upperBound isKindOfClass:[AKControl class]] ) {
        [csdString appendFormat:@"%@", _upperBound];
    } else {
        [csdString appendFormat:@"AKControl(%@)", _upperBound];
    }
return csdString;
}

@end
