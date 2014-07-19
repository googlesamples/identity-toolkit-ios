//
//  GITAccount.h
//  GITkit iOS SDK
//
//  Copyright (c) 2014 Google Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Key used to access the local ID of an account. */
extern NSString * const kGITAccountLocalIDKey;
/** Key used to access the email address of an account. */
extern NSString * const kGITAccountEmailKey;
/** Key used to access the display name of an account. */
extern NSString * const kGITAccountDisplayNameKey;
/** Key used to access the photo URL of an account. */
extern NSString * const kGITAccountPhotoURLKey;
/** Key used to access the provider ID of an account. */
extern NSString * const kGITAccountProviderIDKey;

/**
 * An account passed to third-party at the end of a successful authentication.
 */
@interface GITAccount : NSObject

/** The unique identifier of the user in GITkit server. */
@property(nonatomic, copy) NSString *localID;
/** User's email address. */
@property(nonatomic, copy) NSString *email;
/** User's display name on the IdP's website. */
@property(nonatomic, copy) NSString *displayName;
/** URL of the user's photo on the IdP's website. */
@property(nonatomic, copy) NSString *photoURL;
/**
 * The identifier of the IdP. It's the top-level domain of the provider,
 * ex. google.com, yahoo.com.
 */
@property(nonatomic, copy) NSString *providerID;

/**
 * Designated initializer.
 *
 * @param dict An NSDictionary that should include all GITAccount properties: localID, email,
 *             displayName, and photoURL. Among them, localID and email are required.
 */
- (instancetype)initWithUserAttributes:(NSDictionary *)dict;

/**
 * @return An NSDictionary that has all user attributes keyed by localID, email, displayName,
*          and photoURL.
 */
- (NSDictionary *)userAttributes;

/**
 * Constructs a GITAccount using given NSDictionary.
 *
 * @param dict An NSDictionary that should include all GITAccount properties: localID, email,
 *             displayName, and photoURL. Among them, localID and email are required.
 */
+ (GITAccount *)accountWithUserAttributes:(NSDictionary *)dict;

@end
