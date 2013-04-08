//
//  QKViewController.m
//  quaker
//
//  Created by eudaimonia on 3/7/13.
//  Copyright (c) 2013 eudaimonia. All rights reserved.
//

#import "QKFirstViewController.h"

@interface QKFirstViewController ()

@end

@implementation QKFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Note: Try to connect to server to get the data
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonMapClicked:(id)sender {
    NSLog(@"buttonMapClicked");
    [self.view.superview exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
}

- (void) upateUIByNetworkwithDatetime:(NSString *) dateTime \
lantitude:(NSString *) lantitude \
longtitude:(NSString *) longtitude \
magtitude:(NSString *) magtitude
region:(NSString *) region {
    self.labelDatetime.text = dateTime;
    self.labelLantitude.text = lantitude;
    self.labelLongtitude.text = longtitude;
    self.labelMagtitude.text = magtitude;
    self.labelRegion.text = region;
}
@end
