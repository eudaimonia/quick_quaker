//
//  QKViewController.m
//  quaker
//
//  Created by eudaimonia on 3/7/13.
//  Copyright (c) 2013 eudaimonia. All rights reserved.
//

#import "QKFirstViewController.h"

NSString * json_parse(NSString * content, NSString * key) {
    // TODO
    NSString *res = [[NSString alloc] init];
    return res;
}

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

- (void) updateUIByData:(NSString*) content {
    // TODO: implement json_parse
    self.labelDatetime.text = json_parse(content, @"dateTime");
    self.labelLantitude.text = json_parse(content, @"lantitude");
    self.labelLongtitude.text = json_parse(content, @"longtitude");
    self.labelMagtitude.text = json_parse(content, @"magtitude");
    self.labelRegion.text = json_parse(content, @"region");
}
@end
