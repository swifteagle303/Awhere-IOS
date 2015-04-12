//
//  ViewController.m
//  Awhere
//
//  Created by Blain VanNice on 4/11/15.
//  Copyright (c) 2015 Blain VanNice. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
CLLocationManager * LocationManager;
- (void)viewDidLoad {
    [super viewDidLoad];
    LocationManager = [[CLLocationManager alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingHeading];
    [self.locationManager startUpdatingLocation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction)getCurrentLocation:(id)sender
{
    LocationManager.delegate = self;
    LocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [LocationManager startUpdatingLocation];
    
    NSLog(@"WELCOME TO THE THUNDERDOME");
    
    _latLable.text = [NSString stringWithFormat:@"DUDE"];

}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"failed to get location" delegate: nil cancelButtonTitle:@"ok"otherButtonTitles: nil];
    
    [errorAlert show];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil){
        Longitude = currentLocation.coordinate.longitude;
        Latitude = currentLocation.coordinate.latitude;
        _latLable.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }
}

-(void)locationManager2:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    magHeading = newHeading.magneticHeading;
    NSLog(@"%.2f", magHeading);
    trueHeading = newHeading.trueHeading;
    Longitude = self.locationManager.location.coordinate.longitude;
    Latitude = self.locationManager.location.coordinate.latitude;
}

-(void)displayError:(NSError*)error
{
    dispatch_async(dispatch_get_main_queue(),^{
        NSString *message;
        switch ([error code])
        {
            case kCLErrorGeocodeFoundNoResult: message = @"kCLErrorGeocodeFoundNoResult";
                break;
            case kCLErrorGeocodeCanceled: message = @"kCLErrorGeocodeCanceled";
                break;
            case kCLErrorGeocodeFoundPartialResult: message = @"kCLErrorGeocodeFoundNoResult";
                break;
            default: message = [error description];
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"An error occurred."
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
            [alert show];
            });
}

/*-(void)displayPlacemarks:(NSArray *)placemarks
{
    dispatch_async(dispatch_get_main_queue(),^ {
        
        ViewController *plvc = [[ViewController alloc] initWithPlacemarks:placemarks
                                              preferCoord:YES];
        [self.navigationController pushViewController:plvc animated:YES];
    });
}*/

- (void)showImage
{
    UIImage *image = [UIImage imageNamed:@"Textbox.gif"];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
    imgView.center = CGPointMake(self.view.bounds.size.width / 1.4f, self.view.bounds.size.height / 3.0f);
    [self.view addSubview:imgView];
}


-(IBAction)getWhatsHere:(id)sender{
    //formula latitude = cos(trueheading) * .00002757
    //formula longitude = sin(trueheading) * .00002738
    
    [self showImage];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    currLat = Latitude;
    currLong = Longitude;
    currTrueH = trueHeading;
    
    stepLat = cosf(currTrueH) * .00002757;
    stepLong = sinf(currTrueH) * .00002738;
    
    
        CLLocation *location = [[CLLocation alloc] initWithLatitude:currLat + (2*stepLat) longitude:stepLong + (2+stepLong)];
        
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error){
            if(error){
                NSLog(@"Geocode failed with error: %@", error);
                [self displayError:error];
                return;
            }
           /* NSLog(@"Receieved placemarks: %@", placemarks);
            [self displayPlacemarks:placemarks];*/
        }];
}



    

    



@end
