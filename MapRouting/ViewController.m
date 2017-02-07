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
    scene.scaleMode = SKSceneScaleModeAspectFit;
    // Present the scene
    [self.skView presentScene:scene];
    
    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;

    
        
    
}

- (IBAction)moveDown:(id)sender {
    [(GameScene*)self.skView.scene moveDown];
}
- (IBAction)moveRight:(id)sender {
    [(GameScene*)self.skView.scene moveRight];
}
- (IBAction)moveLeft:(id)sender {
    [(GameScene*)self.skView.scene moveLeft];
}
- (IBAction)moveUp:(id)sender {
    [(GameScene*)self.skView.scene moveUp];
}
- (IBAction)zoomOut:(id)sender {
    NSLog(@"Zoom Out");
    [(GameScene*)self.skView.scene zoomOut];
}
- (IBAction)zoomIn:(id)sender {
    [(GameScene*)self.skView.scene zoomIn];
}


- (IBAction)search:(id)sender {
    [(GameScene*)self.skView.scene search];
}
- (IBAction)setEnd:(id)sender {
    [(GameScene*)self.skView.scene setEndVertex];
}
- (IBAction)setStart:(id)sender {
    [(GameScene*)self.skView.scene setStartVertex];
}

- (IBAction)resetDisplay:(id)sender {
    [(GameScene*)self.skView.scene resetGraphics];
}
- (IBAction)resetHard:(id)sender {
    [(GameScene*)self.skView.scene resetHard];
}

@end
