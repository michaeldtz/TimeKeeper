	//
	//  TimeRecords.m
	//
	//  Created by Dietz, Michael on 5/2/10.
	//  Copyright 2010 MD. All rights reserved.
	//

#import "TimeRecords.h"
#import "PersonalTimeRecord.h"
#import "OutputFormatter.h"

@implementation TimeRecords

@synthesize item, table;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
    self.navigationItem.title = NSLocalizedString(@"Recorded Hours",@"");
	
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self.table reloadData];
}


#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [item.timeRecords count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"TimeRecordCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	
	PersonalTimeRecord* record = [item.timeRecords objectAtIndex:indexPath.row];
	
	NSString *accept = [[NSBundle mainBundle] pathForResource:@"clock" ofType:@"png"]; 
	UIImage* imageOK = [[UIImage alloc] initWithContentsOfFile:accept];
	
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	//[formatter setDateFormat:NSLocalizedString(@"MM/dd/yyyy",@"DateFormatter")];

	NSMutableString* textString = [[NSMutableString alloc] initWithString:[OutputFormatter hoursAndMinutesToMediumString:record.hours :record.minutes]];
	[textString appendFormat:NSLocalizedString(@" on %@",@""), 	[formatter stringFromDate:record.workdate]];
	
    cell.textLabel.text = textString;
	cell.detailTextLabel.text = record.shortText;
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	cell.imageView.image = imageOK;
	
    return cell;
}

	// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (editingStyle == UITableViewCellEditingStyleDelete) {
			// Delete the row from the data source
		[item.timeRecords removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
	}      
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}


- (void)dealloc {
    [super dealloc];
}


@end

