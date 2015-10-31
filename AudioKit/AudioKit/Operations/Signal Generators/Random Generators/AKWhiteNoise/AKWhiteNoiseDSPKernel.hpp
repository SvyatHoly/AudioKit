//
//  AKWhiteNoiseDSPKernel.hpp
//  AudioKit
//
//  Autogenerated by scripts by Aurelius Prochazka. Do not edit directly.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

#ifndef AKWhiteNoiseDSPKernel_hpp
#define AKWhiteNoiseDSPKernel_hpp

#import "AKDSPKernel.hpp"
#import "AKParameterRamper.hpp"

extern "C" {
#include "soundpipe.h"
}

enum {
    amplitudeAddress = 0
};

class AKWhiteNoiseDSPKernel : public AKDSPKernel {
public:
    // MARK: Member Functions

    AKWhiteNoiseDSPKernel() {}

    void init(int channelCount, double inSampleRate) {
        channels = channelCount;

        sampleRate = float(inSampleRate);

        sp_create(&sp);
        sp_noise_create(&noise);
        sp_noise_init(sp, noise);
        noise->amp = 1.0;
    }

    void reset() {
    }

    void setParameter(AUParameterAddress address, AUValue value) {
        switch (address) {
            case amplitudeAddress:
                amplitudeRamper.set(clamp(value, (float)0.0, (float)10.0));
                break;

        }
    }

    AUValue getParameter(AUParameterAddress address) {
        switch (address) {
            case amplitudeAddress:
                return amplitudeRamper.goal();

            default: return 0.0f;
        }
    }

    void startRamp(AUParameterAddress address, AUValue value, AUAudioFrameCount duration) override {
        switch (address) {
            case amplitudeAddress:
                amplitudeRamper.startRamp(clamp(value, (float)0.0, (float)10.0), duration);
                break;

        }
    }

    void setBuffers(AudioBufferList* inBufferList, AudioBufferList* outBufferList) {
        inBufferListPtr = inBufferList;
        outBufferListPtr = outBufferList;
    }

    void process(AUAudioFrameCount frameCount, AUAudioFrameCount bufferOffset) override {
        // For each sample.
        for (int frameIndex = 0; frameIndex < frameCount; ++frameIndex) {
            double amplitude = double(amplitudeRamper.getStep());

            int frameOffset = int(frameIndex + bufferOffset);

            noise->amp = (float)amplitude;

            for (int channel = 0; channel < channels; ++channel) {
                float* in  = (float*)inBufferListPtr->mBuffers[channel].mData  + frameOffset;
                float* out = (float*)outBufferListPtr->mBuffers[channel].mData + frameOffset;

                sp_noise_compute(sp, noise, in, out);
            }
        }
    }

    // MARK: Member Variables

private:

    int channels = 2;
    float sampleRate = 44100.0;

    AudioBufferList* inBufferListPtr = nullptr;
    AudioBufferList* outBufferListPtr = nullptr;

    sp_data *sp;
    sp_noise *noise;

public:
    AKParameterRamper amplitudeRamper = 1.0;
};

#endif /* AKWhiteNoiseDSPKernel_hpp */
