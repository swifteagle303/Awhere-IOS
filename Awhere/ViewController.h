//
//  ViewController.h
//  Awhere
//
//  Created by Blain VanNice on 4/11/15.
//  Copyright (c) 2015 Blain VanNice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

float Longitude;
float Latitude;
float currLat;
float currLong;
float currTrueH;
float stepLat;
float stepLong;

float magHeading;
float trueHeading; 


@interface ViewController : UIViewController <CLLocationManagerDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *imageview1;
@property (weak, nonatomic) IBOutlet UIImageView *background;

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet UILabel *latLable;

-(IBAction)getCurrentLocation:(id)sender;

-(IBAction)getWhatsHere:(id)sender;


@end

