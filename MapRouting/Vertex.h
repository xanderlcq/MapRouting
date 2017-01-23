//
//  Vertex.h
//  GraphBasic
//
//  Created by Xander on 1/12/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Vertex : NSObject

@property NSString *value;
@property int distance;
@property Vertex *predecessor;
@property NSString *color;


@property NSMutableArray * adjacentVertices;
@property NSMutableArray * adjacentWeights;

-(id)initWithValue:(NSString *)v;

-(BOOL) containsAdjacent:(Vertex *) vertext;
-(void) addAjacent:(Vertex *) vertext;
-(void) addAjacentWithWeight:(Vertex *) vertext weigh:(NSNumber*) weight;
-(NSNumber *) getWeightTo:(Vertex *) vertex;
@end
