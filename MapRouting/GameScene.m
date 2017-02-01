//
//  GameScene.m
//  MapRouting
//
//  Created by Xander on 1/22/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene {

    MapGraph *graph;
    
    RectangularRange *maxRange;
    RectangularRange *displayRange;
    double click_error;
    double scale_ratio;
    
    NSMutableArray *displayedPath;
    NSMutableArray *displayedVertex;
    NSMutableArray *clickedVertices;
}

- (void)didMoveToView:(SKView *)view {
    click_error = 30;
    DataLoadingProc *dataProc = [[DataLoadingProc alloc] init];
    self.size = NSMakeSize(800, 600);
    displayedPath = [[NSMutableArray alloc] init];
    graph = [dataProc loadGraphFromTxt:@"usa"];
    Dijkstra *dijkstra = [[Dijkstra alloc] initWithGraph:graph];
    Vertex *start = [graph.vertices objectAtIndex:0];
    //[dijkstra calculatePathsFromStart:start];

    displayRange = [dataProc findCordRange:graph];
    [self renderMap];
    clickedVertices = [[NSMutableArray alloc] init];
}


-(void)renderMap{
    [self removeAllChildren];
    NSLog(@"%@",displayRange);
    int vertexInRange = [self countVertexInRange];
    int increment = vertexInRange < 2000?1:vertexInRange/2000;
    NSLog(@"Plot Density Increment: %i",increment);
    displayedVertex = [[NSMutableArray alloc] init];
    for(int i = 0; i < [graph.vertices count]; i+=increment){
        Vertex *v = [graph.vertices objectAtIndex:i];
        if([self vertexInRange:v in:displayRange]){
            [displayedVertex addObject:v];
            [self customAddChild:v color:[NSColor blackColor]];
        }
    }
    for(Vertex *clicked in clickedVertices){
        if([self vertexInRange:clicked in:displayRange])
            [self customAddChild:clicked color:[NSColor redColor]];
    }
}


-(int) countVertexInRange{
    int counter = 0;
    for(Vertex* v in graph.vertices)
        if([self vertexInRange:v in:displayRange])
            counter++;
    return counter;
}

-(BOOL) vertexInRange:(Vertex *) v in:(RectangularRange *)range{
    return v.x>=range.minX &&v.y>= range.minY &&v.x<= range.maxX&&v.y<=range.maxY;
}

-(SKShapeNode *) customAddChild:(Vertex *) v color:(NSColor *) color{
    if(!v)
        return nil;
    double x = v.x;
    double y = v.y;

    SKShapeNode *node = [SKShapeNode shapeNodeWithEllipseOfSize:CGSizeMake(1, 1)];
    node.fillColor = color;
    node.strokeColor = color;
    double xRange = displayRange.maxX - displayRange.minX;
    double yRange = displayRange.maxY - displayRange.minY;
    
    //Get the smallest pixel/unit
    scale_ratio = (self.size.width)/xRange < (self.size.height) / yRange?(self.size.width)/xRange:(self.size.height) / yRange;

    //Shift and shrink
    x = (x-displayRange.minX)* scale_ratio;
    y = (y-displayRange.minY)* scale_ratio;
    
    //NSLog(@"Plotting: x:%f, y:%f",x,y);
    node.position = CGPointMake(x, y);
    [self addChild:node];
    return node;
    
    
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
    //NSLog(@"Mouse location (og): %f %f", mouseLoc.x, mouseLoc.y);
}

-(void) mouseClick:(double)x y:(double)y{
    //Convert back to coordinates in the graph data
    x = x/scale_ratio + displayRange.minX;
    y = y/scale_ratio + displayRange.minY;
    NSLog(@"Mouse location (converted): %f %f", x, y);
    Vertex *clickedVertex = [self getVertexAt:x y:y];
    NSLog(@"Clicked Vertex: (%f,%f)",clickedVertex.x,clickedVertex.y);
    if(clickedVertex){
        [self customAddChild:clickedVertex color:[NSColor redColor]];
        [clickedVertices addObject:clickedVertex];
    }
}

-(Vertex *) getVertexAt:(double) x y:(double)y{
    for(Vertex *v in displayedVertex)
        if((v.x > x-click_error && v.x < x+click_error)&&(v.y > y-click_error && v.y < y+ click_error))
            return v;
    return nil;
}

-(void) drawPath:(NSMutableArray *)path{
    for(int i =0;i < [path count]-1;i++){
        Vertex *p1 = [path objectAtIndex:i];
        Vertex *p2 = [path objectAtIndex:i+1];
        [displayedPath addObject: [self drawLine:p1.x y1:p1.y x2:p2.x y2:p2.y]];
    }
}

-(SKShapeNode *) drawLine:(double)x1 y1:(double)y1 x2:(double)x2 y2:(double)y2{
    SKShapeNode *line = [SKShapeNode node];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, x1, y1);
    CGPathAddLineToPoint(path, nil, x2, y2);
    [line setPath:path];
    line.lineWidth = 3;
    [self addChild:line];
    return line;
}

-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}
-(void) test{
    NSLog(@"test");
}
-(void)zoomIn{
    [displayRange zoomIn:1.2];
    [self renderMap];
}
-(void)zoomOut{
    [displayRange zoomOut:1.2];
    [self renderMap];
}
-(void)moveDown{
    [displayRange moveRange:0 dy:-300];
    [self renderMap];
}
-(void)moveUp{
    [displayRange moveRange:0 dy:300];
    [self renderMap];
}
-(void)moveRight{
    [displayRange moveRange:150 dy:0];
    [self renderMap];
}
-(void)moveLeft{
    [displayRange moveRange:-150 dy:0];
    [self renderMap];
}
//-(void)setStartVertex;
//-(void)setEndVertex;
//-(void)search;
//-(void)resetPath;
//-(void)resetGraph;
@end
