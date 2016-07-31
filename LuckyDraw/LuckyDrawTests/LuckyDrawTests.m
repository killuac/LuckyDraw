//
//  LuckyDrawTests.m
//  LuckyDrawTests
//
//  Created by Killua Liu on 3/17/16.
//  Copyright © 2016 Syzygy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KLImagePickerViewModel.h"

@interface LuckyDrawTests : XCTestCase

@property (nonatomic, strong) KLImagePickerViewModel *imagePickerViewModel;

@end

@implementation LuckyDrawTests

- (void)setUp
{
    [super setUp];
    self.imagePickerViewModel = [KLImagePickerViewModel new];
}

- (void)tearDown
{
    self.imagePickerViewModel = nil;
    [super tearDown];
}

- (void)testExample
{
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
