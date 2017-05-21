//
//  GalleryCollectionObject+ResponseParsing.m
//  BeautifulGallery
//
//  Created by Daniel Budynski on 20/05/2017.
//  Copyright © 2017 Budyn&Friends. All rights reserved.
//

#import "GalleryCollectionObject+ResponseParsing.h"
#import "ResponseParser.h"

@implementation GalleryCollectionObject(ResponseParsing)
- (void)completeWithResponseProperties:(nullable NSDictionary *)responseProperties {
    if (responseProperties.count) {
        ResponseParser *parser = [[ResponseParser alloc] initWithResponseProperties:responseProperties];
        self.authorEmail = [parser authorEmail];
        self.authorName = [parser authorName];
        self.publicationDate = [parser publishedDate];
        self.authorID = [parser authorID];
        self.title = [parser title];
        self.media = [parser media];
        self.link = [parser link];
        self.creationDate = [parser dateTaken];
        self.info = [parser description];
        self.tags = [parser tags];
    } else {
        NSLog(@"Response dictionary is empty in: [%@, %@]", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    }
}

@end
