//
//  DataLoadingProc.h
//  MapRouting
//
//  Created by Xander on 1/25/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapGraph.h"
@interface DataLoadingProc : NSObject
-(MapGraph *)loadGraphFromTxt:(NSString *) fileName;
-(NSMutableArray*)findCordRange:(MapGraph*)graph;
@end
