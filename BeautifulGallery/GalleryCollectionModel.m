//
//  GalleryCollectionModel.m
//  BeautifulGallery
//
//  Created by Daniel Budynski on 19/05/2017.
//  Copyright © 2017 Budyn&Friends. All rights reserved.
//

#import "GalleryCollectionModel.h"
#import "GalleryCollectionModel_Private.h"
#import "GalleryCollectionModel+Networking.h"

@implementation GalleryCollectionModel

// MARK: Life Cycle
- (nullable instancetype) init {
    self = [super init];
   
    if (self) {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
        _response = [NSDictionary dictionary];
    }
    
    return self;
}

// MARK: Update Action
- (void)update {
    [self downloadLatestPictures];
}

- (void)numberOfSections {
    
}

- (void)numberOfItemsInSection:(NSUInteger)section {
    
}

@end
