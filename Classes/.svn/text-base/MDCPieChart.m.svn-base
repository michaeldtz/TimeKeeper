	//
	//  PieChart.m
	//  TimeKeeper
	//
	//  Created by Michael Dietz on 09.11.10.
	//  Copyright 2010 SAP MD. All rights reserved.
	//

#import "MDCPieChart.h"
#import "CacheDataManager.h"

@implementation MDCPieChart

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		if(frame.size.width < frame.size.height){
			radius = (frame.size.width/2) - lineWidth;
		} else {
			radius = (frame.size.height/2) - lineWidth;
		}
	}
	return self;
}
- (void)drawRect:(CGRect)rect {
	
	/*
	 NSArray* array = [CacheDataManager loadItemList];
	 NSMutableDictionary* groups = [[NSMutableDictionary alloc] initWithCapacity:5];
	 
	 float sumFigure1 = 0;
	 float sumFigure2 = 0;
	 
	 for(PersonalRecordingItem* item in array){
	 MDCChartDataGroup* group = [groups objectForKey:[NSString stringWithFormat:@"%d", item.type]];
	 if(group == nil){
	 group = [[SumGroupObject alloc] init];
	 group.description = [PersonalRecordingItem text4ItemType:item.type];
	 }
	 
	 group.figure1 += item.planEffort;
	 group.figure2 += [item countTotalHours];
	 
	 sumFigure1 += item.planEffort;
	 sumFigure2 += [item countTotalHours];
	 
	 [groups setObject:group forKey:[NSString stringWithFormat:@"%d", item.type]];
	 }
	 
	 
	 CGContextRef ctx = UIGraphicsGetCurrentContext();
	 
	 UIColor* colors[7] = { 
	 [UIColor colorWithRed:0.1 green:0.1 blue:0.5 alpha:1], 
	 [UIColor colorWithRed:0.1 green:0.5 blue:0.1 alpha:1], 
	 [UIColor colorWithRed:0.5 green:0.1 blue:0.1 alpha:1], 
	 [UIColor colorWithRed:0.4 green:0.4 blue:0.6 alpha:1], 
	 [UIColor colorWithRed:0.4 green:0.6 blue:0.4 alpha:1], 
	 [UIColor colorWithRed:0.6 green:0.4 blue:0.4 alpha:1], 
	 [UIColor colorWithRed:0.4 green:0.0 blue:0.6 alpha:1]};
	 
	 
	 
	 int x = 95;
	 int legendY = 160;
	 int chart1Y = 110;
	 int chart2Y = 310;
	 int radius = 80;
	 
	 float lastDegreeChart1 = 0;
	 float lastDegreeChart2 = 0;
	 int counter1 = 0;
	 int counter2 = 0;
	 
	 for(MDCChartDataGroup* sum in 	[[groups objectEnumerator] allObjects]){
	 
	 //Draw Chart1
	 float degree1 =  ((float)(M_PI * 2) / (float)sumFigure1) * (float)sum.figure;
	 CGContextSetFillColorWithColor(ctx, colors[counter1].CGColor);
	 CGContextSetLineWidth(ctx , 5);
	 CGContextMoveToPoint(ctx, x, chart1Y);
	 CGContextAddArc(ctx, x, chart1Y, radius, lastDegreeChart1, lastDegreeChart1+degree1, 0);
	 CGContextClosePath(ctx);
	 CGContextFillPath(ctx);
	 
	 //Draw Values Chart 1
	 {
	 CGRect legend = CGRectMake(190, chart1Y - radius + 15*counter1, 10, 10);
	 CGContextFillRect(ctx, legend);
	 CGContextSetFillColorWithColor(ctx, [UIColor grayColor].CGColor);
	 CGRect rect = CGRectMake(210, (chart1Y - radius+ 15*counter1) - 1, 100, 12);
	 UIFont* font = [UIFont fontWithName:@"Arial" size:12];
	 [[NSString stringWithFormat:NSLocalizedString(@"%d Hours",@""), (int) sum.figure1] drawInRect:rect withFont:font];
	 
	 }
	 
	 //Draw Chart2
	 float degree2 =  ((float)(M_PI * 2) / (float)sumFigure2) * (float)sum.figure2;
	 CGContextSetFillColorWithColor(ctx, colors[counter1].CGColor);
	 CGContextSetLineWidth(ctx , 5);
	 CGContextMoveToPoint(ctx, x, chart2Y);
	 CGContextAddArc(ctx, x, chart2Y, radius, lastDegreeChart2, lastDegreeChart2+degree2, 0);
	 CGContextClosePath(ctx);
	 CGContextFillPath(ctx);
	 
	 if(degree2 > 0)
	 //Draw Values Chart 1
	 {
	 CGRect legend = CGRectMake(190, chart2Y + 15*counter2, 10, 10);
	 CGContextFillRect(ctx, legend);
	 CGContextSetFillColorWithColor(ctx, [UIColor grayColor].CGColor);
	 CGRect rect = CGRectMake(210, (chart2Y + 15*counter2) - 1, 100, 12);
	 UIFont* font = [UIFont fontWithName:@"Arial" size:12];
	 [[NSString stringWithFormat:NSLocalizedString(@"%d Hours",@""), (int) sum.figure2] drawInRect:rect withFont:font];
	 counter2++;
	 }
	 
	 //Draw Legend
	 {
	 CGContextSetFillColorWithColor(ctx, colors[counter1].CGColor);
	 CGRect legend = CGRectMake(190, legendY + 15*counter1, 10, 10);
	 CGContextFillRect(ctx, legend);
	 CGContextSetFillColorWithColor(ctx, [UIColor grayColor].CGColor);
	 CGRect rect = CGRectMake(210, (legendY + 15*counter1) - 1, 100, 12);
	 UIFont* font = [UIFont fontWithName:@"Arial" size:12];
	 [sum.description drawInRect:rect withFont:font];
	 }
	 
	 //Update Counters
	 counter1++;
	 lastDegreeChart1 += degree1;
	 lastDegreeChart2 += degree2;
	 
	 }
	 
	 
	 //Draw Border 1
	 CGContextSetLineWidth(ctx , 5);
	 CGContextSetStrokeColorWithColor(ctx, [UIColor grayColor].CGColor);
	 CGRect borderChart1 = CGRectMake(x - radius, chart1Y - radius, radius*2, radius*2);
	 CGContextStrokeEllipseInRect(ctx, borderChart1);
	 
	 //Draw Border 2
	 CGContextSetLineWidth(ctx , 5);
	 CGContextSetStrokeColorWithColor(ctx, [UIColor grayColor].CGColor);
	 CGRect borderChart2 = CGRectMake(x - radius, chart2Y - radius, radius*2, radius*2);
	 CGContextStrokeEllipseInRect(ctx, borderChart2);
	 
	 //Draw Labels
	 CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
	 CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
	 CGRect label1 = CGRectMake(50, 5, 100, 20);
	 UIFont* font = [UIFont fontWithName:@"Arial" size:15];
	 [NSLocalizedString(@"Planned Effort",@"") drawInRect:label1 withFont:font];
	 CGRect label2 = CGRectMake(55, 205, 100, 20);
	 [NSLocalizedString(@"Actual Effort",@"") drawInRect:label2 withFont:font];
	 
	 [groups release];*/
	
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	int xCentre = x + radius + lineWidth;
	int yCentre = y + radius + lineWidth;
	
	int   counter = 0;
	float lastDegree = 0;
	float sumFigure = 0;
	
	for(MDCChartDataGroup* chartGroup in chartGroups)
		sumFigure = sumFigure + chartGroup.value;
	
	
	if(title != nil){
			//Draw Title
		CGRect   titleRect  = CGRectMake(x, y, self.frame.size.width, 20);
		UILabel* titleLabel = [[UILabel alloc] initWithFrame:titleRect];
		titleLabel.text = title;
		titleLabel.textColor = [UIColor whiteColor];
		titleLabel.textAlignment = UITextAlignmentCenter;
		titleLabel.backgroundColor = [UIColor clearColor];
		[self addSubview:titleLabel];
		
		radius -= 20/2;
		yCentre   += 20/2;
	}
	
	for(MDCChartDataGroup* chartGroup in chartGroups){
		
		CGContextSaveGState(ctx);
		
			//Draw Chart1
		float degree =  ((float)(M_PI * 2) / (float)sumFigure) * (float)chartGroup.value;
		CGContextSetFillColorWithColor(ctx, colors[counter].CGColor);
		CGContextSetLineWidth(ctx, lineWidth);
		CGContextMoveToPoint(ctx, xCentre, yCentre);
		CGContextAddArc(ctx, xCentre, yCentre, radius, lastDegree, lastDegree+degree, 0);
		CGContextClosePath(ctx);
		
		CGContextClip(ctx);
		
		const CGFloat* components = CGColorGetComponents(colors[counter].CGColor);
		NSString *colorAsString = [NSString stringWithFormat:@"%f,%f,%f,%f", components[0], components[1], components[2], components[3]];
		NSLog(@"%@", colorAsString);
		CGFloat gradColor[] = {
			components[0],components[1],components[2],0.9,
				//			components[0],components[1],components[2],0.2,
			components[0],components[1],components[2],0.2 
		};
		
			//Draw Graient
		CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
		CGGradientRef gradi = CGGradientCreateWithColorComponents(space, gradColor, NULL, 2);
		CGPoint startPoint = CGPointMake(xCentre,yCentre);
		//CGPoint endPoint = CGPointMake(xCentre + radius,yCentre + radius );
			//		CGContextDrawLinearGradient(ctx, gradi, startPoint, endPoint, 0);
		
		CGContextDrawRadialGradient(ctx, gradi, startPoint, radius , startPoint, 0, 2);
		
			//CGContextFillPath(ctx);
		
		CGContextRestoreGState(ctx);
		
			//Draw Chart Border
		CGContextSetLineWidth(ctx , 5);
		CGContextSetStrokeColorWithColor(ctx, [UIColor grayColor].CGColor);
		CGRect borderChart1 = CGRectMake(xCentre - radius, yCentre - radius, radius*2, radius*2);
		CGContextStrokeEllipseInRect(ctx, borderChart1);
		
		CGContextSetFillColorWithColor(ctx, colors[counter].CGColor);
		CGRect legend = CGRectMake(227, y + 30 + 15*counter, 10, 10);
		CGContextFillRect(ctx, legend);
		CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
		
		UIFont* font = [UIFont fontWithName:@"Arial" size:11];
		CGRect rect = CGRectMake(239, (y + 30 + 15*counter) - 1, 100, 12);
		[chartGroup.description drawInRect:rect withFont:font];
		
		CGRect rect2 = CGRectMake(225 - [chartGroup.valueLabel sizeWithFont:font].width, (y + 30 + 15*counter) - 1, 100, 12);
		[chartGroup.valueLabel drawInRect:rect2 withFont:font];

			//Update Counters
		counter++;
		lastDegree += degree;
	}
	
	
	
}

- (void)dealloc {
    [super dealloc];
}


@end
