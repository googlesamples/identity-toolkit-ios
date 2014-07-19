/*
 *
 * Copyright 2014 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
//  GKDViewController.m
//  GitkitDemo

#import "GKDViewController.h"

#import <GITkit/GITkit.h>

@interface GKDViewController () <GITClientDelegate>

@end

@implementation GKDViewController {
  GITInterfaceManager *_interfaceManager;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [GITClient sharedInstance].delegate = self;
}

- (IBAction)signInDidTap:(id)sender {
  NSLog(@"Sign in button tapped");
  _interfaceManager = [[GITInterfaceManager alloc] init];
  [_interfaceManager startSignIn];
}

- (void)client:(GITClient *)client
    didFinishSignInWithToken:(NSString *)token
                     account:(GITAccount *)account
                       error:(NSError *)error {
  NSLog(@"token: %@, account: %@", token, account);
}

@end
