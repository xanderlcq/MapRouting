//
//  MapGraph.h
//  MapRouting
//
//  Created by Xander on 1/26/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vertex.h"
@interface MapGraph : NSObject
@property NSMutableArray *vertices;

-(id) init;
-(void) addVertex:(int) vertexIndex vertex:(Vertex*)v;
-(BOOL) contains:(int) vertexIndex;
-(void) connectedVertex:(int) vertex1 with:(int) vertex2 weight:(NSNumber *) weight;
-(Vertex *) getVertex:(int) vertexIndex;
-(NSNumber *) getWeightFrom:(int) vertex1 to:(int)vertex2;
-(void) reset;
@end
