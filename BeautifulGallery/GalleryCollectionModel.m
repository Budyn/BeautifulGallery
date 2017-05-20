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
#import "GalleryCollectionObject.h"

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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self downloadLatestPictures];
    });
}

- (NSUInteger)numberOfSections {
    return 10;
}

- (NSUInteger)numberOfItemsInSection:(NSUInteger)section {
    return 10;
}

- (void)createCollectionObjectsArray {
    GalleryCollectionObject *object = [[GalleryCollectionObject alloc] initWithProperties:[[self.response objectForKey:@"items"] firstObject]];
    NSLog(@"%@", object.description);
}

@end
