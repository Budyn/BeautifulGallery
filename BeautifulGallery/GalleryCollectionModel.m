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

#define kNumberOfSectionsInGallery 1

@implementation GalleryCollectionModel

// MARK: Life Cycle
- (nullable instancetype) init {
    self = [super init];
   
    if (self) {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
        _response = [NSDictionary dictionary];
        _objects = [NSMutableArray array];
        
        [self update];
    }
    
    return self;
}

// MARK: Setters && Getters
- (void)setResponse:(NSDictionary *)response {
    if (response) {
        _response = response;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self createCollectionObjectsArray];
        });
    }
}

// MARK: Update Action
- (void)update {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self downloadLatestPublicFeed];
    });
}

// MARK: CollectionView Data Source
- (NSUInteger)numberOfSections {
    return kNumberOfSectionsInGallery;
}

- (NSUInteger)numberOfItemsInSection:(NSUInteger)section {
    return self.objects.count;
}


- (UIImageView *)imageForCellAtIndex:(NSIndexPath *)indexPath {
    return [[self.objects objectAtIndex:indexPath.row] imageView];
}

- (void)createCollectionObjectsArray {
    if (self.response.count && [self.response objectForKey:@"items"]) {
        [self cleanOldObjects];
        
        for (NSDictionary *itemProperties in [self.response objectForKey:@"items"]) {
            GalleryCollectionObject *newObject = [[GalleryCollectionObject alloc] initWithProperties:itemProperties];
            [self.objects addObject:newObject];
        }
    } else {
        NSLog(@"Can't create objects for gallery - response is empty or null in [%@, %@]", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    }
    
    if (self.delegate) {
        [self.delegate didFinishLoadinngResponseForGalleryModel];
    }
}

- (void)cleanOldObjects {
    [self.objects removeAllObjects];
}

@end
