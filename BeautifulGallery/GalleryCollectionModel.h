//
//  GalleryCollectionModel.h
//  BeautifulGallery
//
//  Created by Daniel Budynski on 19/05/2017.
//  Copyright © 2017 Budyn&Friends. All rights reserved.
//

@import Foundation;
@import UIKit;

#import "GalleryCollectionDelegate.h"

@interface GalleryCollectionModel : NSObject
@property (weak, nonatomic) id <GalleryCollectionDelegate> delegate;

- (void)update;
- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfItemsInSection:(NSUInteger)section;
- (UIImageView *)imageForCellAtIndex:(NSIndexPath *)indexPath;

@end
