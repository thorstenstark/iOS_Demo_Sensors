//
//  UELocationViewController.h
//  Demo_Sensors
//
//  Created by Thorsten Stark on 01.07.14.
//  Copyright (c) 2014 Beuth Hochschule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface UELocationViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *outputLabel;
@property (weak, nonatomic) IBOutlet UILabel *magneticLabel;
@property (weak, nonatomic) IBOutlet UILabel *trueLabel;
@property (weak, nonatomic) IBOutlet UILabel *latLabel;
@property (weak, nonatomic) IBOutlet UILabel *longLabel;
@property (weak, nonatomic) IBOutlet UILabel *accurrLabel;
@end
