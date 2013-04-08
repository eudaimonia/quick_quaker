//
//  QKMainViewController.h
//  quaker
//
//  Created by eudaimonia on 3/11/13.
//  Copyright (c) 2013 eudaimonia. All rights reserved.
//

@class QKFirstViewController;
@class QKSecondViewController;

#import <UIKit/UIKit.h>

@interface QKMainViewController : UIViewController

@property (strong, nonatomic) QKFirstViewController *firstViewController;

@property (strong, nonatomic) QKSecondViewController *secondViewController;

@end
