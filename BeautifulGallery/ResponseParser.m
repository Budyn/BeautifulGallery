//
//  ResponseParser.m
//  BeautifulGallery
//
//  Created by Daniel Budynski on 21/05/2017.
//  Copyright © 2017 Budyn&Friends. All rights reserved.
//

#import "ResponseParser.h"

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
    .dateTaken = @"date_taken",
    .description = @"description",
    .tags = @"tags",
};

@interface  ResponseParser()
@property (strong, nonatomic, nullable) NSDictionary *responseProperties;
@end

@implementation ResponseParser

// MARK: Lifecycle
- (nullable instancetype)initWithResponseProperties:(nullable NSDictionary *)responseProperties {
    if ((self = [super init])) {
        _responseProperties = responseProperties;
    }
    
    return self;
}

- (nullable instancetype)init {
    return [self initWithResponseProperties:nil];
}

// MARK: Properties Parsing
- (NSString *)authorName {
    NSString *authorName = [NSString string];
   
    if ([self.responseProperties objectForKey:ResponseKey.author]) {
        NSString *authorFromRepsonse = [self.responseProperties objectForKey:ResponseKey.author];
        NSArray *authorPartsFromResponse = [authorFromRepsonse componentsSeparatedByString:@" "];
        
        if (authorPartsFromResponse.count > 1) {
            NSMutableArray *mutableAuthorPartsFromResponse = [NSMutableArray arrayWithArray:authorPartsFromResponse];
            [mutableAuthorPartsFromResponse removeObjectAtIndex:0];
            authorName = [mutableAuthorPartsFromResponse componentsJoinedByString:@" "];
            authorName = [self extractFullAuthorNameFrom:authorName];
        }
    }
    
    return authorName;
}

- (nullable NSString *)extractFullAuthorNameFrom:(nullable NSString *)authorName {
    // (\"exampleName\")
    NSString *authorNameFromResponse = authorName;
    
    authorNameFromResponse = [authorNameFromResponse stringByReplacingOccurrencesOfString:@"(\"" withString:@""];
    authorNameFromResponse = [authorNameFromResponse stringByReplacingOccurrencesOfString:@"\")" withString:@""];
   
    return authorNameFromResponse;
}

- (NSString *)authorEmail {
    NSString *authorEmail = [NSString string];
    
    if ([self.responseProperties objectForKey:ResponseKey.author]) {
        NSString *authorFromRepsonse = [self.responseProperties objectForKey:ResponseKey.author];
        NSArray *authorNameParts = [authorFromRepsonse componentsSeparatedByString:@" "];
        if (authorNameParts && authorNameParts.count > 0) {
            authorEmail = [authorNameParts firstObject];
        }
    }
    
    return authorEmail;
}

- (NSDate *)publishedDate {
    NSDate *publishedDate = nil;
    
    if ([self.responseProperties objectForKey:ResponseKey.published]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        
        NSString *dateStringFromResponse = [self.responseProperties objectForKey:ResponseKey.published];
        
        NSRange timeMarkRange = [dateStringFromResponse rangeOfString:@"T"];
        NSRange dateRange = NSMakeRange(0, timeMarkRange.location);
        dateStringFromResponse = [dateStringFromResponse substringWithRange:dateRange];
        
        publishedDate = [dateFormatter dateFromString:dateStringFromResponse];
    }
    
    return publishedDate;
}

- (NSString *)authorID {
    NSString *authorID = [NSString string];
    
    if ([self.responseProperties objectForKey:ResponseKey.authorID]) {
        NSString *authorIDFromResponse = [self.responseProperties objectForKey:ResponseKey.authorID];
        authorID = authorIDFromResponse ? authorIDFromResponse : [NSString string];
    }
    
    return authorID;
}

- (NSString *)title {
    NSString *title = [NSString string];
    
    if ([self.responseProperties objectForKey:ResponseKey.title]) {
        NSString *titleFromResponse = [self.responseProperties objectForKey:ResponseKey.title];
        title = titleFromResponse ? titleFromResponse : [NSString string];
    }
    
    return title;
}

- (NSDictionary *)media {
    NSDictionary *media = [NSDictionary dictionary];
    
    if ([self.responseProperties objectForKey:ResponseKey.media]) {
        NSDictionary *mediaFromResponse = [self.responseProperties objectForKey:ResponseKey.media];
        if (mediaFromResponse.count) {
            media = mediaFromResponse;
        }
    }
    
    return media;
}

- (NSString *)link {
    NSString *link = [NSString string];
    
    if ([self.responseProperties objectForKey:ResponseKey.link]) {
        NSString *linkFromResponse = [self.responseProperties objectForKey:ResponseKey.link];
        link = linkFromResponse ? linkFromResponse : [NSString string];
    }
    
    return link;
}

- (NSDate *)dateTaken {
    NSDate *dateTaken = nil;
    
    if ([self.responseProperties objectForKey:ResponseKey.dateTaken]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        
        NSString *dateStringFromResponse = [self.responseProperties objectForKey:ResponseKey.dateTaken];
        
        NSRange timeMarkRange = [dateStringFromResponse rangeOfString:@"T"];
        NSRange dateRange = NSMakeRange(0, timeMarkRange.location);
        dateStringFromResponse = [dateStringFromResponse substringWithRange:dateRange];
        
        dateTaken = [dateFormatter dateFromString:dateStringFromResponse];
    }
    
    return dateTaken;
}

- (NSString *)description {
    NSString *description = [NSString string];
    
    if ([self.responseProperties objectForKey:ResponseKey.description]) {
        NSString *descriptionFromResponse = [self.responseProperties objectForKey:ResponseKey.description];
        description = descriptionFromResponse  ? descriptionFromResponse : [NSString string];
    }
    
    return description;
}

- (NSString *)tags {
    NSString *tags = [NSString string];
    
    if ([self.responseProperties objectForKey:ResponseKey.tags]) {
        NSString *tagsFromResponse = [self.responseProperties objectForKey:ResponseKey.tags];
        tags = tagsFromResponse ? tagsFromResponse : [NSString string];
    }
    
    return tags;
}

@end
