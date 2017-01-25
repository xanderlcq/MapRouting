//
//  PriorityQueue.h
//  MapRouting
//
//  Created by Xander on 1/22/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vertex.h"
#import "MinHeapTree.h"
@interface PriorityQueue : NSObject

@property MinHeapTree *minHeap;

-(id) init;
-(void) enqueue:(Vertex *) v;
-(Vertex *) dequeue;
-(BOOL) contains:(Vertex *) v;
@end
