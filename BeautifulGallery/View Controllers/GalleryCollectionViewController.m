//
//  GalleryCollectionnViewController.m
//  BeautifulGallery
//
//  Created by Daniel Budynski on 19/05/2017.
//  Copyright © 2017 Budyn&Friends. All rights reserved.
//

#import "GalleryCollectionViewController.h"
#import "GalleryCollectionViewCell.h"
#import "GalleryCollectionModel.h"
#import "GalleryCollectionDelegate.h"


@interface GalleryCollectionViewController () <GalleryCollectionDelegate>
@property (strong, nonatomic, nonnull)  GalleryCollectionModel *model;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButton;

@end

@implementation GalleryCollectionViewController

NSString * const kReuseIdentifier = @"Cell";

// MARK: Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [[GalleryCollectionModel alloc] init];
    self.model.delegate = self;
    
    self.title = @"Gallery";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// MARK: Refresh action
- (IBAction)refreshButtonTapped:(id)sender {
    [self disableRefreshButton];
    [self.model update];
}

- (void)enableRefreshButton {
    self.refreshButton.enabled = YES;
}

- (void)disableRefreshButton {
    self.refreshButton.enabled = NO;
}

// MARK: Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

// MARK: UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.model numberOfSections];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.model numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GalleryCollectionViewCell *cell = (GalleryCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kReuseIdentifier forIndexPath:indexPath];
    cell.thumbnailImage = [self.model imageForCellAtIndex:indexPath];
    
    return cell;
}

// MARK: GalleryCollectionDelegate
- (void)didFinishLoadinngResponseForGalleryModel {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
        [self enableRefreshButton];
    });
}

@end
