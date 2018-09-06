	//
	//  Team.m
	//  Team Communicator
	//
	//  Created by Michael Dietz on 16.04.10.
	//  Copyright 2010 __MyCompanyName__. All rights reserved.
	//
#import "PersonalRecordingItem.h"

@implementation PersonalRecordingItem

@synthesize name, description, image, timeRecords, type, planEffort, startedTimeRecording;


+(PersonalRecordingItem*)createItem:(NSString*)_name:(NSString*)_description:(int)_planEffort:(int)_type:(UIImage*)_image{
	PersonalRecordingItem* item        = [[PersonalRecordingItem alloc] init];
	item.name     = _name;
	item.description = _description;
	item.image    = _image;
	item.planEffort = _planEffort;
	item.type = _type;
	
	[CacheDataManager addToItemList:item];
	
	return item;
}

-(void)addRecord:(PersonalTimeRecord*)record{
	if(timeRecords == nil)
		timeRecords = [[NSMutableArray alloc] initWithCapacity:1];
	
		//Generate UUID
	CFUUIDRef theUUID = CFUUIDCreate(NULL);
	record.uniqueID = (NSString*) CFUUIDCreateString(NULL, theUUID);
	CFRelease(theUUID);
	
		//Add record
	[timeRecords addObject:record];
	[CacheDataManager saveItemList];	
}

-(float)countTotalHours{
	float hours = 0;
	for(PersonalTimeRecord* record in self.timeRecords){
		hours += [record hoursWithMinutesAsFloat];
	}
	return hours;
}

-(NSDate*)getLatestRecordingDate{
	NSDate* latest = [NSDate dateWithTimeIntervalSince1970:0];
	for(PersonalTimeRecord* record in self.timeRecords){
		if([latest laterDate:record.recordingDate])
			latest = record.recordingDate;
	}
	return latest;
	
}

#pragma mark Service Class

+(NSString*)text4ItemType:(int)itemtype{
	if(itemtype == 0)
		return NSLocalizedString(@"Project", @"");
	else if(itemtype == 1)
		return NSLocalizedString(@"Service Order", @"");
	else if(itemtype == 2)
		return NSLocalizedString(@"Opportunity", @"");
	else if(itemtype == 3)
		return NSLocalizedString(@"Marketing", @"");
	else if(itemtype == 4)
		return NSLocalizedString(@"Innovation", @"");
	else if(itemtype == 5)
		return NSLocalizedString(@"Others", @"");
	
	return @"";
}

#pragma mark NSConding

- (id)initWithCoder: (NSCoder *)coder {
	self.name                 = [coder decodeObjectForKey:@"itemname"];	
	self.description          = [coder decodeObjectForKey:@"itemdescription"];
	self.image                = [coder decodeObjectForKey:@"itemimage"];
	self.type                 = [coder decodeIntForKey:@"itemtype"]; 
	self.planEffort           = [coder decodeIntForKey:@"itemplannedeffortint"]; 
	self.timeRecords          = [coder decodeObjectForKey:@"people"];
	self.startedTimeRecording = [coder decodeIntForKey:@"startedtimerecordingint"];
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {   
    [coder encodeObject:self.name                 forKey:@"itemname"];
    [coder encodeObject:self.description          forKey:@"itemdescription"];
    [coder encodeObject:self.image                forKey:@"itemimage"];
	[coder encodeInt:self.type                    forKey:@"itemtype"];
	[coder encodeInt:self.planEffort              forKey:@"itemplannedeffortint"];
	[coder encodeObject:self.timeRecords          forKey:@"people"];
	[coder encodeInt:self.startedTimeRecording    forKey:@"startedtimerecordingint"];
}




@end
