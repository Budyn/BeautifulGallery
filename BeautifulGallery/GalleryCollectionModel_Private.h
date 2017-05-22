//
//  GalleryCollectionModel_Private.h
//  BeautifulGallery
//
//  Created by Daniel Budynski on 19/05/2017.
//  Copyright © 2017 Budyn&Friends. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFNetworking.h>
#import <UIKit+AFNetworking.h>

@class GalleryCollectionObject;

@interface GalleryCollectionModel()
@property (strong, nonatomic, nullable) AFURLSessionManager *sessionManager;
@property (strong, nonatomic, nullable) NSDictionary *response;
@property (strong, nonatomic, nullable) NSMutableArray <GalleryCollectionObject *> *objects;

@end
