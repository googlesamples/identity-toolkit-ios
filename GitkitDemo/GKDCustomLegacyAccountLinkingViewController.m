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
//  GKDCustomLegacyAccountLinkingViewController.m
//  GitkitDemo

#import "GKDCustomLegacyAccountLinkingViewController.h"

#import <GITkit/GITkit.h>

@interface GKDCustomLegacyAccountLinkingViewController ()
@property (copy, nonatomic) NSString *unverifiedProvider;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@end

@implementation GKDCustomLegacyAccountLinkingViewController

- (instancetype)initWithUnverifiedProvider:(NSString *)unverifiedProvider {
  self = [super init];
  if (self) {
    _unverifiedProvider = unverifiedProvider;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.messageLabel.text = [self.messageLabel.text
      stringByReplacingOccurrencesOfString:@"%%UNVERIFIED_PROVIDER%%"
                                withString:_unverifiedProvider];
}

- (IBAction)continueButtonDidTap:(id)sender {
  [[GITAuth sharedInstance] linkAccountWithPassword:self.passwordField.text
                                    invalidCallback:^{
        // Handle wrong password here.
        [[[UIAlertView alloc] initWithTitle:@"Error"
                                    message:@"Wrong password!"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
        self.passwordField.text = @"";
      }];
}

@end
