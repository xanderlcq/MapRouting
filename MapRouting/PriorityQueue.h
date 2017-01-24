//
//  PriorityQueue.h
//  MapRouting
//
//  Created by Xander on 1/22/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vertex.h"
@interface PriorityQueue : NSObject
-(id) init;
-(void) insert:(Vertex *) v;
-(Vertex *) popMin;
@end
