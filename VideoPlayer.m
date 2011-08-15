    //
//  VideoPlayer.m
//  EvaluatorForIPad
//
//  Created by Joseph caxton-Idowu on 21/02/2011.
//  Copyright 2011 caxtonidowu. All rights reserved.
//

#import "VideoPlayer.h"


@implementation VideoPlayer

@synthesize VideoFileName;

#define SCREEN_WIDTH 320
#define SCREEN_HEIGHT 370

- (void)moviePlaybackComplete:(NSNotification *)notification  {  
	
	moviePlayerController = [notification object];  
	[[NSNotificationCenter defaultCenter] removeObserver:self  
													name:MPMoviePlayerPlaybackDidFinishNotification  
												  object:moviePlayerController];  
	
	[moviePlayerController.view removeFromSuperview];  
	[moviePlayerController release]; 
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	[self.navigationController popViewControllerAnimated:YES];
	
	
}  


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	
}

-(void)viewWillAppear:(BOOL)animated{
	
	UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BlackBackGround_Iphone.png"]];
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];
    [backgroundImage release];

    
	NSString *filepath   =   [[NSBundle mainBundle] pathForResource:VideoFileName ofType:@"m4v"];
	
	NSURL    *fileURL    =   [NSURL fileURLWithPath:filepath]; 
	
	moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:fileURL];
	
	
	[[NSNotificationCenter defaultCenter] addObserver:self  
											 selector:@selector(moviePlaybackComplete:)  
												 name:MPMoviePlayerPlaybackDidFinishNotification  
											   object:moviePlayerController];
	
	
	moviePlayerController.controlStyle = MPMovieControlStyleFullscreen;
	[moviePlayerController.backgroundView setBackgroundColor:[UIColor blackColor]];
	[self.navigationController setNavigationBarHidden:YES animated:YES];
	
	[self.view addSubview:moviePlayerController.view];
	
	[self willAnimateRotationToInterfaceOrientation:self.interfaceOrientation duration:1];
	//moviePlayerController.fullscreen = YES;
	//moviePlayerController.scalingMode = MPMovieScalingModeAspectFill;
	//[self willAnimateRotationToInterfaceOrientation:self.interfaceOrientation duration:1];
	[moviePlayerController play];  
	
	
}


- (void)viewWillDisappear:(BOOL)animated {
	
	[moviePlayerController stop];
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
     return YES;
	
	//return  (interfaceOrientation != UIInterfaceOrientationPortrait );
	
	
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration{
	
	if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
		
		[moviePlayerController.view setFrame:CGRectMake(0, -10, SCREEN_WIDTH, SCREEN_HEIGHT + 120)];
		
	
	}
	
	else {
		
		[moviePlayerController.view setFrame:CGRectMake(0, -30, SCREEN_HEIGHT + 110, SCREEN_WIDTH + 49 )];
		
		
	}
	
	
	
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	
	[VideoFileName release];
    [super dealloc];
}


@end
