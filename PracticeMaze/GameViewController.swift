//
//  GameViewController.swift
//  PracticeMaze
//
//  Created by Jiajun's Computer on 6/24/20.
//  Copyright © 2020 Jiajun Yan. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    var building = 1
    var level = 1
    var gScene = GameScene()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .resizeFill
                
                // Present the scene
                view.presentScene(scene)
                
                gScene = scene as! GameScene
                gScene.setUpLevel(b: building, l: level)
                gScene.backgroundColor = .black
                
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    @IBAction func back(_ sender: Any) {
        let levelVC = self.storyboard?.instantiateViewController(identifier: "levelVC") as! LevelSelectViewController
        gScene.physicsWorld.speed = 0
        gScene.resetScene(deleteEveryThing: true)
        self.navigationController?.pushViewController(levelVC, animated: true)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
