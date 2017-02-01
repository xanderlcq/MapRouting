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
    double click_error;
    double scale_ratio;
}

- (void)didMoveToView:(SKView *)view {
    click_error = 30;
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
            [self customAddChild:v color:[NSColor blackColor]];
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

-(void) customAddChild:(Vertex *) v color:(NSColor *) color{
    if(!v)
        return;
    double x = v.x;
    double y = v.y;

    double minX = [[displayRange objectAtIndex:0] doubleValue];
    double minY = [[displayRange objectAtIndex:1] doubleValue];
    double maxX = [[displayRange objectAtIndex:2] doubleValue];
    double maxY = [[displayRange objectAtIndex:3] doubleValue];
    SKShapeNode *node = [SKShapeNode shapeNodeWithEllipseOfSize:CGSizeMake(1, 1)];
    node.fillColor = color;
    node.strokeColor = color;
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


- (void)keyDown:(NSEvent *)theEvent {
    switch (theEvent.keyCode) {
        default:
            NSLog(@"keyDown:'%@' keyCode: 0x%02X", theEvent.characters, theEvent.keyCode);
            break;
    }
}

- (void)mouseDragged:(NSEvent *)theEvent {
    //NSLog(@"mouseDragged");
}
- (void)mouseUp:(NSEvent *)theEvent {
    NSPoint mouseLoc = [theEvent locationInWindow];
    [self mouseClick:mouseLoc.x y:mouseLoc.y];
}

-(void) mouseClick:(double)x y:(double)y{
    //Convert back to coordinates in the graph data
    double minX = [[displayRange objectAtIndex:0] doubleValue];
    double minY = [[displayRange objectAtIndex:1] doubleValue];
    x = x/scale_ratio + minX;
    y = y/scale_ratio + minY;
    NSLog(@"Mouse location (converted): %f %f", x, y);
    Vertex *clickedVertex = [self getVertexAt:x y:y];
    NSLog(@"Clicked Vertex: (%f,%f)",clickedVertex.x,clickedVertex.y);
    [self customAddChild:clickedVertex color:[NSColor redColor]];
}

-(Vertex *) getVertexAt:(double) x y:(double)y{
    for(Vertex *v in graph.vertices){
        if((v.x > x-click_error && v.x < x+click_error)&&(v.y > y-click_error && v.y < y+ click_error)){
            return v;
        }
    }
    return nil;
}

-(void) drawPath:(NSMutableArray *)path{
    for(int i =0;i < [path count]-1;i++){
        Vertex *p1 = [path objectAtIndex:i];
        Vertex *p2 = [path objectAtIndex:i+1];
        [self drawLine:p1.x y1:p1.y x2:p2.x y2:p2.y];
    }
}

-(void) drawLine:(double)x1 y1:(double)y1 x2:(double)x2 y2:(double)y2{
    SKShapeNode *line = [SKShapeNode node];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, x1, y1);
    CGPathAddLineToPoint(path, nil, x2, y2);
    [line setPath:path];
    line.lineWidth = 3;
    [self addChild:line];
}

-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

@end
