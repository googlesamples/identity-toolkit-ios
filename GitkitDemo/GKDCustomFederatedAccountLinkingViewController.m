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
//  GKDCustomFederatedAccountLinkingViewController.m
//  GitkitDemo

#import "GKDCustomFederatedAccountLinkingViewController.h"

#import <GITkit/GITkit.h>

@interface GKDCustomFederatedAccountLinkingViewController ()
@property (copy, nonatomic) NSString *unverifiedProvider;
@property (copy, nonatomic) NSString *verifiedProvider;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@end

@implementation GKDCustomFederatedAccountLinkingViewController

- (instancetype)initWithUnverifiedProvider:(NSString *)unverifiedProvider
                          verifiedProvider:(NSString *)verifiedProvider {
  self = [super init];
  if (self) {
    _unverifiedProvider = unverifiedProvider;
    _verifiedProvider = verifiedProvider;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.messageLabel.text = [[self.messageLabel.text
      stringByReplacingOccurrencesOfString:@"%%VERIFIED_PROVIDER%%"
                                withString:_verifiedProvider]
      stringByReplacingOccurrencesOfString:@"%%UNVERIFIED_PROVIDER%%"
                                withString:_unverifiedProvider];
}

- (IBAction)continueButtonDidTap:(id)sender {
  [[GITAuth sharedInstance] linkAccountToProviderID:self.unverifiedProvider
                                     fromProviderID:self.verifiedProvider];
}

@end
