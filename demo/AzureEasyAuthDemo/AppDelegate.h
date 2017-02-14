//
//  AppDelegate.h
//  AzureEasyAuthDemo
//
//  Created by Shrirang on 2/2/17.
//  Copyright © 2017 Microsoft Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AzureEasyAuth/AzureEasyAuth.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MSLoginSafariViewController* loginController;

@end

