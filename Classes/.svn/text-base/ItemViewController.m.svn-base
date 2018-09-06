//
//  TeamView.m
//  Team Communicator
//
//  Created by Michael Dietz on 16.04.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ItemViewController.h"
#import "TimeRecording.h"
#import "TimeRecords.h"

#define AD_ACTIVE YES

@implementation ItemViewController

@synthesize recordingitem, teamName, teamKeywords, teamImage, plannedEffortLabel, actualEffortLabel, lastTimeRecord, startStopButton, adBannerView;

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = [PersonalRecordingItem text4ItemType:recordingitem.type];
	
    //Init Back Button
	UIBarButtonItem *temporaryBarButtonItem = [[ UIBarButtonItem alloc] init]; 
	temporaryBarButtonItem.title = NSLocalizedString(@"Back", @""); 
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	[temporaryBarButtonItem release];
	
    //Refresh the UI
	[self refreshUI];
}

-(void)viewWillAppear:(BOOL)animated{
	[self refreshUI];
}

#pragma mark UI Refreshs

-(void)refreshUI{
    //Refresh Labels
	self.teamName.text = recordingitem.name;
	self.teamKeywords.text = recordingitem.description;
	self.plannedEffortLabel.text = [OutputFormatter hoursToString:recordingitem.planEffort];
	
    //Refresh Image
	if(recordingitem.image != nil)
		[self.teamImage setImage:recordingitem.image];
	
    //Refresh Quick Time Record Button Label
	[self refreshQuickRecordingButtonLabel];
	
    //Refresh Actual Hours Label and Last Recording Date
    
	actualEffortLabel.text = [OutputFormatter hoursAndMinutesToStringFromFloat:[recordingitem countTotalHours]];
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	[formatter setDateFormat:NSLocalizedString(@"MM/dd/yyyy",@"DateFormatter")];
	NSDate* date = [recordingitem getLatestRecordingDate];
	
	if([date timeIntervalSince1970]>1)
		lastTimeRecord.text = [formatter stringFromDate:date];
	else 
		lastTimeRecord.text = NSLocalizedString(@"No Records", @"");
    
}

-(void)refreshQuickRecordingButtonLabel{
	if(recordingitem.startedTimeRecording > 0){	
		NSTimeInterval current = [[NSDate date] timeIntervalSince1970];
		int secondsDiff = current - recordingitem.startedTimeRecording;
		int hours = secondsDiff / 60 / 60;
		int minutes = (secondsDiff / 60) - hours * 60;
		NSString* hMinString = [OutputFormatter hoursAndMinutesToSimpleString:hours :minutes];
		[startStopButton setTitle:[NSString stringWithFormat:NSLocalizedString(@"Stop Recording (%@)",@""), hMinString] forState:UIControlStateNormal];
        
		if(timer == nil){
			timer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(refreshQuickRecordingButtonLabel) userInfo:nil repeats:YES];
		}
	} else {
		[startStopButton setTitle:NSLocalizedString(@"Start Recording",@"") forState:UIControlStateNormal];
		[timer invalidate];
		timer = nil;
		
	}
}

#pragma mark Button Actions

-(IBAction)recordTime{
	TimeRecording*	trController = [[TimeRecording alloc] initWithNibName:@"TimeRecording" bundle:nil];
	trController.worklistitem = recordingitem;
	[self.navigationController pushViewController:trController animated:YES];
}

-(IBAction)showTimeRecords{
	TimeRecords*	trController = [[TimeRecords alloc] initWithNibName:@"TimeRecords" bundle:nil];
	trController.item = recordingitem;
	[self.navigationController pushViewController:trController animated:YES];
}

-(IBAction)startStopTimeRecording{
	if(recordingitem.startedTimeRecording <= 0){	
		NSTimeInterval current = [[NSDate date] timeIntervalSince1970];
		recordingitem.startedTimeRecording = current;
		[CacheDataManager saveItemList];
    } else {
		
		NSTimeInterval current = [[NSDate date] timeIntervalSince1970];
		int secondsDiff = current - recordingitem.startedTimeRecording;
		int hours = secondsDiff / 60 / 60;
		int minutes = (secondsDiff / 60) - hours * 60;
		
		if(hours > 0 || minutes > 0 ){
			
            //Check 24h cut
            NSUserDefaults* settings = [NSUserDefaults standardUserDefaults];
            
            if(hours >= 24){
                hours = 24;
                minutes = 0;
            }
            
            //Check day cut
            if([settings boolForKey:@"daycut"] == YES){
                [NSDate dateWithTimeIntervalSince1970:recordingitem.startedTimeRecording];
                NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
                [formatter setDateFormat:@"MM/dd/yyyy"];
            }             
            
            //Open Time Recording View
			TimeRecording*	trController = [[TimeRecording alloc] initWithNibName:@"TimeRecording" bundle:nil];
			trController.worklistitem = recordingitem;
			
            //Show View
			[self.navigationController pushViewController:trController animated:YES];
			
            //Set the current values and set shortText as First responer
			[trController.hoursPicker selectRow:hours inComponent:0 animated:YES];
			[trController.hoursPicker selectRow:minutes inComponent:1 animated:YES];
			trController.selectedHours     = hours;
			trController.selectedMinutes = minutes;
			[trController updateSelectedTime];
			trController.hoursPicker.hidden = NO;
			trController.datePicker.hidden = YES;
			trController.fromQuick = YES;
			[trController.shortText becomeFirstResponder];
			[trController release];
		} else {
            recordingitem.startedTimeRecording = 0;
            [CacheDataManager saveItemList];
        }
	}
	
    //Update Button Label
	[self refreshQuickRecordingButtonLabel];
    
}

#pragma mark Edit Item and the Closer of the Modal Screen

-(IBAction)editItem{
    //Initialize ItemCreateController
	itemController = [[ItemCreateViewController alloc] initWithNibName:@"ItemCreateView" bundle:nil];
	itemController.delegate = self;
	itemController.item = recordingitem;
	[itemController set2ChangeMode];
	
    //Show View
	[self presentModalViewController:itemController animated:YES];
	[itemController release];
}

- (void)closeModalScreen:(UIViewController *)controller{
	recordingitem = itemController.item;
	[self dismissModalViewControllerAnimated:YES];
	[self refreshUI];
}

#pragma mark iAd Framework

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave{
	return AD_ACTIVE;
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!adVisible && AD_ACTIVE)
    {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        adBannerView.frame  = CGRectOffset(banner.frame, 0, adBannerView.frame.size.height * (-1));
		[UIView commitAnimations];
        adVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
	if (adVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
        [UIView commitAnimations];
        adVisible = NO;
    }
}

#pragma mark Finalize

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}


- (void)dealloc {
    [super dealloc];
}


@end
