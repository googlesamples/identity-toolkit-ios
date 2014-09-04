//
//  GITInterfaceManager.h
//  GITkit iOS SDK
//
//  Copyright (c) 2014 Google Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GITAccount;
@protocol GITInterfaceManagerDelegate;

@interface GITInterfaceManager : NSObject

/**
 * An optional delegate that can be used to customize the UI.
 *
 * Most apps should leave this as |nil| unless custom UI is needed. If |nil|, a default
 * implementation of the UI will be used.
 */
@property(nonatomic, weak) id<GITInterfaceManagerDelegate> delegate;

/**
 * @return a UIViewController for account management.
 */
+ (UIViewController *)manageAccountController;

/**
 * Starts the authentication process.
 */
- (void)startSignIn;

/**
 * Dismisses the topmost UIViewController.
 *
 * This method only pops up to the last UIViewController pushed by pushViewController:.
 * If there is no UIViewController left, this method does nothing.
 */
- (void)popViewController;

/**
 * Presents the given UIViewController on top of the controller stack.
 *
 * @param viewController A UIViewController that should be displayed.
 */
- (void)pushViewController:(UIViewController *)viewController;

/**
 * Dismisses all presented view controllers.
 *
 * Call this method when the authentication process is completed or cancelled by the user.
 *
 * @param animated Whether the UI must be dismissed with an animation.
 * @param completion A completion handler.
 */
- (void)dismissAllAnimated:(BOOL)animated completion:(void (^)(void))completion;

@end

/**
 * Protocol that allows custom UI.
 */
@protocol GITInterfaceManagerDelegate<NSObject>
 @optional

/**
 * Sent to the receiver to find the view controller on top of which modal view controllers
 * should be displayed.
 *
 * If this method is not implemented, it will be displayed on top of the root view controller.
 */
- (UIViewController *)startingViewController;

/**
 * Sent to the receiver to find the initial sign in view controller.
 *
 * If this method is not implemented, a default implemtation will be used, which could be
 * either a account chip screen or a nascar screen, depending on if there's a saved account
 * signed in last time.
 *
 * @param account The account that was used last time, could be |nil|.
 */
- (UIViewController *)signInControllerWithAccount:(GITAccount *)account;

/**
 * Sent to the receiver to find the password user sign in view controller.
 *
 * If this method is not implemented, a default implemtation will be used.
 *
 * @param email The email address of the user.
 */
- (UIViewController *)legacySignInControllerWithEmail:(NSString *)email;

/**
 * Sent to the receiver to find the password user sign up view controller.
 *
 * If this method is not implemented, a default implemtation will be used.
 *
 * @param email The email address of the user.
 */
- (UIViewController *)legacySignUpControllerWithEmail:(NSString *)email;

/**
 * Sent to the receiver to find the account linking view controller.
 *
 * If this method is not implemented, a default implemtation will be used. The UI looks
 * different for federated user and password user.
 *
 * @param unverifiedProvider The provider ID of an IdP to be verified.
 * @param verifiedProvider The provider ID of an IdP the user has previously signed in with,
 *                         |nil| for password user.
 */
- (UIViewController *)accountLinkingControllerWithUnverifiedProvider:(NSString *)unverifiedProvider
                                                    verifiedProvider:(NSString *)verifiedProvider;

@end
