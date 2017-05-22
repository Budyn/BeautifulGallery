//
//  GalleryCollectionObject.m
//  BeautifulGallery
//
//  Created by Daniel Budynski on 20/05/2017.
//  Copyright © 2017 Budyn&Friends. All rights reserved.
//

#import "GalleryCollectionObject.h"
#import "GalleryCollectionObject+ResponseParsing.h"

#import <AFNetworking.h>
#import <UIKit+AFNetworking.h>

@implementation GalleryCollectionObject
- (nullable instancetype)initWithProperties:(nullable NSDictionary *)properties {
    self = [super init];
    
    if (self) {
        if (properties.count) {
            [self completeWithResponseProperties:properties];
            [self downloadImage];
        }
    }
    
    return self;
}

// Dummy initializer
- (nullable instancetype)init {
    self = [self initWithProperties:nil];
    return self;
}

- (void)downloadImage {
    NSURL *imageURL = [NSURL URLWithString:[self.media objectForKey:@"m"]];
    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:imageURL];
    
    typeof(self)weakSelf = self;
    [self.imageView setImageWithURLRequest:imageRequest placeholderImage:self.imageView.image success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        weakSelf.imageView = [[UIImageView alloc] initWithImage:image];
        
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        NSLog(@"%@", error.description);
    }];
}

@end
