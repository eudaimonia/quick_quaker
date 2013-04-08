//
//  QKAppDelegate.h
//  quaker
//
//  Created by eudaimonia on 3/7/13.
//  Copyright (c) 2013 eudaimonia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QKMainViewController;
@class QKNetWorkManager;

@interface QKAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) QKMainViewController *mainViewController;

@property (strong, nonatomic) QKNetWorkManager *networkManager;


@end
