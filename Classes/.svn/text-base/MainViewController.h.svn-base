//
//  RootViewController.h
//  Team Communicator
//
//  Created by Michael Dietz on 16.04.10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "ModalScreenCloser.h"
#import "CacheDataManager.h"
#import "AboutViewController.h"
#import <iAd/iAd.h>

@interface MainViewController : UIViewController <ModalScreenCloser, UIActionSheetDelegate, UITableViewDelegate, UITableViewDataSource, ADBannerViewDelegate> {

	IBOutlet UIScrollView* squareView;
	IBOutlet UITableView*  listView;

	ADBannerView*          adBannerView;
    BOOL                   adVisible;
} 

@property(assign) IBOutlet UIScrollView* squareView;
@property(assign) IBOutlet UITableView*  listView;
@property(assign) IBOutlet ADBannerView* adBannerView;

-(void)refreshSquarePane;
-(void)openRecordingItem:(id)eventObject;
-(IBAction)showAbout;
-(void)askForType;
-(void)showAnalytics;
-(IBAction)changeViewType;

@end


