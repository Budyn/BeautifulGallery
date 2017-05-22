//
//  GalleryCollectionModel+Networking.m
//  BeautifulGallery
//
//  Created by Daniel Budynski on 19/05/2017.
//  Copyright © 2017 Budyn&Friends. All rights reserved.
//

#import "GalleryCollectionModel+Networking.h"
#import "GalleryCollectionModel_Private.h"
#import "GalleryCollectionObject.h"

NSString * const kPublicFeedURL = @"https://api.flickr.com/services/feeds/photos_public.gne/";
NSString * const kUserAPIKey = @"4e07423b7ab5fb6ef310a7e2d5373e36";

struct PublicFeedURLParameters {
    __unsafe_unretained NSString * const apiKey;
    __unsafe_unretained NSString * const formatJSON;
    __unsafe_unretained NSString * const noJSONCallBack;
};

const struct PublicFeedURLParameters URLParameter = {
    .apiKey = @"api_key=",
    .formatJSON = @"format=json",
    .noJSONCallBack = @"nojsoncallback=1"
};


@implementation GalleryCollectionModel(Networking)
- (void)downloadLatestPublicFeed {
    NSString *URLString = [NSString stringWithFormat:@"%@?%@%@&%@&%@",kPublicFeedURL, URLParameter.apiKey, kUserAPIKey, URLParameter.formatJSON, URLParameter.noJSONCallBack];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    NSURLSessionDataTask *dataTask = [self.sessionManager dataTaskWithRequest:request
                                                            completionHandler:^(NSURLResponse * _Nonnull response,
                                                                                id  _Nullable responseObject,
                                                                                NSError * _Nullable error) {
                                                                if (error) {
                                                                    NSLog(@"Error during download: %@", error.description);
                                                                }
                                                                
                                                                if (responseObject) {
                                                                    self.response = (NSDictionary *)responseObject;
                                                                }
                                                            }];
    [dataTask resume];
}

@end
