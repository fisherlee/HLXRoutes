//
//  HLXRoutesTests.m
//  HLXRoutesTests
//
//  Created by lee on 2019/5/14.
//  Copyright © 2019 lee. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface HLXRoutesTests : XCTestCase

@end

@implementation HLXRoutesTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testURLRule {
	NSString *scheme = @"https";
	NSString *str = @"/user/1/?title='abc'&imgUrl='https://pics4.baidu.com/feed/c8177f3e6709c93d628fde106a302ad8d00054ee.jpeg?token=170e1a64440cfce6e76c468eee7cd7de&s=9728FE056BB1C8C24A0BD06F0300B07B'/post/200";
	NSString *urlStr = [NSString stringWithFormat:@"%@://%@", scheme, str];
	
	NSString *result1 = [self find:str];
	NSString *result2 = [self find:urlStr];
}

- (NSString *)find:(NSString *)urlStr
{
	NSString *result = @"";
	
	NSURL *url = [NSURL URLWithString:urlStr];
	NSLog(@"url: %@", url);
	NSLog(@"url.scheme: %@", url.scheme);
	NSLog(@"url.query: %@", url.query);
	NSLog(@"url.path: %@", url.path);
	return result;
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
