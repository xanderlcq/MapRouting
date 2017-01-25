//
//  DataLoadingProc.m
//  MapRouting
//
//  Created by Xander on 1/25/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "DataLoadingProc.h"

@implementation DataLoadingProc
-(Graph *)loadGraphFromTxt:(NSString *) fileName{
    Graph *graph = [[Graph alloc] init];
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
        NSString *curLine =[linesOfText objectAtIndex:i];
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\s*(\\d*)\\s*(\\d*)\\s*(\\d*)"
                                                                                        options:NSRegularExpressionCaseInsensitive error:nil];
        NSArray *matches = [regex matchesInString:curLine
                                                   options:0
                                                     range:NSMakeRange(0, [curLine length])];
        NSTextCheckingResult *match  = [matches objectAtIndex:0];
        NSString *vertexID = [curLine substringWithRange:[match rangeAtIndex:1]];
        double x= [[curLine substringWithRange:[match rangeAtIndex:2]] doubleValue];
        double y = [[curLine substringWithRange:[match rangeAtIndex:3]] doubleValue];
        Vertex *vertex =[[Vertex alloc] initWithValue:vertexID x:x y:y];
        [graph addVertex:vertexID vertex:vertex];
    }
    
    for(int i = secondPartStart; i < [linesOfText count]-1;i++){
        if([[linesOfText objectAtIndex:i] isEqualToString:@""])
            break;
        NSString *curLine =[linesOfText objectAtIndex:i];
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\s*(\\d*)\\s*(\\d*)"
                                                                               options:NSRegularExpressionCaseInsensitive error:nil];
        NSArray *matches = [regex matchesInString:curLine
                                          options:0
                                            range:NSMakeRange(0, [curLine length])];
        NSTextCheckingResult *match  = [matches objectAtIndex:0];
        NSString *edgeFrom = [curLine substringWithRange:[match rangeAtIndex:1]];
        NSString *edgeTo = [curLine substringWithRange:[match rangeAtIndex:2]];
        if(![graph contains:edgeFrom] || ![graph contains:edgeTo])
            [NSException raise:@"one of the vertices of the edge does not exist" format:@"v1: %@, v2:%@", edgeFrom,edgeTo];
        double weight = [self distanceBetween:[graph getVertex:edgeFrom] and:[graph getVertex:edgeTo]];
        NSLog(@"%f",weight);
        [graph addOneWayConnectionFromWithWeight:edgeFrom to:edgeTo weigh:[NSNumber numberWithDouble:weight]];
    }
    return graph;
}
-(double) distanceBetween:(Vertex *)v1 and:(Vertex *)v2{
    double x1 = v1.x;
    double y1 = v1.y;
    double x2 = v2.x;
    double y2 = v2.y;
    NSLog(@"x1:%f,x2:%f,y1:%f,y2:%f",x1,x2,y1,y2);
    double dis = sqrt(fabs((x1-x2)*(x1-x2)) + fabs((y1-y2)*(y1-y2)));
    return dis;
}
@end
