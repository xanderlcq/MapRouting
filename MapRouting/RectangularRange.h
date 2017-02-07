//
//  RectangularRange.h
//  MapRouting
//
//  Created by Xander on 1/31/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RectangularRange : NSObject
@property double minX;
@property double minY;
@property double maxX;
@property double maxY;

@property double ogMinX;
@property double ogMinY;
@property double ogMaxX;
@property double ogMaxY;

-(id) initWithMinX:(double) minX minY:(double)minY maxX:(double)maxX maxY:(double)maxY;
-(void)zoomIn:(double)scale;
-(void)zoomOut:(double)scale;
-(void)moveRange:(double) dx dy:(double)dy;
-(void)reset;
-(NSString *)description;
@end
