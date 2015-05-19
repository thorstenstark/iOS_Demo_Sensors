//
//  UEGyroViewController.h
//  Demo_Sensors
//
//  Created by Thorsten Stark on 02.07.14.
//  Copyright (c) 2014 Beuth Hochschule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface UEGyroViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *accellXLabel;
@property (weak, nonatomic) IBOutlet UILabel *accellYLabel;
@property (weak, nonatomic) IBOutlet UILabel *accellZLabel;

@property (weak, nonatomic) IBOutlet UILabel *gyroXLabel;
@property (weak, nonatomic) IBOutlet UILabel *gyroYLabel;
@property (weak, nonatomic) IBOutlet UILabel *gyroZLabel;

// Action methods for (de)activating gyro and acellerometer updates
- (IBAction)accellSwitchChanged:(id)sender;
- (IBAction)gyroSwitchChanged:(id)sender;

@end
