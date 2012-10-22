//
//  Start.m
//  Evaluator
//
//  Created by Joseph caxton-Idowu on 31/10/2010.
//  Copyright 2010 caxtonidowu. All rights reserved.
//

#import "Start.h"


@implementation Start

@synthesize FirstView, SecondView,FirstTable,SecondTable,QuestionPickerView,CustomDataSource,Sound,ShowAnswers,logoView,Copyright,WebText,StartPractice,iPhone5;


#define SCREEN_WIDTH 320
#define SCREEN_HEIGHT 460
#define _TransitionDuration	0.45

- (void)viewDidLoad {
    [super viewDidLoad];
	
    EvaluatorAppDelegate *appDelegate = (EvaluatorAppDelegate *)[UIApplication sharedApplication].delegate;
    if([appDelegate IsThisiPhone5] == YES){
        
        iPhone5 = YES;
    }
    else
    {
        iPhone5 = NO;
    }

       
	
	// First View and Children
	CGRect FirstViewframe = CGRectMake(0 ,0, SCREEN_WIDTH, SCREEN_HEIGHT);
	self.FirstView = [[UIView alloc] initWithFrame:FirstViewframe];
	[self.view addSubview:FirstView];
	[self PageButton:1];
	
	self.FirstTable = [[UITableView alloc] initWithFrame:FirstViewframe style:UITableViewStyleGrouped];
	FirstTable.delegate = self;
	FirstTable.dataSource = self;
	FirstTable.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    FirstTable.backgroundColor = [UIColor clearColor];
    FirstTable.opaque = NO;
    FirstTable.backgroundView = nil;
    NSString *BackImagePath = [[NSBundle mainBundle] pathForResource:@"back320x450" ofType:@"png"];
	UIImage *BackImage = [[UIImage alloc] initWithContentsOfFile:BackImagePath];
    FirstTable.backgroundColor = [UIColor colorWithPatternImage:BackImage];
	FirstTable.tag = 1;
	[self.FirstView addSubview:FirstTable];
		
	
	// Second View and Children --- don't add to subview yet
	CGRect SecondFrame = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT);
	self.SecondView = [[UIView alloc] initWithFrame:SecondFrame];
    self.SecondView.backgroundColor = [UIColor colorWithPatternImage:BackImage];
    QuestionPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,162)]; //90
	CustomDataSource = [[CustomPickerDataSource_Num_Questions alloc] init];
    CGRect SecondTableframe;
    if(iPhone5){
        
        SecondTableframe = CGRectMake(10 ,200, SCREEN_WIDTH - 20, 230);
    }
    else{
        SecondTableframe = CGRectMake(10 ,155, SCREEN_WIDTH - 20, 210);
    }
   
    self.SecondTable = [[UITableView alloc] initWithFrame:SecondTableframe style:UITableViewStyleGrouped];
    

	
    [BackImage release];

	//Navigation Bar
    
    //UINavigationController *nav =self.navigationController;
    //nav.navigationBar.tintColor = [UIColor blackColor];
    NSString *HeaderLocation = [[NSBundle mainBundle] pathForResource:@"header_bar" ofType:@"png"];
    UIImage *HeaderBackImage = [[UIImage alloc] initWithContentsOfFile:HeaderLocation];
   [self.navigationController.navigationBar setBackgroundImage:HeaderBackImage forBarMetrics:UIBarMetricsDefault];
    //self.navigationItem.title = @"LearnersCloud";
    [HeaderBackImage release];
	
	
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[FirstTable reloadData];
	[SecondTable reloadData];
    if(CustomDataSource != nil){ // this is the refresh the QuestionPicker after user purchase
        
        [CustomDataSource release];
        CustomDataSource = [[CustomPickerDataSource_Num_Questions alloc] init];
        QuestionPickerView.delegate = CustomDataSource;
        QuestionPickerView.dataSource = CustomDataSource;
        EvaluatorAppDelegate *appDelegate = (EvaluatorAppDelegate *)[UIApplication sharedApplication].delegate;
        if (appDelegate.NumberOfQuestions == [NSNumber numberWithInt:1]) {
            appDelegate.NumberOfQuestions =[NSNumber numberWithInt:1];
            [QuestionPickerView selectRow:0 inComponent:1 animated:YES];  // sets the default on the PickerView to 10
        }
        else
        {
            int NumberofQ = appDelegate.NumberOfQuestions.intValue - 1;
            [QuestionPickerView selectRow:NumberofQ inComponent:1 animated:YES];
        
        }
        
        
    }
    
	//[self willAnimateRotationToInterfaceOrientation:self.interfaceOrientation duration:1];
    
    // Lets ask for review after user has viewed videos 5 times
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *ReviewID = [prefs stringForKey:@"Review"];
    NSString *IhaveReviewed = [prefs stringForKey:@"IHaveLeftReview"];
	NSString *MyAccessLevel = [prefs stringForKey:@"AccessLevel"];
    NSInteger AccessLevel = [MyAccessLevel intValue];
    // Note we only want those who have brought to review. Those looking for free talk non-sense.  AccessLevel > 1
    if ([ReviewID isEqualToString:@"5"] && [IhaveReviewed isEqualToString:@"0"] &&  AccessLevel > 1 ) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Review this app" message:@"Do you like this app enough to leave us a review?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
        
	}
    else {
        
        NSInteger Counter = [ReviewID integerValue];
        NSInteger CounterPlus = Counter + 1;
        NSString *ID = [NSString stringWithFormat:@"%d",CounterPlus];
        [prefs setObject:ID  forKey:@"Review"];
        [prefs synchronize];
        
    }

}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration{
	
if ([self.FirstView superview]) {
		
	
	
	if (interfaceOrientation == UIInterfaceOrientationPortrait ) {
		
		FirstView.frame = CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT);
		FirstTable.frame = CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT);
		
		
		//Copyright.frame = CGRectMake(55,20,240,40);
        if(iPhone5){
            logoView.frame = CGRectMake(45.0,105.0,230,153);
            WebText.frame = CGRectMake(80,380,200,40);
            StartPractice.frame = CGRectMake(35, 300, 250, 47);
        }
        else
        {
          logoView.frame = CGRectMake(45.0,85.0,230,153);
           WebText.frame = CGRectMake(80,300,200,40);
           StartPractice.frame = CGRectMake(35, 250, 250, 47);
        }
		
		
		
	}
	
	else {
		
		
		
		FirstView.frame = CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH);
		FirstTable.frame = CGRectMake(0, 0, 480, SCREEN_WIDTH);
		logoView.frame = CGRectMake(100.0,0.0,280,200);
		
		//Copyright.frame = CGRectMake(120,20,280,40);
		WebText.frame = CGRectMake(150,10,200,20);
		StartPractice.frame = CGRectMake(110, 190, 250, 34);
			}
		
}
	else {
		if (interfaceOrientation == UIInterfaceOrientationPortrait) {
			
			self.SecondView.frame = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT);
            if(iPhone5){
                self.SecondTable.frame = CGRectMake(10 ,200, SCREEN_WIDTH - 20, 230);
            }
            else{
                self.SecondTable.frame = CGRectMake(10 ,155, SCREEN_WIDTH - 20, 210);
            }
			
			QuestionPickerView.frame = CGRectMake(0,0,SCREEN_WIDTH,162);//90
			self.Sound.frame =  CGRectMake(200.0, 0.5, 40.0, 45.0);
			ShowAnswers.frame = CGRectMake(200.0, 0.5, 40.0, 45.0);
		}
		
		else {
			
			self.SecondView.frame = CGRectMake(0,0, 480, SCREEN_HEIGHT);
			self.SecondTable.frame = CGRectMake(0 ,160, 480, SCREEN_WIDTH);
			QuestionPickerView.frame = CGRectMake(0,0,480,160);
			self.Sound.frame = CGRectMake(350.0, 10.0, 40.0, 45.0);
			ShowAnswers.frame = CGRectMake(350.0, 10.0, 40.0, 45.0);
		}

	}


	
	
	
}

