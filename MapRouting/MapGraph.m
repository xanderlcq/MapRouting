//
//  MapGraph.m
//  MapRouting
//
//  Created by Xander on 1/26/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "MapGraph.h"

@implementation MapGraph{
    Vertex *placeHolder;
}

-(id) init{
    self = [super init];
    if(self) {
        self.vertices = [[NSMutableArray alloc] init];
        placeHolder = [[Vertex alloc] initWithValue:-999 x:-999 y:-999];
    }
    return self;
}
-(void) addVertex:(int) vertexIndex vertex:(Vertex*)v{
    [self.vertices insertObject:v atIndex:vertexIndex];
}

-(BOOL) contains:(int) vertexIndex{
    return [self getVertex:vertexIndex]!=nil;
}

-(void) connectedVertex:(int) vertex1 with:(int) vertex2 weight:(NSNumber *) weight{
    if(![self getVertex:vertex1] || ![self getVertex:vertex2])
        [NSException raise:@"one of the vertices of the edge does not exist" format:@"v1: %d, v2:%d", vertex1,vertex2];
    Vertex *v1 = [self getVertex:vertex1];
    Vertex *v2 = [self getVertex:vertex2];
    [v1 addAjacentWithWeight:v2 weigh:weight];
    [v2 addAjacentWithWeight:v1 weigh:weight];
}

-(Vertex *) getVertex:(int) vertexIndex{
    if(vertexIndex < 0 || vertexIndex >= [self.vertices count]||([self.vertices objectAtIndex:vertexIndex]==placeHolder))
        return nil;
    return [self.vertices objectAtIndex:vertexIndex];
}

-(NSNumber *) getWeightFrom:(int) vertex1 to:(int)vertex2{
    return nil;
}
-(void) reset{
    for(Vertex *v in self.vertices){
        v.visited = NO;
        v.predecessor = nil;
        v.distance = INT_MAX;
    }
}
@end
