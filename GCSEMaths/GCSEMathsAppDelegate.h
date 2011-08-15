//
//  GCSEMathsAppDelegate.h
//  GCSEMaths
//
//  Created by Joseph caxton-Idowu on 15/08/2011.
//  Copyright 2011 caxtonidowu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCSEMathsAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
