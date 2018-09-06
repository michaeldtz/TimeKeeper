//
//  TimeRecords.h
//
//  Created by Dietz, Michael on 5/2/10.
//  Copyright 2010 MD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalRecordingItem.h"

@interface TimeRecords : UIViewController {

	PersonalRecordingItem* item;
    UITableView* table;
}

@property(assign) PersonalRecordingItem* item;
@property(retain) IBOutlet UITableView* table;

@end
