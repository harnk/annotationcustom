//
//  ViewController.m
//  AnnotationCustom
//
//  Created by Véronique Brossier on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "VBAnnotation.h"

// Carpinteria
#define CA_LATITUDE 34.3989
#define CA_LONGITUDE -119.5175
// Beach
#define BE_LATITUDE 34.392222
#define BE_LONGITUDE -119.507552
#define BE2_LATITUDE 34.492222
#define BE2_LONGITUDE -119.607552

#define SPAN_VALUE 1.0f

@implementation ViewController
@synthesize mapView = _mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.mapView setDelegate:self];
    
    MKCoordinateRegion region;
    region.center.latitude = CA_LATITUDE;
    region.center.longitude = CA_LONGITUDE;
    region.span.latitudeDelta = SPAN_VALUE;
    region.span.longitudeDelta = SPAN_VALUE;
    [self.mapView setRegion:region animated:NO];
    
    CLLocationCoordinate2D location;
    location.latitude = BE_LATITUDE;
    location.longitude = BE_LONGITUDE;
    VBAnnotation *ann = [[VBAnnotation alloc] initWithPosition:location];
    [ann setCoordinate:location];
    ann.title = @"User1";
    ann.subtitle = @"Surfing Beach";
    [self.mapView addAnnotation:ann];
    
    [NSTimer scheduledTimerWithTimeInterval: 5
                                     target: self
                                   selector: @selector(changeRegion)
                                   userInfo: nil
                                    repeats: YES];

}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
    view.pinColor = MKPinAnnotationColorPurple;
    view.enabled = YES;
    view.animatesDrop = YES;
    view.canShowCallout = YES;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"palmTree.png"]];
    view.leftCalloutAccessoryView = imageView;
    view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return view;
}

-(void) changeRegion {
    NSLog(@"changeRegion is called");
    
    
    for (id<MKAnnotation> ann in _mapView.annotations)
    {
        if ([ann.title isEqualToString:@"User1"])
        {
            NSLog(@"found user1");
            CLLocationCoordinate2D location;
            float rndV1 = (((float)arc4random()/0x100000000)*0.1);
            float rndV2 = (((float)arc4random()/0x100000000)*0.1);
            location.latitude = BE2_LATITUDE + rndV1;
            location.longitude = BE2_LONGITUDE + rndV2;
            ann.coordinate = location;
            break;
        }
    }
    
//    //region
//    MKCoordinateRegion region;
//    //center
//    CLLocationCoordinate2D center;
//    center.latitude = CA_LATITUDE;
//    center.longitude = CA_LONGITUDE;
//    //span
//    MKCoordinateSpan span;
//    span.latitudeDelta = SPAN_VALUE;
//    span.longitudeDelta = SPAN_VALUE;
//    
//    region.center = center;
//    region.span = span;
//    
//    // assign region to map
//    [_mapView setRegion:region animated:YES];
    
}


- (void)viewDidUnload {
    [self setMapView:nil];
    [super viewDidUnload];
}
@end