/*-(void)CheckOrientation{
	
	[self willAnimateRotationToInterfaceOrientation:self.interfaceOrientation duration:1];
	
	UIInterfaceOrientation interfaceOrientation = [[UIDevice currentDevice] orientation];
	 
	 
	 if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft){
	 
	 logoView.frame = CGRectMake(200.0,0.0,550,600);
	 Copyright.frame = CGRectMake(400,40,320,40);
	 WebText.frame = CGRectMake(450,20,200,20);
	 
	 }
	
}  */


-(IBAction)Practice:(id)sender{
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:_TransitionDuration];
	
	[UIView setAnimationTransition:([self.FirstView superview] ?
									UIViewAnimationTransitionFlipFromRight : UIViewAnimationTransitionFlipFromLeft)
						   forView:self.view cache:YES];
	if ([self.SecondView superview])
	{
		[self.SecondView removeFromSuperview];
		[self.view addSubview:FirstView];
		self.navigationItem.title  = @"";
		[self PageButton:1];
	}
	else
	{
		
		
		[self.FirstView removeFromSuperview];
		[self.view addSubview:SecondView];
		
		
		
		//QuestionPickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		if(CustomDataSource != nil){
            
            [CustomDataSource release];
            CustomDataSource = [[CustomPickerDataSource_Num_Questions alloc] init];
            QuestionPickerView.dataSource = CustomDataSource;
        }
		
		QuestionPickerView.delegate = CustomDataSource;
		QuestionPickerView.showsSelectionIndicator = YES;
        
		[SecondView  addSubview:QuestionPickerView];
         
		
		
		//Add Second Table
		
		
		SecondTable.delegate = self;
		SecondTable.dataSource = self;
		
		SecondTable.tag = 2;
		[self.SecondView addSubview:SecondTable];
		
			
		self.navigationItem.title  =  @"Customise";  //@"Search Engine";
		[self PageButton:2];
	}
	
	[UIView commitAnimations];
	//[self willAnimateRotationToInterfaceOrientation:self.interfaceOrientation duration:1];
	
	
	
	
}

