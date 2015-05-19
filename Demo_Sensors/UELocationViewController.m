//
//  UELocationViewController.m
//  Demo_Sensors
//
//  Showa how to get location data and device heading
//
//  Created by Thorsten Stark on 01.07.14.
//  Copyright (c) 2014 Beuth Hochschule. All rights reserved.
//

#import "UELocationViewController.h"

@interface UELocationViewController ()

@property (nonatomic, strong) CLLocationManager* locationManager; //you should have only one locationmanager in your project

@end


@implementation UELocationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [self startLocationTracking];
    [self startHeadingTracking];
}

-(void)viewDidDisappear:(BOOL)animated{
    [self.locationManager stopUpdatingHeading];
    [self.locationManager stopUpdatingLocation];
}

// Where am i?
-(void)startLocationTracking{
    // Create the location manager if this object does not
    // already have one.
    if (!self.locationManager){
        self.locationManager = [[CLLocationManager alloc] init];
        
    }
    //Since iOS8 you have to ask the user for permission to track his location
    //Don't forget to set NSLocationWhenInUseUsageDescription key in info.plist!
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    self.locationManager.delegate = self;
    
    //How accurate should the location be?
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // Set a movement threshold for new events.
    self.locationManager.distanceFilter = 5; // meters
    
    [self.locationManager startUpdatingLocation];
}

// Where am I looking at?
-(void)startHeadingTracking{
    [self.locationManager startUpdatingHeading];
}

#pragma mark - CLLocationManagerDelegate

//Called for updated locations
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    self.outputLabel.text = [NSString stringWithFormat:@"%f, %f", manager.location.coordinate.longitude, manager.location.coordinate.latitude ];
}

//called for updated heading
-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    self.magneticLabel.text =   [NSString stringWithFormat:@"%f", newHeading.magneticHeading];
    self.trueLabel.text =       [NSString stringWithFormat:@"%f", newHeading.trueHeading];
    self.longLabel.text =       [NSString stringWithFormat:@"%f", manager.location.coordinate.longitude];
    self.latLabel.text =        [NSString stringWithFormat:@"%f", manager.location.coordinate.latitude];
    self.accurrLabel.text =     [NSString stringWithFormat:@"%f", manager.location.horizontalAccuracy];
}

//Maybe something goes wrong...
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@", error);
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.locationManager stopUpdatingHeading];
    [self.locationManager stopUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
