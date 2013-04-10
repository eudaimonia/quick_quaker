//
//  QKAppDelegate.m
//  quaker
//
//  Created by eudaimonia on 3/7/13.
//  Copyright (c) 2013 eudaimonia. All rights reserved.
//

#import "QKAppDelegate.h"
#import "QKMainViewController.h"
#import "QKNetWorkManager.h"
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <errno.h>



@interface QKAppDelegate()

@property (strong, nonatomic) NSString *serverAddress;
@property (nonatomic) short serverPort;
@property (nonatomic) int sockFd;

- (void) networkConfig;
- (void) networkInit;
- (void) updateUIByData: (id)jsonOjbect;

@end

@implementation QKAppDelegate

- (void) networkConfig {
	self.serverAddress = @"192.168.56.2";
	self.serverPort = 7777;
}

- (void) networkInit {
	struct sockaddr_in addr;
	memset(&addr, 0, sizeof(addr));
	addr.sin_len = sizeof(addr);
	addr.sin_family = AF_INET;
	addr.sin_port = htons(self.serverPort);
	addr.sin_addr.s_addr = inet_addr([self.serverAddress UTF8String]);
	self.sockFd = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
	dispatch_sync(queue, ^{
		if (-1 == connect(self.sockFd, &addr, sizeof(addr))) {
			NSLog(@"Failed to connect to server");
		} else {
            dispatch_source_t sockSourceForRead = dispatch_source_create(DISPATCH_SOURCE_TYPE_READ,self.sockFd, 0, queue);
            if(!sockSourceForRead) {
                close(self.sockFd);
            } else {
            dispatch_source_set_event_handler(sockSourceForRead, ^{
                size_t estimated = dispatch_source_get_data(sockSourceForRead) + 1;
                char *buffer = (char *) malloc(estimated);
                if (buffer) {
                    size_t len = read(self.sockFd, buffer, estimated); // TODO: the return value of read should be checked
                    buffer[len] = 0;
                    //NSString *content = [[NSString alloc] initWithCString: buffer encoding:NSASCIIStringEncoding];
                    NSData *content = [NSData dataWithBytes:buffer length:len];
                    NSError *parseError = nil;
                    id jsonOjbect = [NSJSONSerialization JSONObjectWithData:content options: NSJSONReadingAllowFraments error:parseError];
                    dispatch_queue_t mainQueue = dispatch_get_main_queue();
                    // update the UI by netnwork data
                    dispatch_sync(mainQueue, ^{[self updateUIByData: jsonOjbect];});
                    free(buffer);
                }
                });
            dispatch_source_set_cancel_handler(sockSourceForRead, ^{close(self.sockFd);});
            dispatch_resume(sockSourceForRead);
            }
        }
	});
}

- (void) updateUIByData: (id)jsonOjbect{
    [self.mainViewController updateUIByData:jsonOjbect];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.mainViewController = [[QKMainViewController alloc] init];
    self.window.rootViewController = self.mainViewController;
    [self.window makeKeyAndVisible];
	[self networkConfig];
	[self networkInit];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void) application:(UIApplication *) application didReceiveLocalNotification:(UILocalNotification *)notification {
}

@end
