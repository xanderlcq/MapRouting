//
//  MinHeapTree.h
//  MapRouting
//
//  Created by Xander on 1/22/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vertex.h"
@interface MinHeapTree : NSObject
@property int currentIndex;
@property NSMutableArray *data;
-(id) init;
-(id) initWithObjectFromArray:(NSArray *) arr;
-(void) insertVertex:(Vertex *) v;
//-(void) deleteVertex:(Vertex *) v;
-(Vertex *) getMin;
-(NSString *) toString;
-(void) print;
@end