-(IBAction)StartTest:(id)sender{
	
	NSString *AccessLevel = (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"AccessLevel"];
	
	if([AccessLevel intValue] == 2){
		
		NSString *message = [[NSString alloc] initWithFormat:@"You are using the free version of the app. The app will only deliver a maximum of 250 questions depending on your search criteria and does not necessarily have all types of questions."];
		
		UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Important Notice"
													   message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		[alert show];
		[message release];
		[alert release];
	}
	
	
	
	
	ClientEngine *ce_view = [[ClientEngine alloc] initWithStyle:UITableViewStyleGrouped];

	[self.navigationController pushViewController:ce_view animated:YES];
	[ce_view release];
	
	
}

- (void)switchAction:(UISwitch*)sender{
	
	
	if (sender.tag == 1){
		
		[[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:@"PlaySound"];
	}
	else {
		
		[[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:@"ShowMyAnswers"];
		
	}
	
	
	
}

-(void)PageButton:(int)sender{
	
	if (sender==1) {
		
		UIBarButtonItem *Practice = [[UIBarButtonItem alloc] initWithTitle:@"Practice Questions" style:UIBarButtonItemStylePlain target:self action:@selector(Practice:)];
		self.navigationItem.rightBarButtonItem = Practice;
		[Practice release];
		self.navigationItem.leftBarButtonItem = nil;
		
		EvaluatorAppDelegate *appDelegate = (EvaluatorAppDelegate *)[UIApplication sharedApplication].delegate;
		BOOL PlaySound = [[NSUserDefaults standardUserDefaults] boolForKey:@"PlaySound"];
		if (PlaySound == YES) {
			
			[appDelegate PlaySound:@"ArrowWoodImpact"];
			
		}
		
		
	}else {
		
		UIBarButtonItem *Back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(Practice:)];
		self.navigationItem.leftBarButtonItem = Back;
		[Back release];
		
		
		UIBarButtonItem *StartTest = [[UIBarButtonItem alloc] initWithTitle:@"Start Test" style:UIBarButtonItemStylePlain target:self action:@selector(StartTest:)];
		self.navigationItem.rightBarButtonItem = StartTest;
		[StartTest release];
		
		EvaluatorAppDelegate *appDelegate = (EvaluatorAppDelegate *)[UIApplication sharedApplication].delegate;
		BOOL PlaySound = [[NSUserDefaults standardUserDefaults] boolForKey:@"PlaySound"];
		if (PlaySound == YES) {
			
			[appDelegate PlaySound:@"ArrowWoodImpact"];
			
		}
		
		
		
	}
	
	
}
// For ios 6
-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;

    
}

