//
//  Dijkstra.h
//  MapRouting
//
//  Created by Xander on 1/30/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapGraph.h"
#import "Vertex.h"
#import "PriorityQueue.h"
@interface Dijkstra : NSObject

@property MapGraph *graph;
@property Vertex *start;
@property PriorityQueue *queue;
-(id) initWithGraph:(MapGraph *) graph;
-(NSMutableArray *)calculatePathsFromStart:(Vertex *) start to:(Vertex*)target;
@end
