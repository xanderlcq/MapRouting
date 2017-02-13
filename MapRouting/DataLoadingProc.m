//
//  DataLoadingProc.m
//  MapRouting
//
//  Created by Xander on 1/25/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "DataLoadingProc.h"

@implementation DataLoadingProc
-(MapGraph *)loadGraphFromTxt:(NSString *) fileName{
    MapGraph *mapGraph = [[MapGraph alloc] init];
    NSString* path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
    NSError *errorReading;
    if(errorReading){
        NSLog(@"Reading error  %@",errorReading);
        return nil;
    }
    NSArray *linesOfText = [[NSString stringWithContentsOfFile:path
                                                      encoding:NSUTF8StringEncoding
                                                         error:&errorReading]
                            componentsSeparatedByString:@"\n"];
    
    int secondPartStart = 0;
    for(int i = 0; i < [linesOfText count]-1;i++){
        
        if([[linesOfText objectAtIndex:i] isEqualToString:@""]){
            secondPartStart = i+1;
            break;
        }
        NSArray *array = [[linesOfText objectAtIndex:i] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        array = [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
        int vertexID = [[array objectAtIndex:0] intValue];
        Vertex *vertex =[[Vertex alloc] initWithValue:vertexID x:[[array objectAtIndex:1] doubleValue] y:[[array objectAtIndex:2] doubleValue]];
        [mapGraph addVertex:vertexID vertex:vertex];
    }

    for(int i = secondPartStart; i < [linesOfText count]-1;i++){
        if([[linesOfText objectAtIndex:i] isEqualToString:@""])
            break;
        NSArray *array = [[linesOfText objectAtIndex:i] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        array = [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
        
        int edgeFrom = [[array objectAtIndex:0] intValue];
        int edgeTo = [[array objectAtIndex:1] intValue];

        double weight = [self distanceBetween:[mapGraph getVertex:edgeFrom] and:[mapGraph getVertex:edgeTo]];
        [mapGraph connectedVertex:edgeFrom with:edgeTo weight:[NSNumber numberWithDouble:weight]];
    }
    //return graph;
    return mapGraph;
}
-(double) distanceBetween:(Vertex *)v1 and:(Vertex *)v2{
    double x1 = v1.x;
    double y1 = v1.y;
    double x2 = v2.x;
    double y2 = v2.y;
    double dis = sqrt(fabs((x1-x2)*(x1-x2)) + fabs((y1-y2)*(y1-y2)));
    return dis;
}

-(RectangularRange*)findCordRange:(MapGraph*)graph{
    int minX = INT_MAX;
    int minY = INT_MAX;
    int maxX = INT_MIN;
    int maxY = INT_MIN;
    for(Vertex *v in graph.vertices){
        if(v.x < minX)
            minX = v.x;
        if(v.y < minY)
            minY = v.y;
        if(v.x > maxX)
            maxX = v.x;
        if(v.y > maxY)
            maxY = v.y;
    }
    return [[RectangularRange alloc] initWithMinX:minX minY:minY maxX:maxX maxY:maxY];
}


@end
