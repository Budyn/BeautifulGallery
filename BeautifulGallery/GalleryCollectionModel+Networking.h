//
//  GalleryCollectionModel+Networking.h
//  BeautifulGallery
//
//  Created by Daniel Budynski on 19/05/2017.
//  Copyright © 2017 Budyn&Friends. All rights reserved.
//

#import "GalleryCollectionModel.h"

FOUNDATION_EXPORT NSString * const kPublicFeedURL;
FOUNDATION_EXPORT NSString * const kUserAPIKey;

@interface GalleryCollectionModel(Networking)
- (void)downloadLatestPictures;

@end
