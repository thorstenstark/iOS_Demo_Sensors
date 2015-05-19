//
//  UEAppDelegate.h
//  Demo_Sensors
//
//  Created by Thorsten Stark on 01.07.14.
//  Copyright (c) 2014 Beuth Hochschule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface UEAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) CMMotionManager* motionManager;

@end
