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
#import "DataLoadingProc.h"
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
    DataLoadingProc *temp = [[DataLoadingProc alloc] init];
    [temp loadGraphFromTxt:@"usa"];
        
    
}

@end
