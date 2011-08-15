//
//  LearnersCloudSamplesVideos.h
//  EvaluatorForIPad
//
//  Created by Joseph caxton-Idowu on 21/02/2011.
//  Copyright 2011 caxtonidowu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCSEEnglishAppDelegate.h"

@interface LearnersCloudSamplesVideos : UITableViewController {

	NSMutableArray *listofItems;
	NSMutableArray *ImageNames;
	
}

@property (nonatomic, retain) NSMutableArray *listofItems;
@property (nonatomic, retain) NSMutableArray *ImageNames;

//- (NSString*)GetFilesFromURL;


@end
