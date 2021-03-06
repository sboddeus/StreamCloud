//
//  RepeatButtonCell.m
//  SoundcloudPlayer
//
//  Created by Philip Brechler on 24.06.14.
//  Copyright (c) 2014 Call a Nerd. All rights reserved.
//

#import "RepeatButtonCell.h"
#import "StreamCloudStyles.h"
#import "SharedAudioPlayer.h"

@implementation RepeatButtonCell

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(repeatModeChanged) name:@"SharedAudioPlayerChangedRepeatMode" object:nil];
    }
    return self;
}

- (void)drawBezelWithFrame:(NSRect)frame inView:(NSView *)controlView {
    RepeatMode repeatMode = [[SharedAudioPlayer sharedPlayer] repeatMode];
    switch (repeatMode) {
        case RepeatModeNone:
            [StreamCloudStyles drawRepeatButtonWithFrame:frame repeatMode:1];
            break;
        case RepeatModeAll:
            [StreamCloudStyles drawRepeatButtonWithFrame:frame repeatMode:2];
            break;
        case RepeatModeTrack:
            [StreamCloudStyles drawRepeatButtonWithFrame:frame repeatMode:3];
            break;
    }
}

- (void)repeatModeChanged {
    [self setEnabled:NO];
    [self setEnabled:YES];
}

@end
