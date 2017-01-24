//
//  PriorityQueue.m
//  MapRouting
//
//  Created by Xander on 1/22/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "PriorityQueue.h"

@implementation PriorityQueue
-(id) init{
    self = [super init];
    if(self) {
        self.minHeap = [[MinHeapTree alloc] init];
    }
    return self;
}
-(void) insert:(Vertex *) v{
    [self.minHeap insertVertex:v];
}
-(Vertex *) popMin{
    return [self.minHeap getMin];
}
@end