// for ios 5
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return  (interfaceOrientation == UIInterfaceOrientationPortrait);
	
}


#pragma mark -
#pragma mark Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if(tableView.tag == 1){
		
	return 1;
	}
	else {
		return 1;
	}

}



/*- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	NSString *title=@""; 
	
	if (section== 0 && tableView.tag == 1) {
		
		NSString *AccessLevel = (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"AccessLevel"];
		
		if([AccessLevel intValue] == 1){
			
			title = @"GCSE Mathematics Free Version";
		}
		else if ([AccessLevel intValue] == 2){
			
			title = @"GCSE Mathematics 250 Questions";
			
		}
		else if ([AccessLevel intValue] == 3){
			
			title = @"GCSE Mathematics 500 Questions";
			
		}
		else if ([AccessLevel intValue] == 4){
			
			title = @"GCSE Mathematics 750 Questions";
			
		}
		else if ([AccessLevel intValue] == 5){
			
			title = @"GCSE Mathematics 1000 Questions";
			
		}
		else if ([AccessLevel intValue] == 6){
			
			title = @"GCSE Mathematics 1250 Questions";
			
		}
        else if ([AccessLevel intValue] == 7){
			
			title = @"GCSE Mathematics 1500 Questions";
			
		}
        else if ([AccessLevel intValue] == 8){
			
			title = @"GCSE Mathematics 1600 Questions";
			
		}



		
		
		
	}
	
	
	else if (tableView.tag == 2 && section == 0){
		title =@"";
		
	}
	
	
	
	return title; 
	
	
	
} */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
	NSInteger count = 1;
	
	if (tableView.tag == 1){
	
        
	
	}
	
	else {
		count = 5;
	}

	 
	
	return count; 
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
		if (indexPath.section == 0) {
			return 340;
		}
		else {
			return 40;
		}
	}
	else {
		
		return 40;
	}

	
	




}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
	 
    
	
	if (tableView.tag == 1) {
            
			tableView.allowsSelection = NO;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView.separatorColor = [UIColor clearColor];
            [cell setBackgroundColor:[UIColor clearColor]];
			//if (indexPath.section == 0) {
        
            UIView *headerView = [[UIView alloc] init];
        
            NSString *HeaderImagePath = [[NSBundle mainBundle] pathForResource:@"EQ_maths_160x78" ofType:@"png"];
            UIImage *HeaderImage = [[UIImage alloc] initWithContentsOfFile:HeaderImagePath];
            UIImageView *HeaderImageView = [[UIImageView alloc] initWithImage:HeaderImage];
            HeaderImageView.frame = CGRectMake(80, 0.0, 160, 78);
            HeaderImageView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
            [headerView addSubview:HeaderImageView];
            [cell addSubview:headerView];
            [headerView release];
            [HeaderImage release];
            [HeaderImageView release];

				
				if (logoView == nil) {
		
					NSString *LogoPath = [[NSBundle mainBundle] pathForResource:@"hero_230x153" ofType:@"png"];
	
					UIImage *LogoImage = [[UIImage alloc] initWithContentsOfFile:LogoPath];
					logoView = [[UIImageView alloc] initWithImage:LogoImage];
                    if (iPhone5){
                        
                        logoView.frame = CGRectMake(45.0,105.0,230,153);
                        
                    }
                    else{
                        
                        logoView.frame = CGRectMake(45.0,85.0,230,153);
                    }

					
                    
                   
					
					[cell addSubview:logoView];
					[LogoImage release];
					[logoView release];
				
                    NSString *StartImageLocation = [[NSBundle mainBundle] pathForResource:@"start_practice" ofType:@"png"];
                    
					UIImage *StartImage = [[UIImage alloc] initWithContentsOfFile:StartImageLocation];
                    
                
				StartPractice = [UIButton buttonWithType:UIButtonTypeRoundedRect];
				[StartPractice setImage:StartImage forState:UIControlStateNormal];
				
                    if (iPhone5){
                        
                        StartPractice.frame = CGRectMake(35, 300, 250, 47);
                        
                    }
                    else{
                        
                        StartPractice.frame = CGRectMake(35, 250, 250, 47);
                    }

				
				[StartPractice addTarget:self action:@selector(Practice:) forControlEvents:UIControlEventTouchUpInside];
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
				[cell addSubview:StartPractice];
				}
		
			//}
			//	else if (indexPath.section == 1) {
			
					//if (Copyright == nil) {
//		
//					Copyright = [[UILabel alloc] initWithFrame:CGRectMake(55,20,240,40)];
//					Copyright.font= [UIFont systemFontOfSize:8.0];
//					Copyright.textColor = [UIColor blueColor];
//					Copyright.text = @"Registered Trademark Owner Theta Computer Services \u00AE 2010";
//					
//					[cell addSubview:Copyright];
//					
//					[Copyright release];
					
					if (WebText == nil) {
						
                        if (iPhone5){
                            
                            WebText = [[UITextView alloc] initWithFrame:CGRectMake(80,380.0,200,40)];
                        
                        }
                        else{
                            
                            WebText = [[UITextView alloc] initWithFrame:CGRectMake(80,300.0,200,40)];
                        }
                    WebText.textColor = [UIColor whiteColor];
                    WebText.backgroundColor =[UIColor clearColor];
                    WebText.editable = NO;
					NSString *Website = @"www.LearnersCloud.com";
					WebText.text = Website;
					[cell addSubview:WebText];
					[WebText release];
					//[self CheckOrientation];
					}

				//}
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
		
	}
	else {
            //tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
            [tableView setBackgroundView:nil];
          [cell setBackgroundColor:[UIColor whiteColor]];
			EvaluatorAppDelegate *appDelegate = (EvaluatorAppDelegate *)[UIApplication sharedApplication].delegate;	
		switch (indexPath.row) {
				case 0:
					//cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
					cell.textLabel.text = @"Difficulty";
					cell.detailTextLabel.text = appDelegate.Difficulty;
					break;
				case 1:
					//cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
					cell.textLabel.text = @"Topic";
					cell.detailTextLabel.text = appDelegate.Topic;
					break;
					
				case 2:
					//cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
					cell.textLabel.text = @"Type of question";
					cell.detailTextLabel.text = appDelegate.TypeOfQuestion;
					break;
				
				case 3:
						if (Sound == nil) {
							
							Sound =[[UISwitch alloc] initWithFrame:CGRectMake(200.0, 0.5, 40.0, 30.0)];
							
						}
										
					cell.selectionStyle = UITableViewCellSelectionStyleNone;
				    cell.textLabel.text = @"Sound";
				  
				   BOOL PlaySound = [[NSUserDefaults standardUserDefaults] boolForKey:@"PlaySound"];
					
					if (PlaySound ==YES) {
					
						Sound.on = YES;
					}
					else {
						Sound.on = NO;
					}
				Sound.tag = 1;
					[Sound addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
					[cell.contentView addSubview:Sound];
					break;
					
			case 4:
				
				
					
					if (ShowAnswers == nil) {
						
						ShowAnswers =[[UISwitch alloc] initWithFrame:CGRectMake(200.0, 0.5, 40.0, 30.0)];
					}				
				
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
				cell.textLabel.text = @"Show answers";
				
				BOOL ShowMyAnswers = [[NSUserDefaults standardUserDefaults] boolForKey:@"ShowMyAnswers"];
				
				if (ShowMyAnswers ==YES) {
					
					ShowAnswers.on = YES;
				}
				else {
					ShowAnswers.on = NO;
				}
				ShowAnswers.tag = 2;
				[ShowAnswers addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
				[cell.contentView addSubview:ShowAnswers];
				
				break;
				
				
				
			}
		
		
		
	}

	
	//[self willAnimateRotationToInterfaceOrientation:self.interfaceOrientation duration:1];
	
	return cell;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (indexPath.row == 0) {
		SelectDifficulty *Difficulty_view = [[SelectDifficulty alloc]initWithNibName:nil bundle:nil];
		Difficulty_view.UserConfigure =  YES;
		[self.navigationController pushViewController:Difficulty_view animated:YES];
		[Difficulty_view release];
		
		
	}
	else if(indexPath.row == 1) {
		
		SelectTopic *Topic_view  =[[SelectTopic alloc] initWithNibName:nil bundle:nil];
		Topic_view.UserConfigure = YES;
		[self.navigationController pushViewController:Topic_view animated:YES];
		[Topic_view release];
		
	}
	
	else if(indexPath.row == 2){
		
		SelectQuestionTemplate *QT_view = [[SelectQuestionTemplate alloc] initWithNibName:nil bundle:nil];
		QT_view.UserConfigure = YES;
		[self.navigationController pushViewController:QT_view animated:YES];
		[QT_view release];
		
	}
	
}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
	
		
	
	
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1){
        
        [self reviewPressed];
        
    }
    else {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *ReviewID = [prefs stringForKey:@"Review"];
        NSInteger Counter = [ReviewID integerValue];
        NSInteger CounterPlus = Counter + 1;
        NSString *ID = [NSString stringWithFormat:@"%d",CounterPlus];
        [prefs setObject:ID  forKey:@"Review"];
        [prefs synchronize];
        
    }

    
}

