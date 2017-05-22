//
//  ResponseParser.h
//  BeautifulGallery
//
//  Created by Daniel Budynski on 21/05/2017.
//  Copyright © 2017 Budyn&Friends. All rights reserved.
//

@import Foundation;

@interface ResponseParser : NSObject

- (nullable instancetype)initWithResponseProperties:(nullable NSDictionary *)responseProperties NS_DESIGNATED_INITIALIZER;

NS_ASSUME_NONNULL_BEGIN
- (NSString *)authorName;
- (NSString *)authorEmail;
- (NSString *)authorID;
- (NSString *)title;
- (NSDictionary *)media;
- (NSString *)link;
- (NSString *)description;
- (NSString *)tags;
NS_ASSUME_NONNULL_END

- (nullable NSDate *)publishedDate;
- (nullable NSDate *)dateTaken;

@end
