//
//  GalleryCollectionModel_Private.h
//  BeautifulGallery
//
//  Created by Daniel Budynski on 19/05/2017.
//  Copyright © 2017 Budyn&Friends. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFNetworking.h>

@interface GalleryCollectionModel()
@property (strong, nonatomic, nullable) AFURLSessionManager *sessionManager;
@property (strong, nonatomic, nullable) NSDictionary *response;

@end
