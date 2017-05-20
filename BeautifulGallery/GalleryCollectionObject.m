//
//  GalleryCollectionObject.m
//  BeautifulGallery
//
//  Created by Daniel Budynski on 20/05/2017.
//  Copyright © 2017 Budyn&Friends. All rights reserved.
//

#import "GalleryCollectionObject.h"
#import "GalleryCollectionObject+ResponseParsing.h"

@implementation GalleryCollectionObject
- (nullable instancetype)initWithProperties:(nullable NSDictionary *)properties {
    self = [super init];
    
    if (self) {
        if (properties.count) {
            [self completeWithResponseProperties:properties];
        }
    }
    
    return self;
}

// Dummy initializer
- (nullable instancetype)init {
    self = [self initWithProperties:nil];
    return self;
}

@end
