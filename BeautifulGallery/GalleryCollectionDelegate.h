//
//  GalleryCollectionDelegate.h
//  BeautifulGallery
//
//  Created by Daniel Budynski on 22/05/2017.
//  Copyright © 2017 Budyn&Friends. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GalleryCollectionDelegate <NSObject>
- (void)didFinishLoadinngResponseForGalleryModel;
@end
