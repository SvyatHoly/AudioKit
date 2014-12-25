//
//  AKHighPassButterworthFilter.h
//  AudioKit
//
//  Auto-generated on 12/25/14.
//  Copyright (c) 2014 Aurelius Prochazka. All rights reserved.
//

#import "AKAudio.h"
#import "AKParameter+Operation.h"

/** A high-pass Butterworth filter.

 These filters are Butterworth second-order IIR filters. They offer an almost flat passband and very good precision and stopband attenuation.
 */

@interface AKHighPassButterworthFilter : AKAudio
/// Instantiates the high pass butterworth filter with all values
/// @param audioSource Input signal to be filtered. [Default Value: ]
/// @param cutoffFrequency Cutoff frequency for each of the filters. Updated at Control-rate. [Default Value: 500]
- (instancetype)initWithAudioSource:(AKParameter *)audioSource
                    cutoffFrequency:(AKParameter *)cutoffFrequency;

/// Instantiates the high pass butterworth filter with default values
/// @param audioSource Input signal to be filtered.
- (instancetype)initWithAudioSource:(AKParameter *)audioSource;

/// Instantiates the high pass butterworth filter with default values
/// @param audioSource Input signal to be filtered.
+ (instancetype)audioWithAudioSource:(AKParameter *)audioSource;

/// Cutoff frequency for each of the filters. [Default Value: 500]
@property AKParameter *cutoffFrequency;

/// Set an optional cutoff frequency
/// @param cutoffFrequency Cutoff frequency for each of the filters. Updated at Control-rate. [Default Value: 500]
- (void)setOptionalCutoffFrequency:(AKParameter *)cutoffFrequency;



@end
