//
//  GameScene.h
//  MapRouting
//
//  Created by Xander on 1/22/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DataLoadingProc.h"
#import "MapGraph.h"
#import "DataLoadingProc.h"
#import "Dijkstra.h"
#import "RectangularRange.h"
@interface GameScene : SKScene

-(void)zoomIn;
-(void)zoomOut;
-(void)moveLeft;
-(void)moveRight;
-(void)moveUp;
-(void)moveDown;
-(void)setStartVertex;
-(void)setEndVertex;
-(void)search;
-(void)resetPath;
-(void)resetGraph;

@end
