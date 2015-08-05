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
//  GKDAppDelegate.m
//  GitkitDemo

#import "GKDAppDelegate.h"

#import "GITkit.h"
#import "GoogleSignIn.h"

@implementation GKDAppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  GITClient *gitkitClient = [GITClient sharedInstance];
  gitkitClient.apiKey = @"GITKIT_API_KEY";
  gitkitClient.widgetURL = @"GITKIT_WIDGET_URL";
  gitkitClient.providers = @[ kGITProviderGoogle, kGITProviderYahoo ];
  [GIDSignIn sharedInstance].clientID = @"GOOGLE_CLIENT_ID";
  return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
  // Handle custom scheme redirect here.
  return [GITClient handleOpenURL:url
                sourceApplication:sourceApplication
                       annotation:annotation];
}

@end
