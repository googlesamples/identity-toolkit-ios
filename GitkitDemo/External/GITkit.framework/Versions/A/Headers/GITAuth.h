//
//  GITAuth.h
//  GITkit iOS SDK
//
//  Copyright (c) 2014 Google Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GITAccount;
@protocol GITAuthDelegate;

/**
 * A singleton class that handles authentication with IdPs and GITkit server.
 */
@interface GITAuth : NSObject

/** Delegate for handling user interface and receiving sign in result. */
@property(nonatomic, weak) id<GITAuthDelegate> delegate;
/** Email address to be verified by another IdP in account linking flow. */
@property(nonatomic, copy) NSString *pendingEmail;
/** The pending id token to be verified by another IdP in account linking flow. */
@property(nonatomic, copy) NSString *pendingIDToken;

/**
 * Returns a shared |GITAuth| instance.
 */
+ (GITAuth *)sharedInstance;

/**
 * Signs user in using saved account as hint.
 */
- (void)signInWithSavedAccount;

/**
 * Signs user in using an email address as hint.
 *
 * @param email User's email address, should not be |nil|.
 */
- (void)signInWithEmail:(NSString *)email;

/**
 * Signs user in with the given identity provider.
 *
 * @param providerID The ID of the provider, ex. google.com, facebook.com.
 */
- (void)signInWithProviderID:(NSString *)providerID;

/**
 * Calls GITkit server to verify user's password.
 *
 * @param password User's password, should not be |nil|.
 * @param email User's email address, should not be |nil|.
 * @param invalidCallback Block called when the password is invalid.
 */
- (void)verifyPassword:(NSString *)password
              forEmail:(NSString *)email
       invalidCallback:(void (^)())invalidCallback;

/**
 * Calls GITkit server to sign up a password user.
 *
 * @param email User's email address, should not be |nil|.
 * @param displayName User's display name, should not be |nil|.
 * @param password User's password, should not be |nil|.
 */
- (void)signUpWithEmail:(NSString *)email
            displayName:(NSString *)displayName
               password:(NSString *)password;

/**
 * Starts account linking for a federated account. The user will be send to system browser to
 * finish the linking process.
 *
 * @param toProvider The provider ID of an IdP to be verified.
 * @param fromProvider The provider ID of an IdP the user has previously signed in with.
 */
- (void)linkAccountToProviderID:(NSString *)toProvider fromProviderID:(NSString *)fromProvider;

/**
 * Starts account linking for a password account. The password should have been collected from the
 * user before calling this method.
 *
 * @param password The password collect from the user, which is to be verified.
 * @param invalidCallback Block called when the password is invalid.
 */
- (void)linkAccountWithPassword:(NSString *)password invalidCallback:(void (^)())invalidCallback;

@end

@protocol GITAuthDelegate<NSObject>

/**
 * The authentication has finished successfully with an issued |token| for the |account| if
 * |error| is |nil|.
 *
 * @param token The ID token string issued by GITkit server.
 * @param account The account that has been authenticated.
 * @param error Any error ocurred.
 */
- (void)auth:(GITAuth *)auth
    didFinishWithToken:(NSString *)token
               account:(GITAccount *)account
                 error:(NSError *)error;

/**
 * Sent to the receiver when legacy sign in view should be displayed.
 *
 * @param email The email address of the user.
 */
- (void)showLegacySignInViewWithEmail:(NSString *)email;

/**
 * Sent to the receiver when legacy sign up view should be displayed.
 *
 * @param email The email address of the user.
 */
- (void)showLegacySignUpViewWithEmail:(NSString *)email;

/**
 * Sent to the receiver when federated account linking view should be displayed.
 *
 * @param unverifiedProvider The provider ID of an IdP to be verified.
 * @param verifiedProvider The provider ID of an IdP the user has previously signed in with,
 *                         |nil| for password user.
 */
- (void)showAccountLinkingViewWithUnverifiedProvider:(NSString *)unverifiedProvider
                                    verifiedProvider:(NSString *)verifiedProvider;

@end
