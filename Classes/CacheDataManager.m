	//
	//  DataManager.m
	//  Team Communicator
	//
	//  Created by Michael Dietz on 16.04.10.
	//  Copyright 2010 __MyCompanyName__. All rights reserved.
	//

#import "CacheDataManager.h"


@implementation CacheDataManager

static NSMutableArray* teamList;


+(NSMutableArray*)loadItemList{
	
	if(teamList == nil)
		[CacheDataManager reloadItemList];
	
	return teamList;
}

+(void)reloadItemList{
	
	NSUserDefaults* prefs = [NSUserDefaults standardUserDefaults];
	
	NSData* data = (NSData*)[prefs objectForKey:@"RECORDOBJECTLIST"];
	if (data != nil)
	{
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (oldSavedArray != nil)
			teamList = [[NSMutableArray alloc] initWithArray:oldSavedArray];
        else
			teamList = [[NSMutableArray alloc] init];
	}
	
	if(teamList == nil)
		teamList = [[NSMutableArray alloc] init];
	
}

+(void)addToItemList:(PersonalRecordingItem*)item{
	if(teamList == nil)
		[self reloadItemList];
	[teamList addObject:item];
	[CacheDataManager saveItemList];
}

+(void)saveItemList{
	NSUserDefaults* settings = [NSUserDefaults standardUserDefaults];
	NSData* data = [NSKeyedArchiver archivedDataWithRootObject:teamList];
	
	NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding]);
	
	[settings setObject:data forKey:@"RECORDOBJECTLIST"];
	[settings synchronize];
}

+(void)removeItem:(PersonalRecordingItem*)item{
	[teamList removeObject:item];
	[CacheDataManager saveItemList];
}

+(void)clear{
	teamList = [[NSMutableArray alloc] init];
	[CacheDataManager saveItemList];
}



@end
