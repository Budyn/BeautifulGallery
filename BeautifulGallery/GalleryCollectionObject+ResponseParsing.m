//
//  GalleryCollectionObject+ResponseParsing.m
//  BeautifulGallery
//
//  Created by Daniel Budynski on 20/05/2017.
//  Copyright © 2017 Budyn&Friends. All rights reserved.
//

#import "GalleryCollectionObject+ResponseParsing.h"

struct ResponseKeyStruct {
    __unsafe_unretained NSString * const author;
    __unsafe_unretained NSString * const published;
    __unsafe_unretained NSString * const authorID;
    __unsafe_unretained NSString * const title;
    __unsafe_unretained NSString * const media;
    __unsafe_unretained NSString * const link;
    __unsafe_unretained NSString * const dateTaken;
    __unsafe_unretained NSString * const description;
    __unsafe_unretained NSString * const tags;
};

const struct ResponseKeyStruct ResponseKey = {
    .author = @"author",
    .published = @"published",
    .authorID = @"author_id",
    .title = @"title",
    .media = @"media",
    .link = @"link",
    .dateTaken = @"data_taken",
    .description = @"description",
    .tags = @"tags",
};

@implementation GalleryCollectionObject(ResponseParsing)
- (void)completeWithResponseProperties:(nullable NSDictionary *)responseProperties {
    if (responseProperties.count) {
        if ([responseProperties objectForKey:ResponseKey.author]) {
            [self completeAuthorNameAndEmailPropertyWithAuthorNameFromResponse:[responseProperties objectForKey:ResponseKey.author]];
        }
        
        if ([responseProperties objectForKey:ResponseKey.published]) {
            [self completePublishedPropertyWithPublishedDateStringFromResponse:[responseProperties objectForKey:ResponseKey.published]];
        }
        
        if ([responseProperties objectForKey:ResponseKey.authorID]) {
            [self completeAuthorIDPropertyWithAuthorIDFromResponse:[responseProperties objectForKey:ResponseKey.authorID]];
        }
        
        if ([responseProperties objectForKey:ResponseKey.media]) {
            [self completeMediaPropertyWithMediaFromResponse:[responseProperties objectForKey:ResponseKey.media]];
        }
        
        if ([responseProperties objectForKey:ResponseKey.link]) {
            [self completeLinkPropertyWithLinkFormResponse:[responseProperties objectForKey:ResponseKey.link]];
        }
        
        if ([responseProperties objectForKey:ResponseKey.dateTaken]) {
            [self completeDateTakenPropertyWithDateTakenStringFromResponse:[responseProperties objectForKey:ResponseKey.dateTaken]];
        }
        
        if ([responseProperties objectForKey:ResponseKey.description]) {
            [self completeDescriptionPropertyWithDescriptionFromResponse:[responseProperties objectForKey:ResponseKey.description]];
        }
        
        if ([responseProperties objectForKey:ResponseKey.tags]) {
            [self completeTagsPropertyWithTagsFromResponse:[responseProperties objectForKey:ResponseKey.tags]];
        }
        
    } else {
        NSLog(@"Response dictionary is empty in: [%@, %@]", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    }
}

- (void)completeAuthorNameAndEmailPropertyWithAuthorNameFromResponse:(nullable NSString *)authorResponse {
    NSArray *authorNameParts = [authorResponse componentsSeparatedByString:@" "];
    if (authorNameParts) {
        NSString *authorEmail = [NSString string];
        
        if (authorNameParts.count > 0) {
            authorEmail = [authorNameParts firstObject];
            self.authorEmail = authorEmail;
        }
        
        NSString *authorName = [NSString string];
        
        if (authorNameParts.count > 1) {
            authorName = [authorNameParts objectAtIndex:1];
            authorName = [self extractFullAuthorNameFrom:authorName];
            self.authorName = authorName;
        }
    }
}

- (nullable NSString *)extractFullAuthorNameFrom:(nullable NSString *)authorName {
    // (\"davidryba1\")
    authorName = [authorName stringByReplacingOccurrencesOfString:@"(\"" withString:@""];
    authorName = [authorName stringByReplacingOccurrencesOfString:@"\")" withString:@""];
    return authorName;
}

- (void)completePublishedPropertyWithPublishedDateStringFromResponse:(nullable NSString *)publishedDateString {
    NSDate *publicationDate = nil;
    
    if (publishedDateString) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"yyyy-MM-ddTHH:mm:ssZ"];
       
        publicationDate = [dateFormatter dateFromString:publishedDateString];
    }
    
    self.publicationDate = publicationDate;
}

- (void)completeAuthorIDPropertyWithAuthorIDFromResponse:(nullable NSString *)authorID {
    self.authorID = authorID ? authorID : [NSString string];
}

- (void)completeTitlePropertyWithTitleFromResponse:(nullable NSString *)title {
    self.title = title ? title : [NSString string];
}

- (void)completeMediaPropertyWithMediaFromResponse:(nullable NSDictionary *)media {
    self.media = media;
}

- (void)completeLinkPropertyWithLinkFormResponse:(nullable NSString *)link {
    self.link = link ? link : [NSString string];
}

- (void) completeDateTakenPropertyWithDateTakenStringFromResponse:(nullable NSString *)dataTakenString {
    NSDate *creationDate = nil;
    
    if (dataTakenString) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"yyyy-MM-ddTHH:mm:ssZ"];
        
        creationDate = [dateFormatter dateFromString:dataTakenString];
    }
    
    self.publicationDate = creationDate;
}

- (void)completeDescriptionPropertyWithDescriptionFromResponse:(nullable NSString *)description {
    self.info = description ? description : [NSString string];
}

- (void)completeTagsPropertyWithTagsFromResponse:(nullable NSString *)tags {
    self.tags = tags ? tags : [NSString string];
}

@end