- (void)reviewPressed {
    
    //Set user has reviewed.
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *ID = @"1";
    [prefs setObject:ID forKey:@"IHaveLeftReview"];
    
    [prefs synchronize];
    
    // Report to  analytics
    NSError *error;
    if (![[GANTracker sharedTracker] trackEvent:@"User Sent to Review Maths Question iPhone at app store"
                                         action:@"User Sent to Review Maths Question iPhone at app store"
                                          label:@"User Sent to Review Maths Question iPhone at app store"
                                          value:1
                                      withError:&error]) {
        NSLog(@"error in trackEvent");
    }
    
    
    NSString *str = @"https://userpub.itunes.apple.com/WebObjects/MZUserPublishing.woa/wa/addUserReview?id=457831288&type=Purple+Software"; 
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}





- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	//FirstView = nil;
//	FirstTable = nil;
//	SecondView = nil;
//	SecondTable = nil;
//	QuestionPickerView = nil;
//	CustomDataSource = nil;
//	Sound = nil;
	
	
}


- (void)dealloc {
    [FirstView release];
	[FirstTable release];
	[SecondView release];
	[SecondTable release];
	[QuestionPickerView release];
	[CustomDataSource release];
	[Sound release];
	[ShowAnswers release];
	//[logoView release];
    [super dealloc];
}


@end
