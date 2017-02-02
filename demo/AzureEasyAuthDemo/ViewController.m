//
//  ViewController.m
//  AzureEasyAuthDemo
//
//  Created by Shrirang on 2/2/17.
//  Copyright © 2017 Microsoft Corporation. All rights reserved.
//

#import "ViewController.h"
#import "AzureEasyAuth/AzureEasyAuth.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AppDelegate* delegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    
    delegate.loginController = [[MSLoginSafariViewController alloc] initWithBackendUrl:@"https://shrirs-demo.azurewebsites.net"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [delegate.loginController loginWithProvider:@"google" urlScheme:@"demoscheme" parameters:nil controller:self animated:NO completion:^(MSUser * _Nullable user, NSError * _Nullable error) {
            if (user) {
                NSLog(@"User: %@", user.userId);
            } else {
                NSLog(@"Error: %@", [error description]);
            }
        }];
    });
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
