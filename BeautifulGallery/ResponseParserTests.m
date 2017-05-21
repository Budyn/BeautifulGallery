//
//  ResponseParserTests.m
//  BeautifulGallery
//
//  Created by Daniel Budynski on 21/05/2017.
//  Copyright © 2017 Budyn&Friends. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ResponseParser.h"
@interface ResponseParserTests : XCTestCase
@property (strong, nonatomic) ResponseParser *parser;

@end

@implementation ResponseParserTests

- (void)setUp {
    [super setUp];
    NSDictionary *fakeCorrectResponseProperties = @{
                                                    @"author" : @"johnAppleseed@icloud.com (\"John Apple\")",
                                                    @"published" : @"1994-10-21T05:01:21Z",
                                                    @"author_id" : @"87238937@N78",
                                                    @"title" :  @"Hello world!",
                                                    @"media" : @{@"m" : @"https://linktomedia.com"},
                                                    @"link" : @"https://link.com",
                                                    @"data_taken" : @"2017-12-02T04:21:08Z",
                                                    @"description" : @"Very nice photo!",
                                                    @"tags" : @"nice photo view",
                                                    };
    
    self.parser = [[ResponseParser alloc] initWithResponseProperties:fakeCorrectResponseProperties];
}

- (void)tearDown {
    [super tearDown];
}

// MARK: Correct JSON values tests
- (void)testCorrectAuthorName {
    NSString *authorName = [self.parser authorName];
    XCTAssertTrue([authorName isEqualToString:@"John Apple"], @"Author name parsing fail");
}

- (void)testCorrectAuthorEmail {
    NSString *authorEmail = [self.parser authorEmail];
    XCTAssertTrue([authorEmail isEqualToString:@"johnAppleseed@icloud.com"], @"Author email parsing fail");
}

- (void)testCorrectPublishedDate {
    NSDate *date = [self.parser publishedDate];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSDate *fakeDate = [dateFormatter dateFromString:@"1994-10-21T05:01:21Z"];
    
    XCTAssertTrue([date compare:fakeDate] == NSOrderedSame, @"Published date parsing fail");
}

- (void)testCorrectAuthorID {
    NSString *authorID = [self.parser authorID];
    XCTAssertTrue([authorID isEqualToString:@"87238937@N78"], @"Author ID parsing fail");
}

- (void)testCorrectTitle {
    NSString *title = [self.parser title];
    XCTAssertTrue([title isEqualToString:@"Hello world!"], @"Title parsing fail");
}

- (void)testCorrectMediaDictionary {
    NSDictionary *media = [self.parser media];
    XCTAssertNotNil(media, @"Media dictionary parsing fail");
}

- (void)testCorrectMediaDictionaryKeys {
    NSDictionary *media = [self.parser media];
    XCTAssertNotNil([media objectForKey:@"m"], @"Media dictionary key parsing fail");
}

- (void)testCorrectMediaDictionaryValues {
    NSDictionary *media = [self.parser media];
    XCTAssertTrue([[media objectForKey:@"m"] isEqualToString:@"https://linktomedia.com"], @"Media dictionary value parsing fail");
}

- (void)testCorrectLink {
    NSString *link = [self.parser link];
    XCTAssertTrue([link isEqualToString:@"https://link.com"], @"Link parsing fail");
}

- (void)testCorrectCreationDate {
    NSDate *date = [self.parser dateTaken];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSDate *fakeDate = [dateFormatter dateFromString:@"2017-12-02T04:21:08Z"];
    
    XCTAssertTrue([date compare:fakeDate] == NSOrderedSame, @"Creation date parsing fail");
}

- (void)testCorrectDescription {
    NSString *description = [self.parser description];
    XCTAssertTrue([description isEqualToString:@"Very nice photo!"], @"Description parsing fail");
}

- (void)testCorrectTags {
    NSString *tags = [self.parser tags];
    XCTAssertTrue([tags isEqualToString:@"nice photo view"], @"Tags parsing fail");
}

@end
