//
//  HelloWorldLayer.h
//  Record
//
//  Created by Amit Suneja on 09/07/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import <AVFoundation/AVFoundation.h>
#import "CocosDenshion.h"
#import <CoreAudio/CoreAudioTypes.h>
@interface HelloWorldLayer : CCLayer<AVAudioRecorderDelegate>
{
    AVAudioPlayer *player;
	AVAudioRecorder *recorder;
	AVAudioSession *audioSession;
	NSString *destinationString;


}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
-(void) startRecord;
-(void) stopRecord;
-(void) playRecord;
-(void) initRecord;
-(void) checkMic;

- (NSString*) documentsPath;
@end
