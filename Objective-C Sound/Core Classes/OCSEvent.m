//
//  OCSEvent.m
//  Objective-C Sound
//
//  Created by Aurelius Prochazka on 7/1/12.
//  Copyright (c) 2012 Hear For Yourself. All rights reserved.
//

#import "OCSEvent.h"
#import "OCSManager.h"

typedef void (^MyBlockType)();

@interface OCSEvent () {
    NSMutableString *scoreLine;
    MyBlockType block;
    int _myID;
    float eventNumber;
    OCSInstrument *instr;    
}
@end

@implementation OCSEvent

@synthesize eventNumber;
@synthesize instrument = instr;

// -----------------------------------------------------------------------------
#  pragma mark - Initialization
// -----------------------------------------------------------------------------

static int currentID = 1;
+ (void)resetID { currentID = 1; }

- (id)init {
    self = [super init];
    if (self) {
        if (currentID > 99000) {
            [OCSEvent resetID];
        }
        _myID = currentID++;
        scoreLine  = [[NSMutableString alloc] init];
    }
    return self;
}

// -----------------------------------------------------------------------------
#  pragma mark - Instrument Based Events
// -----------------------------------------------------------------------------

- (id)initWithInstrument:(OCSInstrument *)instrument duration:(float)duration;
{
    self = [self init];
    if (self) {
        instr = instrument;
        eventNumber  = [instrument instrumentNumber] + _myID/100000.0;
        scoreLine = [NSMutableString stringWithFormat:@"i %0.5f 0 %g", eventNumber, duration];
    }
    return self;
}

- (id)initWithInstrument:(OCSInstrument *)instrument;
{
    return [self initWithInstrument:instrument duration:-1];
}


// -----------------------------------------------------------------------------
#  pragma mark - Note Based Events
// -----------------------------------------------------------------------------

@synthesize note;

- (id)initWithNote:(OCSNote *)newNote {
    self = [self init];
    if (self) {
        note = newNote;
        eventNumber  = [note.instrument instrumentNumber] + _myID/100000.0;
        scoreLine = [NSMutableString stringWithFormat:@"i %0.5f 0 -1", eventNumber];
    }
    return self;
}

- (id)initWithNote:(OCSNote *)newNote block:(void (^)())aBlock {
    self = [self initWithNote:newNote];
    if (self) {
        block = aBlock;
    }
    return self;
}


- (id)initWithBlock:(void (^)())aBlock {
    self = [self init];
    if (self) {
        block = aBlock;
    }
    return self;
}

- (void)runBlock {
    if (self->block) block();
}

// -----------------------------------------------------------------------------
#  pragma mark - Event Based Events
// -----------------------------------------------------------------------------

- (id)initWithEvent:(OCSEvent *)event 
{
    self = [self init];
    if (self) {
        instr = [event instrument];
        eventNumber  = [event eventNumber];
        scoreLine = [NSMutableString stringWithFormat:@"i %0.5f 0 0.1", eventNumber];
        if (event.note) {
            note = event.note;
        }
    }
    return self;
}


- (id)initDeactivation:(OCSEvent *)event
         afterDuration:(float)delay;
{
    self = [self init];
    if (self) {
        scoreLine = [NSMutableString stringWithFormat:@"i -%0.5f %f 0.1", 
                     [event eventNumber], delay ];

        // This next method uses the turnoff2 opcode which might prove advantageous 
        // so I won't delete it just yet.
//        scoreLine = [NSString stringWithFormat:@"i \"Deactivator\" %f 0.1 %0.3f\n", 
//                     delay, [event eventNumber]];
    }
    return self;
}


// -----------------------------------------------------------------------------
#  pragma mark - Csound Implementation
// -----------------------------------------------------------------------------

- (void)start;
{
    [[OCSManager sharedOCSManager] startEvent:self];
}

- (void)stop;
{
    OCSEvent *stoppage = [[OCSEvent alloc] initDeactivation:self afterDuration:0.0];
    [[OCSManager sharedOCSManager] startEvent:stoppage];
}

- (NSString *)stringForCSD;
{
    if (![scoreLine isEqual:@""]) NSLog(@"Event Scoreline: %@\n", scoreLine);
    return [NSString stringWithFormat:@"%@",scoreLine];
}

@end
