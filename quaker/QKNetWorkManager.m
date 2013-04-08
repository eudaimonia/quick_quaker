//
//  QKNetWorkManager.m
//  quaker
//
//  Created by eudaimonia on 3/12/13.
//  Copyright (c) 2013 eudaimonia. All rights reserved.
//

#import "QKNetWorkManager.h"
#import <CoreFoundation/CoreFoundation.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <errno.h>

#define BUF_LEN 1024

static void TCPServerConnectCallBack(CFSocketRef socket, CFSocketCallBackType type, CFDataRef address, const void *data, void *info) {
	if (data != NULL) {
		NSLog(@"Failed to Connect to the server");
		return;
	}

	QKNetWorkManager *client = (__bridge QKNetWorkManager *)info;
	[client performSelectorInBackground:@selector(sendMsg) withObject:nil]; // Run it in a background sub-thread
	[client performSelectorInBackground:@selector(readStream) withObject:nil];
}

@implementation QKNetWorkManager

-(id) init {
    self = [super init];
    if (self != nil) {
    self.serverAddress = @"192.168.56.2";
    self.serverPort = 7777;
    }
    return self;
}

-(void) buildConnection {
	CFSocketContext socketContext = {0, (__bridge void*)self,  NULL, NULL, NULL};
	self.socket = CFSocketCreate(kCFAllocatorDefault, PF_INET, SOCK_STREAM,
			IPPROTO_TCP, kCFSocketConnectCallBack, TCPServerConnectCallBack, &socketContext);
	if (self.socket != nil) {
		struct sockaddr_in addr;
		memset(&addr, 0, sizeof(addr));
		addr.sin_len = sizeof(addr);
		addr.sin_family = AF_INET;
		addr.sin_port = htons(self.serverPort);
		addr.sin_addr.s_addr = inet_addr([self.serverAddress UTF8String]);
		// Convert struct sockaddr_in to class Data
		CFDataRef address = CFDataCreate(kCFAllocatorDefault, (UInt8*)&addr, sizeof(addr));
		CFSocketConnectToAddress(self.socket, address, -1);

		CFRunLoopRef runRef = CFRunLoopGetCurrent(); // Get current thread
		CFRunLoopSourceRef sourceRef = CFSocketCreateRunLoopSource(kCFAllocatorDefault, self.socket, 0);
		CFRunLoopAddSource(runRef, sourceRef, kCFRunLoopCommonModes);
		CFRelease(sourceRef);
	}
}

- (void) readStream {
	char buffer[BUF_LEN];
	while (recv(CFSocketGetNative(self.socket),
				buffer, sizeof(buffer), 0)) {
		NSLog(@"%@", [NSString stringWithUTF8String:buffer]);
	}
}

- (void) sendMsg {
	NSString *stringToSend = @"hello from ios";
	const char *data = [stringToSend UTF8String];
    //CFSocketSendData can be used here.
	send(CFSocketGetNative(self.socket), data, strlen(data) + 1, 0);
}

@end
