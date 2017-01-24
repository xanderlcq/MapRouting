//
//  ViewController.m
//  MapRouting
//
//  Created by Xander on 1/22/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "ViewController.h"
#import "GameScene.h"
#import "MinHeapTree.h"
#import "Vertex.h"
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Load the SKScene from 'GameScene.sks'
    GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];
    
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene
    [self.skView presentScene:scene];
    
    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
//    MinHeapTree *mht = [[MinHeapTree alloc] init];
//    //NSMutableArray *original = [[NSMutableArray alloc] init];
//    for(int i = 0;i < 15;i++){
//        int n = arc4random()%50;
//        Vertex *v = [[Vertex alloc] initWithValue:[NSString stringWithFormat:@"%i",n]];
//        v.distance = n;
//        [mht insertVertex:v];
//        
//    }
//    NSLog(@"og:");
//    [mht print];
//     NSLog(@"\n");
//    for(int i = 0;i < 15; i ++){
//        NSLog(@"%@",[mht getMin].value);
//        [mht print];
//    }
}

@end
