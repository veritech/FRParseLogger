//
//  FRParseLogger.m
//
//  Created by Jonathan Dalrymple on 19/06/2012.
//  Copyright (c) 2012 Float:Right Ltd. All rights reserved.
//

#import "FRParseLogger.h"
#import <Parse/Parse.h>

@interface FRParseLogger (){
	NSDateFormatter *dateFormatter_;
}

@end

@implementation FRParseLogger

static FRParseLogger *sharedLogger;

+ (void)initialize
{
	static BOOL initialized = NO;
	if (!initialized)
	{
		initialized = YES;
		
		sharedLogger = [[FRParseLogger alloc] init];
	}
}

+(id) sharedInstance{
	return sharedLogger;
}

- (id)init
{
	if (sharedLogger != nil)
	{
		return nil;
	}
	
	if ((self = [super init]))
	{
		[Parse setApplicationId:@"YOUR_PARSE_ID"
					  clientKey:@"YOUR_PARSE_KEY"];
	}
	return self;
}

-(NSDateFormatter*) dateFormatter{
	
	if( !dateFormatter_ ){
		dateFormatter_ = [[NSDateFormatter alloc] init];
		[dateFormatter_ setFormatterBehavior:NSDateFormatterBehavior10_4];
		[dateFormatter_ setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];		
	}
	
	return dateFormatter_;
}

- (void)logMessage:(DDLogMessage *) aLogMessage{

	PFObject	*obj;
	NSString	*logMsg = aLogMessage->logMsg;
	
	if( [self logFormatter] ){
		[[self logFormatter] formatLogMessage:aLogMessage];
	}	
	
	obj = [PFObject objectWithClassName:@"FRParseLogger"];
	
	[obj setObject:logMsg 
			forKey:@"message"];	
	
	[obj setObject:[[UIDevice currentDevice] name]
			forKey:@"device"];
	
	[obj setObject:[[NSString stringWithUTF8String: aLogMessage->file] lastPathComponent]
			forKey:@"file"];
	
	[obj setObject:[NSString stringWithUTF8String:aLogMessage->function]
			forKey:@"Method"];
	
	[obj setObject:[[NSNumber numberWithInt:aLogMessage->lineNumber] stringValue]
			forKey:@"line"];
		
	[obj saveEventually];
	
}

- (NSString *)loggerName{
	return @"com.floatright.ParseLogger";
}

@end
