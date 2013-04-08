//
//  QKSecondViewController.m
//  quaker
//
//  Created by eudaimonia on 3/11/13.
//  Copyright (c) 2013 eudaimonia. All rights reserved.
//

#import "QKSecondViewController.h"

@interface QKSecondViewController ()

@end

@implementation QKSecondViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonBackClicked:(id)sender {
    NSLog(@"buttonBackClicked");
    [self.view.superview exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
}
@end
