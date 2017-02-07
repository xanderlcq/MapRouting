//
//  Vertex.m
//  GraphBasic
//
//  Created by Xander on 1/12/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "Vertex.h"

@implementation Vertex

-(id)initWithValue:(int)v x:(double)x y:(double)y{
    self = [super init];
    if(self){
        self.value = v;
        self.adjacentWeights = [[NSMutableArray alloc] init];
        self.adjacentVertices = [[NSMutableArray alloc] init];
        self.distance = INT_MAX;
        self.predecessor = nil;
        self.x = x;
        self.y = y;
         self.visited = NO;
    }
    return self;
}
-(void) addAjacent:(Vertex *) vertext{
    [self.adjacentVertices addObject:vertext];
    [self.adjacentWeights addObject:[NSNumber numberWithInt:-1]];
}
-(void) addAjacentWithWeight:(Vertex *) vertext weigh:(NSNumber*) weight{
    [self.adjacentVertices addObject:vertext];
    [self.adjacentWeights addObject:weight];
}
-(BOOL) containsAdjacent:(Vertex *)vertext{
    return [self.adjacentVertices containsObject:vertext];
}

-(NSNumber *) getWeightTo:(Vertex *) vertex{
    if(![self containsAdjacent:vertex])
        return nil;
    return [self.adjacentWeights objectAtIndex:[self.adjacentVertices indexOfObject:vertex]];
}
-(NSString *)description{
    return [NSString stringWithFormat:@"Vertex: Value: %i x:%f,y:%f",self.value,self.x,self.y];
}
@end
