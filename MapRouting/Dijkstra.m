//
//  Dijkstra.m
//  MapRouting
//
//  Created by Xander on 1/30/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "Dijkstra.h"

@implementation Dijkstra

-(id) initWithGraph:(MapGraph *) graph{
    self = [super init];
    if(self) {
        self.graph = graph;
    }
    return self;
}


-(NSMutableArray *)getShortestPathTo:(Vertex *) target{
    NSMutableArray *path = [[NSMutableArray alloc] init];
    while(target){
        [path insertObject:target atIndex:0];
        target = target.predecessor;
    }
    return path;
}

-(NSMutableArray *)calculatePathsFromStart:(Vertex *) start to:(Vertex*)target{
    self.start = start;
    self.start.distance = 0;
    self.queue = [[PriorityQueue alloc] init];
    [self.queue enqueue:self.start];
    
    
    while(![self.queue isEmpty]){
        
        Vertex *minVertex = [self.queue dequeue];
        minVertex.visited = YES;
        if(target == minVertex)
            return [self getShortestPathTo:target];
        
        NSLog(@"Dequeued : (X:%f,Y:%f)",minVertex.x,minVertex.y);
        
        for(int i = 0;i<[minVertex.adjacentVertices count];i++){
            Vertex *neighbor = [minVertex.adjacentVertices objectAtIndex:i];
            
            if(!neighbor.visited){
                if(neighbor.distance > minVertex.distance+[[minVertex.adjacentWeights objectAtIndex:i] intValue]){
                    
                    neighbor.distance = minVertex.distance+[[minVertex.adjacentWeights objectAtIndex:i] intValue];
                    neighbor.predecessor = minVertex;
                    NSLog(@"----Lower distance to (X:%f,Y:%f) to: %f",neighbor.x,neighbor.y,neighbor.distance);
                }
                if(![self.queue contains:neighbor]){
                    [self.queue enqueue:neighbor];
                    NSLog(@"Enqueued : (X:%f,Y:%f)",neighbor.x,neighbor.y);
                }
            }
        }
    }
    return nil;
}

@end
