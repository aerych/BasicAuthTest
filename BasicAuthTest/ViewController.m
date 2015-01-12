//
//  ViewController.m
//  BasicAuthTest
//
//  Created by aerych on 1/11/15.
//  Copyright (c) 2015 Aerych. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLConnectionDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Test" forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 100, 200, 40);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(perform) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:button];
}

- (void)perform
{
NSLog(@"PERFORM!!");
    NSInteger count = 6;
    for (NSInteger i = 0; i < count; i++) {
        [self doRequest];
    }
}

- (void)doRequest
{
NSLog(@"do request");
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://bh.wpmt.co/xmlrpc.php"]];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSString *userName = @"";
    NSString *password = @"";
    NSURLCredential *credential = [NSURLCredential credentialWithUser:userName password:password persistence:NSURLCredentialPersistenceForSession];
    if ([challenge previousFailureCount] == 0 && credential) {
NSLog(@"responding to request");
        [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
    } else {
NSLog(@"!!! Failed to auth, this is an extra request");
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"finished");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Connection failed with error: %@", error);
}


@end
