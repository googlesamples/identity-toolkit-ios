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

#import "GKDCustomFederatedAccountLinkingViewController.h"
#import "GKDCustomLegacySignInViewController.h"
#import "GKDCustomLegacySignUpViewController.h"
#import "GKDCustomLegacyAccountLinkingViewController.h"
#import "GKDCustomNascarViewController.h"

@interface GKDViewController () <GITClientDelegate, GITInterfaceManagerDelegate>

@end

@implementation GKDViewController {
  GITInterfaceManager *_interfaceManager;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  _interfaceManager = [[GITInterfaceManager alloc] init];
  _interfaceManager.delegate = self;
  [GITClient sharedInstance].delegate = self;
}

- (IBAction)signInDidTap:(id)sender {
  NSLog(@"Sign in button tapped");
  [_interfaceManager startSignIn];
}

- (void)client:(GITClient *)client
    didFinishSignInWithToken:(NSString *)token
                     account:(GITAccount *)account
                       error:(NSError *)error {

  if (!error) {
    NSString *message =
        [NSString stringWithFormat:@"Name: %@\nEmail: %@\nUser ID: %@\nProvider: %@",
         account.displayName, account.email, account.localID, account.providerID];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Login Success"
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    NSLog(@"token: %@, account: %@", token, account);
  } else {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    NSLog(@"error %@", error);
  }
}

// Uncomment the following code to enable custom UI.
/*
#pragma mark GITInterfaceManagerDelegate methods

- (UIViewController *)signInControllerWithAccount:(GITAccount *)account {
  return [[GKDCustomNascarViewController alloc] init];
}

- (UIViewController *)legacySignInControllerWithEmail:(NSString *)email {
  return [[GKDCustomLegacySignInViewController alloc] initWithEmail:email];
}

- (UIViewController *)legacySignUpControllerWithEmail:(NSString *)email {
  return [[GKDCustomLegacySignUpViewController alloc] initWithEmail:email];
}

- (UIViewController *)accountLinkingControllerWithUnverifiedProvider:(NSString *)unverifiedProvider
                                                    verifiedProvider:(NSString *)verifiedProvider {
  return [[GKDCustomFederatedAccountLinkingViewController alloc]
          initWithUnverifiedProvider:unverifiedProvider
          verifiedProvider:verifiedProvider];
}

- (UIViewController *)accountLinkingControllerWithUnverifiedProvider:
(NSString *)unverifiedProvider {
  return [[GKDCustomLegacyAccountLinkingViewController alloc]
          initWithUnverifiedProvider:unverifiedProvider];
}
*/

@end
