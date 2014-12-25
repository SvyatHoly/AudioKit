//
//  AKBeatenPlate.m
//  AudioKit
//
//  Auto-generated on 12/25/14.
//  Copyright (c) 2014 Aurelius Prochazka. All rights reserved.
//
//  Implementation of Csound's wguide2:
//  http://www.csounds.com/manual/html/wguide2.html
//

#import "AKBeatenPlate.h"
#import "AKManager.h"

@implementation AKBeatenPlate
{
    AKParameter * _audioSource;
}

- (instancetype)initWithAudioSource:(AKParameter *)audioSource
                         frequency1:(AKParameter *)frequency1
                         frequency2:(AKParameter *)frequency2
                   cutoffFrequency1:(AKParameter *)cutoffFrequency1
                   cutoffFrequency2:(AKParameter *)cutoffFrequency2
                          feedback1:(AKParameter *)feedback1
                          feedback2:(AKParameter *)feedback2
{
    self = [super initWithString:[self operationName]];
    if (self) {
        _audioSource = audioSource;
        _frequency1 = frequency1;
        _frequency2 = frequency2;
        _cutoffFrequency1 = cutoffFrequency1;
        _cutoffFrequency2 = cutoffFrequency2;
        _feedback1 = feedback1;
        _feedback2 = feedback2;
    }
    return self;
}

- (instancetype)initWithAudioSource:(AKParameter *)audioSource
{
    self = [super initWithString:[self operationName]];
    if (self) {
        _audioSource = audioSource;
        // Default Values
        _frequency1 = akp(5000);
        _frequency2 = akp(2000);
        _cutoffFrequency1 = akp(3000);
        _cutoffFrequency2 = akp(1500);
        _feedback1 = akp(0.25);
        _feedback2 = akp(0.25);
    }
    return self;
}

+ (instancetype)audioWithAudioSource:(AKParameter *)audioSource
{
    return [[AKBeatenPlate alloc] initWithAudioSource:audioSource];
}

- (void)setOptionalFrequency1:(AKParameter *)frequency1 {
    _frequency1 = frequency1;
}
- (void)setOptionalFrequency2:(AKParameter *)frequency2 {
    _frequency2 = frequency2;
}
- (void)setOptionalCutoffFrequency1:(AKParameter *)cutoffFrequency1 {
    _cutoffFrequency1 = cutoffFrequency1;
}
- (void)setOptionalCutoffFrequency2:(AKParameter *)cutoffFrequency2 {
    _cutoffFrequency2 = cutoffFrequency2;
}
- (void)setOptionalFeedback1:(AKParameter *)feedback1 {
    _feedback1 = feedback1;
}
- (void)setOptionalFeedback2:(AKParameter *)feedback2 {
    _feedback2 = feedback2;
}

- (NSString *)stringForCSD {
    NSMutableString *csdString = [[NSMutableString alloc] init];

    [csdString appendFormat:@"%@ wguide2 ", self];

    if ([_audioSource isKindOfClass:[AKAudio class]] ) {
        [csdString appendFormat:@"%@, ", _audioSource];
    } else {
        [csdString appendFormat:@"AKAudio(%@), ", _audioSource];
    }

    [csdString appendFormat:@"%@, ", _frequency1];
    
    [csdString appendFormat:@"%@, ", _frequency2];
    
    if ([_cutoffFrequency1 isKindOfClass:[AKControl class]] ) {
        [csdString appendFormat:@"%@, ", _cutoffFrequency1];
    } else {
        [csdString appendFormat:@"AKControl(%@), ", _cutoffFrequency1];
    }

    if ([_cutoffFrequency2 isKindOfClass:[AKControl class]] ) {
        [csdString appendFormat:@"%@, ", _cutoffFrequency2];
    } else {
        [csdString appendFormat:@"AKControl(%@), ", _cutoffFrequency2];
    }

    if ([_feedback1 isKindOfClass:[AKControl class]] ) {
        [csdString appendFormat:@"%@, ", _feedback1];
    } else {
        [csdString appendFormat:@"AKControl(%@), ", _feedback1];
    }

    if ([_feedback2 isKindOfClass:[AKControl class]] ) {
        [csdString appendFormat:@"%@", _feedback2];
    } else {
        [csdString appendFormat:@"AKControl(%@)", _feedback2];
    }
return csdString;
}

@end
