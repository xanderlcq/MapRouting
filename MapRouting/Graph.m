//
//  Graph.m
//  GraphBasic
//
//  Created by Xander on 1/12/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "Graph.h"

@implementation Graph

-(id)init{
    self = [super init];
    if(self) {
        self.vertices = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(BOOL)contains:(NSString *) vertexName{
    return [self getVertex:vertexName] != nil;
}

-(Vertex *)getVertex:(NSString *) vertexName{
    return [self.vertices objectForKey:vertexName];
}

-(void)addVertex:(NSString *) vertexName{
    if(![self contains:vertexName]){
        Vertex * newVertex = [[Vertex alloc] initWithValue:vertexName];
        [self.vertices setObject:newVertex forKey:vertexName];
    }
}

-(void)addVertex:(NSString *) vertexName vertex:(Vertex*)v{
    if(![self contains:vertexName]){
        [self.vertices setObject:v forKey:vertexName];
    }
}


-(void)addBothWayConnection:(NSString *) vertexName1 and:(NSString*) vertexName2{
    [self addBothWayConnectionWithWeight:vertexName1 and:vertexName2 weigh:[NSNumber numberWithInt:0]];
}

-(void)addOneWayConnectionFrom:(NSString *) vertexName1 to:(NSString*) vertexName2{
    [self addOneWayConnectionFromWithWeight:vertexName1 to:vertexName2 weigh:[NSNumber numberWithInt:0]];
}

-(void)addBothWayConnectionWithWeight:(NSString *) vertexName1 and:(NSString*) vertexName2 weigh:(NSNumber *) weight{
    if(![self contains:vertexName1]){
        [self addVertex:vertexName1];
    }
    if(![self contains:vertexName2]){
        [self addVertex:vertexName2];
    }
    Vertex * vertext1 = [self.vertices objectForKey:vertexName1];
    Vertex * vertext2 = [self.vertices objectForKey:vertexName2];
    if(![vertext1 containsAdjacent:vertext2]){
        [vertext1 addAjacentWithWeight:vertext2 weigh:weight];
    }
    if(![vertext2 containsAdjacent:vertext1]){
        [vertext2 addAjacentWithWeight:vertext1 weigh:weight];
    }
}

-(void)addOneWayConnectionFromWithWeight:(NSString *) vertexName1 to:(NSString*) vertexName2 weigh:(NSNumber *) weight{
    if(![self contains:vertexName1]){
        [self addVertex:vertexName1];
    }
    if(![self contains:vertexName2]){
        [self addVertex:vertexName2];
    }
    Vertex * vertext1 = [self.vertices objectForKey:vertexName1];
    Vertex * vertext2 = [self.vertices objectForKey:vertexName2];
    if(![vertext1 containsAdjacent:vertext2]){
        [vertext1 addAjacentWithWeight:vertext2 weigh:weight];
    }
}
-(NSNumber *) getWeightFrom:(NSString *) vertex1 to:(NSString *)vertex2{
    if(![self contains:vertex1] || ![self contains:vertex2])
        return nil;
    Vertex *source = [self getVertex:vertex1];
    Vertex *dest = [self getVertex:vertex2];
    return [source getWeightTo:dest];
}
@end
