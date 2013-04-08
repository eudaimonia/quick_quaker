//
//  QKNetWorkManager.h
//  quaker
//
//  Created by eudaimonia on 3/12/13.
//  Copyright (c) 2013 eudaimonia. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface QKNetWorkManager : NSObject

@property(strong, nonatomic) NSString *serverAddress;
@property(nonatomic) short serverPort;
@property(nonatomic) CFSocketRef socket;

- (id) init;
- (void) buildConnection;
- (void) readStream;
- (void) sendMsg;

@end
