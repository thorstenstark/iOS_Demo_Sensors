//
//  UEMotionViewController.m
//  Demo_Sensors
//
//  Shows how to work with Motion Events from M7/M8 motion coprocessor
//
//  Created by Thorsten Stark on 02.07.14.
//  Copyright (c) 2014 Beuth Hochschule. All rights reserved.
//

#import "UEMotionViewController.h"
#import "UEAppDelegate.h"


@interface UEMotionViewController ()

@end

@implementation UEMotionViewController

CMMotionActivityManager *motionManager;
CMPedometer* pedometer;
CMAltimeter* altimeter;


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

-(void)viewDidAppear:(BOOL)animated{
    [self startMotionUpdates];
    [self startStepCounter];
    [self startAltimeter];
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [pedometer stopPedometerUpdates];
    [motionManager stopActivityUpdates];
}

-(void)startMotionUpdates{
    // Create a CMMotionActivityManager
    motionManager = [[CMMotionActivityManager alloc]init];
    
    // Check whether the accelerometer is available
    if ([CMMotionActivityManager isActivityAvailable]) {

        [motionManager startActivityUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMMotionActivity *activity) {
            //There are 5 types of motion that can be detected
            _unknownLabel.text =    [NSString stringWithFormat:@"%d", activity.unknown];
            _stationaryLabel.text = [NSString stringWithFormat:@"%d", activity.stationary];
            _walkingLabel.text =    [NSString stringWithFormat:@"%d", activity.walking];
            _runningLabel.text =    [NSString stringWithFormat:@"%d", activity.running];
            _drivingLabel.text =    [NSString stringWithFormat:@"%d", activity.automotive];

        }];
    }
}

-(void)startStepCounter{

    //Create the pedometer
    pedometer = [[CMPedometer alloc]init];
    
    if ([CMPedometer isStepCountingAvailable]) {
        
        //start getting Pedometer Updates
        [pedometer startPedometerUpdatesFromDate:[NSDate new] withHandler:^(CMPedometerData *pedometerData, NSError *error) {

            long steps = [pedometerData.numberOfSteps integerValue];
            float distance = [pedometerData.distance floatValue];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                //execute GUI updates on main thread
                [_stepsLabel setText: [NSString stringWithFormat:@"%ld", steps ]];
                _distanceLabel.text = [NSString stringWithFormat:@"%.2f", distance];
            }];
           
        }];
        
    }
}


-(void)startAltimeter{

    // Create the altimeter
    altimeter = [[CMAltimeter alloc]init];
    
    if ([CMAltimeter isRelativeAltitudeAvailable]) {

        [altimeter startRelativeAltitudeUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAltitudeData *altitudeData, NSError *error) {
            //You get the relative altitude and the absolute pressure
            _altitudeLabel.text = [NSString stringWithFormat:@"%.2f", [altitudeData.relativeAltitude floatValue]];
            _pressureLabel.text = [NSString stringWithFormat:@"%.2f", [altitudeData.pressure floatValue]];
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
