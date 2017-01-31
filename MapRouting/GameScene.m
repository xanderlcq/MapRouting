//
//  GameScene.m
//  MapRouting
//
//  Created by Xander on 1/22/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene {
    SKShapeNode *_spinnyNode;
    SKLabelNode *_label;
    MapGraph *graph;
    NSMutableArray *maxRange;
    NSMutableArray *displayRange;
    

    double scale_ratio;
}

- (void)didMoveToView:(SKView *)view {

    DataLoadingProc *dataProc = [[DataLoadingProc alloc] init];
    self.size = NSMakeSize(800, 600);
    graph = [dataProc loadGraphFromTxt:@"test2"];
    Dijkstra *dijkstra = [[Dijkstra alloc] initWithGraph:graph];
    Vertex *start = [graph.vertices objectAtIndex:0];
    //[dijkstra calculatePathsFromStart:start];
    
    
    maxRange = [dataProc findCordRange:graph];
    displayRange = maxRange;
    [displayRange replaceObjectAtIndex:0 withObject:@2000];
    [displayRange replaceObjectAtIndex:1 withObject:@2000];
    [displayRange replaceObjectAtIndex:2 withObject:@5000];
    [displayRange replaceObjectAtIndex:3 withObject:@5000];
    [self renderMap];
}


-(void)renderMap{
    NSLog(@"%@",displayRange);
    int vertexInRange = [self countVertexInRange];
    int increment = vertexInRange < 5000?1:vertexInRange/5000;
    for(int i = 0; i < [graph.vertices count]; i+=increment){
        Vertex *v = [graph.vertices objectAtIndex:i];
        if([self vertexInRange:v in:displayRange]){
            [self customAddChild:v];
        }
    }
}


-(int) countVertexInRange{
    int counter = 0;
    for(Vertex* v in graph.vertices)
        if([self vertexInRange:v in:displayRange])
            counter++;
    return counter;
}

-(BOOL) vertexInRange:(Vertex *) v in:(NSMutableArray *)range{
    return v.x>=[[range objectAtIndex:0] doubleValue]&&v.y>=[[range objectAtIndex:1] doubleValue]&&v.x<=[[range objectAtIndex:2] doubleValue]&&v.y<=[[range objectAtIndex:3] doubleValue];
}
-(void) customAddChild:(Vertex *) v{
    double x = v.x;
    double y = v.y;

    double minX = [[displayRange objectAtIndex:0] doubleValue];
    double minY = [[displayRange objectAtIndex:1] doubleValue];
    double maxX = [[displayRange objectAtIndex:2] doubleValue];
    double maxY = [[displayRange objectAtIndex:3] doubleValue];
    SKShapeNode *node = [SKShapeNode shapeNodeWithEllipseOfSize:CGSizeMake(1, 1)];
    double xRange = maxX - minX;
    double yRange = maxY - minY;
    
    //Get the smallest pixel/unit
    scale_ratio = (self.size.width)/xRange < (self.size.height) / yRange?(self.size.width)/xRange:(self.size.height) / yRange;

    //Shift and shrink
    x = (x-minX)* scale_ratio;
    y = (y-minY)* scale_ratio;
    
    NSLog(@"x:%f, y:%f",x,y);
    node.position = CGPointMake(x, y);
    [self addChild:node];
    
    
}

- (void)touchDownAtPoint:(CGPoint)pos {
    NSLog(@"touchDownAtPoint");
}

- (void)touchMovedToPoint:(CGPoint)pos {
NSLog(@"touchMovedToPoint");
}

- (void)touchUpAtPoint:(CGPoint)pos {
NSLog(@"touchUpAtPoint");
}

- (void)keyDown:(NSEvent *)theEvent {
    switch (theEvent.keyCode) {
        default:
            NSLog(@"keyDown:'%@' keyCode: 0x%02X", theEvent.characters, theEvent.keyCode);
            break;
    }
}

- (void)mouseDown:(NSEvent *)theEvent {
    //NSLog(@"mouseDown");
}
- (void)mouseDragged:(NSEvent *)theEvent {
    //NSLog(@"mouseDragged");
}
- (void)mouseUp:(NSEvent *)theEvent {
    NSLog(@"mouseUp");
    
    NSPoint mouseLoc = [theEvent locationInWindow]; //get current mouse position
    //NSLog(@"Mouse location: %f %f", mouseLoc.x, mouseLoc.y);
    [self mouseClick:mouseLoc.x y:mouseLoc.y];
}

-(void) mouseClick:(double)x y:(double)y{
    //Convert back to coordinates in the graph data
    double minX = [[displayRange objectAtIndex:0] doubleValue];
    double minY = [[displayRange objectAtIndex:1] doubleValue];
    x /= scale_ratio;
    y /= scale_ratio;
    x += minX;
    y += minY;
    NSLog(@"Mouse location: %f %f", x, y);
}


-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

@end
