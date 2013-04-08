//
//  QKViewController.h
//  quaker
//
//  Created by eudaimonia on 3/7/13.
//  Copyright (c) 2013 eudaimonia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QKFirstViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *buttonMap;
@property (weak, nonatomic) IBOutlet UILabel *labelLantitude;
@property (weak, nonatomic) IBOutlet UILabel *labelLongtitude;
@property (weak, nonatomic) IBOutlet UILabel *labelMagtitude;
@property (weak, nonatomic) IBOutlet UILabel *labelRegion;
@property (weak, nonatomic) IBOutlet UILabel *labelDatetime;
- (IBAction)buttonMapClicked:(id)sender;
- (void) upateUIByNetworkwithDatetime:(NSString *) dateTime \
    lantitude:(NSString *) lantitude \
    longtitude:(NSString *) longtitude \
    magtitude:(NSString *) magtitude\
    region:(NSString *) region;
@end
