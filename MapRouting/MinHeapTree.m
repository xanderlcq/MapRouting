//
//  MinHeapTree.m
//  MapRouting
//
//  Created by Xander on 1/22/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "MinHeapTree.h"

@implementation MinHeapTree
// Parent at i/2
// Left child at 2i
// Right child at 2i+1
-(id) init{
    self = [super init];
    if(self) {
        self.data = [[NSMutableArray alloc] init];
        self.currentIndex = 1;
        [self.data addObject:@"nil"];
    }
    return self;
}
-(id) initWithObjectFromArray:(NSArray *) arr{
    self = [super init];
    if(self) {
        self.data = [[NSMutableArray alloc] init];
        self.currentIndex = 1;
        [self.data addObject:@"nil"];
        for(int i = 0; i < [arr count];i++){
            [self insertVertex:[arr objectAtIndex:i]];
        }
    }
    return self;
}
-(void) insertVertex:(Vertex *) v{
    //Add the object at the next empty hole on the tree, then heapify it
    if(self.currentIndex == 1){
        [self.data insertObject:v atIndex:self.currentIndex++];
        return;
    }
    [self.data insertObject:v atIndex:self.currentIndex++];
    [self bubble];
}
-(void) deleteVertex:(Vertex *) v{
    for(int i = 1; i < self.currentIndex;i++){
        if(v== [self.data objectAtIndex:i]){
            [self.data replaceObjectAtIndex:i withObject:[self.data objectAtIndex:self.currentIndex-1]];
            [self.data removeObjectAtIndex:self.currentIndex-1];
            self.currentIndex--;
            [self sink:i];
            return;
        }
    }
}
-(Vertex *) getMin{
    if(self.currentIndex == 1)
        return nil;
    Vertex *min = [self.data objectAtIndex:1];
    [self.data replaceObjectAtIndex:1 withObject:[self.data objectAtIndex:self.currentIndex-1]];
    [self.data removeObjectAtIndex:self.currentIndex-1];
    self.currentIndex--;
    [self sink:1];
    return min;
}

-(void)sink:(int)current{
    //Swap current with the smallest child
    
    
    int smallerChild = current;
    //Check if current is greater than left
    if(current*2 < self.currentIndex && [self compare:smallerChild isGreaterThan:current*2])
        smallerChild = current * 2;

    //Check if current is greater than right
    if(current*2+1 < self.currentIndex && [self compare:smallerChild isGreaterThan:current*2+1])
        smallerChild = current * 2+1;

    //Both children are bigger or out of bound
    if(smallerChild == current)
        return;
    [self swap:smallerChild with:current];
    [self sink:smallerChild];
}

//Called after insert, bubble the new value to correct position
-(void)bubble{
    int index = self.currentIndex-1;
    while(index>1 && [self compare:index/2 isGreaterThan:index]){
        //While the parrent is greater then the child, swap them
        [self swap:index with:index/2];
        index = index/2;
    }
}

-(void) swap:(int) a with:(int) b{
    [self.data exchangeObjectAtIndex:a withObjectAtIndex:b];
}

-(BOOL) compare:(int) index1 isGreaterThan:(int)index2{
    return ((Vertex *)[self.data objectAtIndex:index1]).distance> ((Vertex *)[self.data objectAtIndex:index2]).distance;
}

-(BOOL) contains:(Vertex *) v{
    return [self.data containsObject:v];
}

-(NSString *) toString{
    NSMutableArray *stringArray = [[NSMutableArray alloc] init];
    for(int i = 1; i < self.currentIndex;i++){
        [stringArray addObject:[NSNumber numberWithInt:((Vertex*)[self.data objectAtIndex:i]).value]];
    }
    return [stringArray componentsJoinedByString:@","];
}

-(void) print{
    NSLog(@"Current Index: %i", self.currentIndex);
    NSLog(@"%@",[self toString]);
}
@end
