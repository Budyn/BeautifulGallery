//
//  GalleryCollectionObject+ResponseParsing.h
//  BeautifulGallery
//
//  Created by Daniel Budynski on 20/05/2017.
//  Copyright © 2017 Budyn&Friends. All rights reserved.
//

#import "GalleryCollectionObject.h"

@interface GalleryCollectionObject(ResponseParsing)
- (void)completeWithResponseProperties:(nullable NSDictionary *)responseProperties;

@end
