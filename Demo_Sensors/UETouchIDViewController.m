//
//  UETouchIDViewController.m
//  Demo_Sensors
//
//  Demonstrates the use of TouchID authentification if available
//
//  Created by Thorsten Stark on 28.10.14.
//  Copyright (c) 2014 Beuth Hochschule. All rights reserved.
//

#import "UETouchIDViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface UETouchIDViewController ()

@end

@implementation UETouchIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)authenticateUser:(id)sender {
    //We need this authorization context
    LAContext *context = [[LAContext alloc] init];
    
    NSError *error = nil;
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        //Yippie, the device does support TouchID

        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:@"Are you the device owner?" // Why you want the user to authenticate
                          reply:^(BOOL success, NSError *error) {

                              [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                  
                                  
                                  if (success) {
                                      // user is authorized – tell him the good news
                                      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                                                      message:@"You are the device owner!"
                                                                                     delegate:nil
                                                                            cancelButtonTitle:@"Ok"
                                                                            otherButtonTitles:nil];
                                      [alert show];
                                      
                                  } else {
                                      // something went wrong... may have different reasons:
                                      NSString* cancelReason = @"You are not the device owner.";
                                      if (error) {
                                          switch (error.code) {
                                              case LAErrorAuthenticationFailed:
                                                  cancelReason = @"Authentication Failed";
                                                  break;
                                              case LAErrorUserCancel:
                                                  cancelReason = @"Authentication canceld by user";
                                                  break;
                                              case LAErrorUserFallback:
                                                  cancelReason = @"Fallback to Passcode";
                                                  break;
                                              case LAErrorSystemCancel:
                                                  cancelReason = @"System Canceld";
                                                  break;
                                              case LAErrorTouchIDNotAvailable:
                                                  cancelReason = @"TouchID not available";
                                                  break;
                                              case LAErrorTouchIDNotEnrolled:
                                                  cancelReason = @"TouchID not enrolled";
                                                  break;
                                                  
                                              default:
                                                  cancelReason = @"unknown";
                                                  break;
                                          }
                                      }
                                      // user is not authorized – explain what went wrong
                                      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                      message:cancelReason
                                                                                     delegate:nil
                                                                            cancelButtonTitle:@"Ok"
                                                                            otherButtonTitles:nil];
                                      [alert show];
                                  }
                              }];
                              
                          }];
        
    } else {
        //The device doesn't support TouchID
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Your device cannot authenticate using TouchID."
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
}
@end
