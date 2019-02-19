//
//  DetailViewController.m
//  TestTaskAlarStudiosObjC
//
//  Created by Oleg Soloviev on 12.02.2019.
//  Copyright © 2019 varton. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *idLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *countryLabel;
@property (strong, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (strong, nonatomic) IBOutlet UILabel *longitudeLabel;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Airport";
    
    self.idLabel.text = self.airport.idn;
    self.nameLabel.text = self.airport.name;
    self.countryLabel.text = self.airport.country;
    self.latitudeLabel.text = self.airport.lat;
    self.longitudeLabel.text = self.airport.lon;
    
    Annotation *annotation = [[Annotation alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake(self.airport.lat.doubleValue, self.airport.lon.doubleValue);
    [self.mapView showAnnotations:[NSArray arrayWithObjects: annotation, nil] animated:YES];
    [self.mapView selectAnnotation:annotation animated:YES];

    MKCoordinateRegion region;
    region.center = annotation.coordinate;
    region.span.latitudeDelta = 0.112872;
    region.span.longitudeDelta = 0.112872;
    MKCoordinateRegion theRegion;
    theRegion = [self.mapView regionThatFits:region];
    [self.mapView setRegion:theRegion animated:YES];

}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView *annotationView = nil;
    annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
    annotationView.pinTintColor = [UIColor redColor];
    return annotationView;
}
@end
