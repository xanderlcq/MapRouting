//
//  DataLoadingProc.h
//  MapRouting
//
//  Created by Xander on 1/25/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Graph.h"
@interface DataLoadingProc : NSObject
-(Graph *)loadGraphFromTxt:(NSString *) fileName;
@end
