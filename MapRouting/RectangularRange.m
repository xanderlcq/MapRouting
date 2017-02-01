//
//  RectangularRange.m
//  MapRouting
//
//  Created by Xander on 1/31/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "RectangularRange.h"

@implementation RectangularRange

-(id) initWithMinX:(double) minX minY:(double)minY maxX:(double)maxX maxY:(double)maxY{
    self = [super init];
    if(self){
        self.minX = minX;
        self.minY = minY;
        self.maxX = maxX;
        self.maxY = maxY;
        self.ogMinX = minX;
        self.ogMinY = minY;
        self.ogMaxX = maxX;
        self.ogMaxY = maxY;
    }
    return self;
}
-(void)zoomIn:(double)scale{
    double oldXRange = self.maxX-self.minX;
    double oldYRange = self.maxY-self.minY;
    double newXRange =(self.maxX-self.minX)/scale;
    double newYRange =(self.maxY-self.minY)/scale;
    if(newXRange<200 || newYRange<200)
        return;
    self.minX += (oldXRange - newXRange)/2;
    self.maxX -= (oldXRange - newXRange)/2;
    self.minY += (oldYRange - newYRange)/2;
    self.maxY -= (oldYRange - newYRange)/2;
}
-(void)zoomOut:(double)scale{
    NSLog(@"Zoom Out");
    NSLog(@"Before minX:%f minY:%f maxX:%f maxY:%f",self.minX,self.minY,self.maxX,self.maxY);
    double oldXRange = self.maxX-self.minX;
    double oldYRange = self.maxY-self.minY;
    double newXRange =(self.maxX-self.minX)*scale;
    double newYRange =(self.maxY-self.minY)*scale;
    if(newXRange>self.ogMaxX-self.ogMinX || newYRange>self.ogMaxY-self.ogMinY){
        [self reset];
        return;
    }
    self.minX += (oldXRange - newXRange)/2;
    self.maxX -= (oldXRange - newXRange)/2;
    self.minY += (oldYRange - newYRange)/2;
    self.maxY -= (oldYRange - newYRange)/2;
    NSLog(@"After minX:%f minY:%f maxX:%f maxY:%f",self.minX,self.minY,self.maxX,self.maxY);
}
-(void)moveRange:(double) dx dy:(double)dy{
    NSLog(@"move dx:%f dy:%f",dx,dy);
    NSLog(@"Before minX:%f minY:%f maxX:%f maxY:%f",self.minX,self.minY,self.maxX,self.maxY);
    double oldXRange = self.maxX-self.minX;
    double oldYRange = self.maxY-self.minY;
    if(dx > 0){//Move right
        if(self.maxX+dx > self.ogMaxX){
            //No
            self.maxX = self.ogMaxX;
            self.minX = self.maxX-oldXRange;
        }else{
            self.maxX += dx;
            self.minX += dx;
        }
        
    }else{//Move left
        if(self.minX+dx < self.ogMinX){
            self.minX = self.ogMinX;
            self.maxX = self.minX+oldXRange;
        }else{
            self.maxX += dx;
            self.minX += dx;
        }
    }
    
    
    if(dy > 0){//Move up
        if(self.maxY+dy > self.ogMaxY){
            //No
            self.maxY = self.ogMaxY;
            self.minY = self.maxY - oldYRange;
        }else{
            self.maxY += dy;
            self.minY += dy;
        }
    }else{//Move down
        if(self.minY+dy < self.ogMinY){
            //No
            self.minY = self.ogMinY;
            self.maxY = self.minY+oldYRange;
        }else{
            self.maxY += dy;
            self.minY += dy;
        }
    }
    NSLog(@"After minX:%f minY:%f maxX:%f maxY:%f",self.minX,self.minY,self.maxX,self.maxY);
}
-(void)reset{
    self.minX = self.ogMinX;
    self.minY = self.ogMinY;
    self.maxX = self.ogMaxX;
    self.maxY = self.ogMaxY;
}
@end
