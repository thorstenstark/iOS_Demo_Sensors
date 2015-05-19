//
//  UEGyroViewController.m
//  Demo_Sensors
//
//  Shows how to get Data from Accelerometer and Gyro
//
//  Created by Thorsten Stark on 02.07.14.
//  Copyright (c) 2014 Beuth Hochschule. All rights reserved.
//

#import "UEGyroViewController.h"
#import "UEAppDelegate.h"

@interface UEGyroViewController ()

@end

@implementation UEGyroViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Accelerometer

-(void)startAccellerometerUpdates{
    // Get the CMMotionManager
    CMMotionManager *motionManager = [(UEAppDelegate*)[[UIApplication sharedApplication] delegate] motionManager];
    
    // Check whether the accelerometer is available
    if ([motionManager isAccelerometerAvailable] == YES) {
        // Assign the update interval to the motion manager
        NSTimeInterval updateInterval = .2;
        [motionManager setAccelerometerUpdateInterval:updateInterval];
        
        // Start asking for Accelerometer data
        [motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
            _accellXLabel.text = [NSString stringWithFormat:@"%f", accelerometerData.acceleration.x];
            _accellYLabel.text = [NSString stringWithFormat:@"%f", accelerometerData.acceleration.y];
            _accellZLabel.text = [NSString stringWithFormat:@"%f", accelerometerData.acceleration.z];
           
        }];
    }
}

-(void)stopAccellerometerUpdates{
    CMMotionManager *motionManager = [(UEAppDelegate*)[[UIApplication sharedApplication] delegate] motionManager];
    [motionManager stopAccelerometerUpdates];
}


#pragma mark - Gyrometer

-(void)startGyrometerUpdates{
    // Create a CMMotionManager
    CMMotionManager *motionManager = [(UEAppDelegate*)[[UIApplication sharedApplication] delegate] motionManager];
    
    // Check whether the accelerometer is available
    if ([motionManager isGyroAvailable] == YES) {
        // Assign the update interval to the motion manager
        NSTimeInterval updateInterval = .2;
        [motionManager setGyroUpdateInterval:updateInterval];
        
        // Start asking for gyro events
        [motionManager startGyroUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMGyroData *gyroData, NSError *error) {
            _gyroXLabel.text = [NSString stringWithFormat:@"%f", gyroData.rotationRate.x];
            _gyroYLabel.text = [NSString stringWithFormat:@"%f", gyroData.rotationRate.y];
            _gyroZLabel.text = [NSString stringWithFormat:@"%f", gyroData.rotationRate.z];
        }];
        
    }
}

-(void)stopGyrometerUpdates{
    CMMotionManager *motionManager = [(UEAppDelegate*)[[UIApplication sharedApplication] delegate] motionManager];
    [motionManager stopGyroUpdates];
}


#pragma mark - EventHandler

//Switch acellerometer updates on/off
- (IBAction)accellSwitchChanged:(id)sender {
    UISwitch* mySwitch = (UISwitch*)sender;
    if (mySwitch.on) {
        [self startAccellerometerUpdates];
    }else{
        [self stopAccellerometerUpdates];
    }
}

//Switch gyro updates on/off
- (IBAction)gyroSwitchChanged:(id)sender {
    UISwitch* mySwitch = (UISwitch*)sender;
    if (mySwitch.on) {
        [self startGyrometerUpdates];
    }else{
        [self stopGyrometerUpdates];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
