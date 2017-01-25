//
//  Graph.h
//  GraphBasic
//
//  Created by Xander on 1/12/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vertex.h"
@interface Graph : NSObject

@property NSMutableDictionary<NSString *, Vertex *> * vertices;



-(id)init;

/**
 Add a vertex to the graph with name

 @param vertexName The name/value of the vertext
 */
-(void)addVertex:(NSString *) vertexName;


/**
 Add a vertex to the graph with name and vertex

 @param vertexName The name/value of the vertex and the premade vertex
 */
-(void)addVertex:(NSString *) vertexName vertex:(Vertex*)v;


/**
 Add an TWO way edge between two vertices (weigh 0)

 @param vertexName1 first vertex
 @param vertexName2 second vertex
 */
-(void)addBothWayConnection:(NSString *) vertexName1 and:(NSString*) vertexName2;

/**
 Add an ONE way edge from the first vertext to the second two vertex (weigh 0)
 
 @param vertexName1 first vertex (from/source)
 @param vertexName2 second vertex (to/destination)
 */
-(void)addOneWayConnectionFrom:(NSString *) vertexName1 to:(NSString*) vertexName2;


/**
 Add an Weighted TWO way edge between two vertices

 @param vertexName1 first vertex
 @param vertexName2 second vertex
 @param weight      the weight of the edge
 */
-(void)addBothWayConnectionWithWeight:(NSString *) vertexName1 and:(NSString*) vertexName2 weigh:(NSNumber *) weight;


/**
 Add an weighted ONE way edge from the first vertext to the second two vertex

 @param vertexName1 first vertex (from/source)
 @param vertexName2 second vertex (to/destination)
 @param weight      the weight of the edge
 */
-(void)addOneWayConnectionFromWithWeight:(NSString *) vertexName1 to:(NSString*) vertexName2 weigh:(NSNumber *) weight;


/**
 Check if the graph contains a vertex with name;

 @param vertexName Name of the vertex to be checked

 @return YES if the graph contains a vertex with name;
 */
-(BOOL)contains:(NSString *) vertexName;


/**
 Get the vertex with name

 @param vertexName name of the vertext

 @return return the vertex, nil if it doesn't exist
 */
-(Vertex *)getVertex:(NSString *) vertexName;


/**
 Get the weight from first vertex to second vertex

 @param vertex1 first vertex
 @param vertex2 second vertex

 @return return the weight of the edge, nil if either vertices doesn't exist or they are not connected
 */
-(NSNumber *) getWeightFrom:(NSString *) vertex1 to:(NSString *)vertex2;

@end
