//
//  QKMainViewController.m
//  quaker
//
//  Created by eudaimonia on 3/11/13.
//  Copyright (c) 2013 eudaimonia. All rights reserved.
//

#import "QKMainViewController.h"
#import "QKFirstViewController.h"
#import "QKSecondViewController.h"

@interface QKMainViewController ()

@end

@implementation QKMainViewController

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
	// Do any additional setup after loading the view.
    self.firstViewController = [[QKFirstViewController alloc] initWithNibName:@"QKFirstViewController" bundle:nil];
    self.secondViewController = [[QKSecondViewController alloc] initWithNibName:@"QKSecondViewController" bundle:nil];
    [self.view addSubview: self.secondViewController.view];
    [self.view addSubview: self.firstViewController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateUIByData:(NSString *) content {
    [self.firstViewController updateUIByData: content];
    [self.secondViewController updateUIByData: content];
}

@end
