//
//  HelloWorldLayer.m
//  Record
//
//  Created by Amit Suneja on 09/07/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"
// HelloWorldLayer implementation
@implementation HelloWorldLayer


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
// on "init" you need to initialize your instance
- (id) init
{
    self = [super init];
    if (self != nil) {
        
        [self addChild:[HelloWorldLayer node] z:1];
        CCLabelTTF *initRecordLabel = [CCLabelTTF labelWithString:@"Init Record"
                                                         fontName:@"Arial"
                                                         fontSize:22];
		initRecordLabel.color = ccWHITE;
		
		CCMenuItemLabel *initRecordItem = [CCMenuItemLabel itemWithLabel:initRecordLabel
                                                                  target:self
                                                                selector:@selector(initRecord)];
		
		CCLabelTTF *checkMicLabel = [CCLabelTTF labelWithString:@"Check Mic"
                                                       fontName:@"Arial"
                                                       fontSize:22];
		checkMicLabel.color = ccWHITE;
		
		CCMenuItemLabel *checkMicItem = [CCMenuItemLabel itemWithLabel:checkMicLabel
                                                                target:self
                                                              selector:@selector(checkMic)];
		
		CCLabelTTF *startRecordLabel = [CCLabelTTF labelWithString:@"Start Record"
                                                          fontName:@"Arial"
                                                          fontSize:22];
		startRecordLabel.color = ccWHITE;
		
		CCMenuItemLabel *startRecordItem = [CCMenuItemLabel itemWithLabel:startRecordLabel
                                                                   target:self
                                                                 selector:@selector(startRecord)];
		
		CCLabelTTF *stopRecordLabel = [CCLabelTTF labelWithString:@"Stop Record"
                                                         fontName:@"Arial"
                                                         fontSize:22];
		stopRecordLabel.color = ccWHITE;
		
		CCMenuItemLabel *stopRecordItem = [CCMenuItemLabel itemWithLabel:stopRecordLabel
                                                                  target:self
                                                                selector:@selector(stopRecord)];
		
		CCLabelTTF *playRecordLabel = [CCLabelTTF labelWithString:@"Play record"
                                                         fontName:@"Arial"
                                                         fontSize:22];
		playRecordLabel.color = ccWHITE;
		
		CCMenuItemLabel *playRecordItem = [CCMenuItemLabel itemWithLabel:playRecordLabel
                                                                  target:self
                                                                selector:@selector(playRecord)];
		
		CCMenu *menu = [CCMenu menuWithItems:
						initRecordItem,
						checkMicItem,
						startRecordItem,
						stopRecordItem,
						playRecordItem,
						nil];
		
		[menu alignItemsVerticallyWithPadding:10.0f];
		menu.position = ccp(240, 160);
		[self addChild:menu];
    }
    return self;
}

-(void) initRecord
{
	audioSession = [[AVAudioSession sharedInstance] retain];
	[audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error: nil];
	[audioSession setActive:YES error:nil];
	
	destinationString = [[self documentsPath]
						 stringByAppendingPathComponent:@"test.caf"];
	NSLog(@"destinationString=%@", destinationString);
	NSURL *destinationURL = [NSURL fileURLWithPath: destinationString];
	
	NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
							  [NSNumber numberWithFloat: 44100.0],                 AVSampleRateKey,
							  [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
							  [NSNumber numberWithInt: 1],                         AVNumberOfChannelsKey,
							  [NSNumber numberWithInt: AVAudioQualityMax],         AVEncoderAudioQualityKey,
							  nil];
	
	NSError *error;
	
	recorder = [[AVAudioRecorder alloc] initWithURL:destinationURL settings:settings error:&error];
	recorder.delegate = self;
}

-(void) checkMic
{
	if ( audioSession.inputAvailable) {
        
		NSLog(@"Mic connected");
	}
	else {
		NSLog(@"Mic not connected");
	}
}

-(void) startRecord
{
	if (recorder) {
		[recorder prepareToRecord];
		recorder.meteringEnabled = YES;
		[recorder record];
        NSLog(@"recorder=%@",recorder);
	}
}
-(void) stopRecord
{
	[recorder stop];
}

-(void) playRecord
{
	player =[[AVAudioPlayer alloc] initWithContentsOfURL:
			 [NSURL fileURLWithPath:destinationString]
												   error:NULL];
	
	[player play];
}

- (NSString*) documentsPath
{
	NSArray *searchPaths =
	NSSearchPathForDirectoriesInDomains
	(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* _documentsPath = [searchPaths objectAtIndex: 0];
	[_documentsPath retain];
	
	return _documentsPath;
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder
						   successfully:(BOOL)flag
{
	if (flag) {
		
		NSLog(@"audioRecorderDidFinishRecording OK");
	}
	else {
		
		NSLog(@"audioRecorderDidFinishRecording ERROR");
	}
    
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
