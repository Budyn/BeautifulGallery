//
//  GalleryCollectionObject.h
//  BeautifulGallery
//
//  Created by Daniel Budynski on 20/05/2017.
//  Copyright © 2017 Budyn&Friends. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface GalleryCollectionObject : NSObject
- (nullable instancetype)initWithProperties:(nullable NSDictionary *)properties NS_DESIGNATED_INITIALIZER;

@property (nullable, copy, nonatomic) NSString *authorEmail;
@property (nullable, copy, nonatomic) NSString *authorName;
@property (nullable, strong, nonatomic) NSDate *publicationDate;
@property (nullable, copy, nonatomic) NSString *authorID;
@property (nullable, copy, nonatomic) NSString *title;
@property (nullable, strong, nonatomic) NSDictionary *media;
@property (nullable, copy, nonatomic) NSString *link;
@property (nullable, strong, nonatomic) NSDate *creationDate;
@property (nullable, copy, nonatomic) NSString *info;
@property (nullable, strong, nonatomic) NSString *tags;
@property (nullable, strong, nonatomic) UIImageView *imageView;

@end
