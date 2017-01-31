//
//  MapRoutingTests.m
//  MapRoutingTests
//
//  Created by Xander on 1/22/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MinHeapTree.h"
#import "Vertex.h"
@interface MapRoutingTests : XCTestCase

@end

@implementation MapRoutingTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {

    
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

-(void) testMinHeapTree{
    //Sequential Values
    MinHeapTree *mht = [[MinHeapTree alloc] init];
    for(int i = 0;i < 15;i++){
        Vertex *v = [[Vertex alloc] initWithValue:i];
        v.distance = i;
        [mht insertVertex:v];
    }
    XCTAssert([[mht toString] isEqualToString:@"0,1,2,3,4,5,6,7,8,9,10,11,12,13,14"]);
 
    
    //Random Values
    mht = [[MinHeapTree alloc] init];
    for(int i = 0;i < 50;i++){
        int n = arc4random()%50;
        Vertex *v = [[Vertex alloc] initWithValue:i];
        v.distance = n;
        [mht insertVertex:v];
        
    }
    BOOL result = YES;
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;

    Vertex *prev = [mht getMin];
    for(int i = 0;i < 48; i ++){
        Vertex *current = [mht getMin];
        if(prev.distance > current.distance){
            result = NO;
            break;
        }
        prev = current;
    }
    XCTAssert(result);
}
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


@end
