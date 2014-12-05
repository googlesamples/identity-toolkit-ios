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
//  GKDCustomLegacySignUpViewController.m
//  GitkitDemo

#import "GKDCustomLegacySignUpViewController.h"

#import <GITkit/GITkit.h>

@interface GKDCustomLegacySignUpViewController ()
@property (copy, nonatomic) NSString *email;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@end

@implementation GKDCustomLegacySignUpViewController

- (instancetype)initWithEmail:(NSString *)email {
  self = [super init];
  if (self) {
    _email = email;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.emailField.text = self.email;
}

- (IBAction)signUpButtonDidTap:(id)sender {
  [[GITAuth sharedInstance] signUpWithEmail:self.emailField.text
                                displayName:self.nameField.text
                                   password:self.passwordField.text];
}

@end
