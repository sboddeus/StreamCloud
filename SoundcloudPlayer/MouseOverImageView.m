//
//  MouseOverImageView.m
//  SoundcloudPlayer
//
//  Created by Philip Brechler on 26.06.14.
//  Copyright (c) 2014 Call a Nerd. All rights reserved.
//

#import "MouseOverImageView.h"
#import "PlayPauseOverlayView.h"
#import "SharedAudioPlayer.h"

@interface MouseOverImageView ()

@property (nonatomic, strong) NSTrackingArea *trackingArea;
@property (nonatomic) BOOL mouseOver;
@property (nonatomic, strong) PlayPauseOverlayView *playPauseOverlayView;

@end

@implementation MouseOverImageView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self){
        [self commonInit];
    }
    return self;
}

- (void)setRow:(NSInteger)row {
    _row = row;
    [self.playPauseOverlayView setRow:row];
}

- (void)commonInit {
    self.playPauseOverlayView = [[PlayPauseOverlayView alloc] initWithFrame:NSMakeRect(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.playPauseOverlayView setHidden:YES];
    [self.playPauseOverlayView setRow:self.row];
    [self addSubview:self.playPauseOverlayView];
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
}

- (void)mouseEntered:(NSEvent *)theEvent {
    self.mouseOver = YES;
    [self.playPauseOverlayView setHidden:NO];
}

- (void)mouseExited:(NSEvent *)theEvent {
    self.mouseOver = NO;
    [self.playPauseOverlayView setHidden:YES];
}

- (void)mouseDown:(NSEvent *)theEvent {
    if (self.row == [SharedAudioPlayer sharedPlayer].positionInPlaylist)
        [[SharedAudioPlayer sharedPlayer] togglePlayPause];
    else
        [[SharedAudioPlayer sharedPlayer] jumpToItemAtIndex:self.row];
    [self.playPauseOverlayView setNeedsDisplay:YES];
}

-(void)updateTrackingAreas
{
    if(self.trackingArea != nil) {
        [self removeTrackingArea:self.trackingArea];
    }
    
    int opts = (NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways);
    self.trackingArea = [ [NSTrackingArea alloc] initWithRect:[self bounds]
                                                 options:opts
                                                   owner:self
                                                userInfo:nil];
    [self addTrackingArea:self.trackingArea];
}

@end