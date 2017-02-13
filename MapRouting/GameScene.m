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
    
    RectangularRange *displayRange;
    double click_error;
    double scale_ratio;
    
    
    NSMutableArray *displayedVertices;
    NSMutableArray *shortestPath;
    Vertex *startVertex;
    Vertex *targetVertex;
    
    int mode;
    // 0 - pending
    // 1 - setting start
    // 2 - setting end
}

- (void)didMoveToView:(SKView *)view {
    mode = 0;
    click_error = 30;
    DataLoadingProc *dataProc = [[DataLoadingProc alloc] init];
    self.size = NSMakeSize(800, 600);

    graph = [dataProc loadGraphFromTxt:@"usa"];
    displayRange = [dataProc findCordRange:graph];
    [self renderMap];
}

//========== User interaction Function============
- (void)mouseDragged:(NSEvent *)theEvent {
    [self updateScaleRatio];
    CGFloat dx = [theEvent deltaX]/scale_ratio;
    CGFloat dy = [theEvent deltaY]/scale_ratio;
    NSLog(@"Mouse Dragged: dx: %f, dy:%f",-dx,dy);
    [displayRange moveRange:-dx dy:dy];
    [self updateScaleRatio];

}

- (void)mouseUp:(NSEvent *)theEvent {
    NSPoint mouseLoc = [theEvent locationInWindow];
    [self mouseClick:mouseLoc.x y:mouseLoc.y];
    [self renderMap];
}

-(void) mouseClick:(double)x y:(double)y{
    if(mode == 0)
        return;
    
    //Convert back to coordinates in the graph data
    x = x/scale_ratio + displayRange.minX;
    y = y/scale_ratio + displayRange.minY;
    NSLog(@"Mouse Up (converted): %f %f", x, y);
    
    Vertex *clickedVertex = [self getVertexAt:x y:y];
    if(mode == 1){
        if(clickedVertex){
            startVertex = clickedVertex;
        }
    }
    if(mode == 2){
        if(clickedVertex){
            targetVertex = clickedVertex;
        }
    }
}

//=========== Display Helper Function=============
-(void) updateScaleRatio{
    double xRange = displayRange.maxX - displayRange.minX;
    double yRange = displayRange.maxY - displayRange.minY;
    
    //Get the smallest pixel/unit
    scale_ratio = (self.size.width)/xRange < (self.size.height) / yRange?(self.size.width)/xRange:(self.size.height) / yRange;
}

-(void)renderMap{
    [self updateScaleRatio];
    [self removeAllChildren];
    NSLog(@"%@",displayRange);
    int vertexInRange = [self countVertexInRange];
    int increment = vertexInRange < 2000?1:vertexInRange/2000;
    NSLog(@"Plot Density Increment: %i",increment);
    displayedVertices = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < [graph.vertices count]; i+=increment){
        Vertex *v = [graph.vertices objectAtIndex:i];
        if([self vertexInRange:v in:displayRange]){
            [displayedVertices addObject:v];
            [self customAddChild:v color:[NSColor blackColor] size:1];
        }
    }
    if(startVertex)
        [self customAddChild:startVertex color:[NSColor greenColor] size:4];
    if(targetVertex)
        [self customAddChild:targetVertex color:[NSColor blueColor] size:4];
    if(shortestPath)
        [self drawPath:shortestPath];
}

-(void) drawPath:(NSMutableArray *)path{
    [self updateScaleRatio];
    for(int i =0;i < [path count]-1;i++){
        Vertex *p1 = [path objectAtIndex:i];
        Vertex *p2 = [path objectAtIndex:i+1];
        if([self vertexInRange:p1 in:displayRange]||[self vertexInRange:p1 in:displayRange]){
            [self drawLine:(p1.x-displayRange.minX)*scale_ratio y1:(p1.y-displayRange.minY)*scale_ratio x2:(p2.x-displayRange.minX)*scale_ratio y2:(p2.y-displayRange.minY)*scale_ratio];
        }
    }
}

-(SKShapeNode *) drawLine:(double)x1 y1:(double)y1 x2:(double)x2 y2:(double)y2{
    SKShapeNode *line = [SKShapeNode node];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, x1, y1);
    CGPathAddLineToPoint(path, nil, x2, y2);
    [line setPath:path];
    line.lineWidth = 2;
    line.fillColor = [NSColor redColor];
    line.strokeColor = [NSColor redColor];
    [self addChild:line];
    return line;
}

-(SKShapeNode *) customAddChild:(Vertex *) v color:(NSColor *) color size:(int)r{
    if(!v)
        return nil;
    double x = v.x;
    double y = v.y;
    
    SKShapeNode *node = [SKShapeNode shapeNodeWithEllipseOfSize:CGSizeMake(r, r)];
    node.fillColor = color;
    node.strokeColor = color;
    [self updateScaleRatio];
    
    //Shift and shrink
    x = (x-displayRange.minX)* scale_ratio;
    y = (y-displayRange.minY)* scale_ratio;
    
    //NSLog(@"Plotting: x:%f, y:%f",x,y);
    node.position = CGPointMake(x, y);
    [self addChild:node];
    return node;
}

//========== Pure Helper Function=================
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

-(Vertex *) getVertexAt:(double) x y:(double)y{
    for(Vertex *v in displayedVertices)
        if((v.x > x-click_error && v.x < x+click_error)&&(v.y > y-click_error && v.y < y+ click_error))
            return v;
    return nil;
}

//========== View Controller Calls these functions=================
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
-(void)setStartVertex{
    mode = 1;
}
-(void)setEndVertex{
    mode = 2;
}
-(void)search{
    if(startVertex && targetVertex){
        Dijkstra *dijkstra = [[Dijkstra alloc] initWithGraph:graph];
        shortestPath = [dijkstra calculatePathsFromStart:startVertex to:targetVertex];
        NSLog(@"%@",shortestPath);
        [self drawPath:shortestPath];
    }
}
-(void)resetHard{
    [graph reset];
    startVertex = nil;
    targetVertex = nil;
    shortestPath = nil;
    [displayRange reset];
    [self renderMap];
    mode = 0;
}

-(void)resetGraphics{
    [displayRange reset];
    [self renderMap];
}
@end
