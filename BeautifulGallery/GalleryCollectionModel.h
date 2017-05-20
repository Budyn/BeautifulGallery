//
//  GalleryCollectionModel.h
//  BeautifulGallery
//
//  Created by Daniel Budynski on 19/05/2017.
//  Copyright © 2017 Budyn&Friends. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GalleryCollectionModel : NSObject
- (void)update;
- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfItemsInSection:(NSUInteger)section;
- (void)createCollectionObjectsArray;
@end
