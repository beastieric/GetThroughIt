//
//  GameScene.swift
//  PracticeMaze
//
//  Created by Jiajun's Computer on 6/24/20.
//  Copyright © 2020 Jiajun Yan. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    var build = 1
    var level = 1
    var startNode = SKShapeNode()
    var endNode = SKShapeNode()
    let manager = CMMotionManager()
    var player = SKShapeNode(circleOfRadius: 50)
    let edgeRect = CGRect(x: -UIScreen.main.bounds.height*2/5, y: -UIScreen.main.bounds.height*2/5, width: UIScreen.main.bounds.height*4/5, height: UIScreen.main.bounds.height*4/5)
    var timeSinceLoad = 0.0
    var playerPos = CGPoint()
    var mapSize = 0
    var fell = false
    let max = [5,20,6]

    override func didMove(to view: SKView) {
        //setUpLevel(b: 2, l: 3)
    }
    
    func resetScene(deleteEveryThing:Bool) {
       if deleteEveryThing {
            self.removeAllActions()
            self.removeAllChildren()
       } else {
            self.removeAllChildren()
       }
    }
    
    func setUpLevel(b: Int, l: Int){
        resetScene(deleteEveryThing: true)
        if l > max[b-1] {
            let controller = self.view?.next as! GameViewController
            let levelVC = controller.storyboard?.instantiateViewController(identifier: "levelVC") as! LevelSelectViewController
            controller.navigationController?.pushViewController(levelVC, animated: true)
            UserDefaults.standard.set(1, forKey: "building\(b)")
            return
        }
        UserDefaults.standard.set(l, forKey: "building\(b)")
        build = b
        level = l
        self.physicsWorld.contactDelegate = self
        
        //Importing the level
        var size = 0
        let fileName = "B\(build)L\(level)"
        var len = 0
        var file = ""
        var start = 0
        var end = 0
        if let filepath = Bundle.main.path(forResource: fileName, ofType: ".txt"){
            do{
                file = try String(contentsOfFile: filepath)
                let myStrings = file.replacingOccurrences(of:"\r\n", with: "\n").split(separator: "\n")
                let line = myStrings[0]
                
                size = Int(line.split(separator: " ")[0])!
                len = Int(edgeRect.width)/size
                for j in 1...size {
                    let nums = myStrings[j].split(separator: " ")
                    for i in 1...size{
                        var num = Int(nums[i-1])!
                        //top
                        if(j == 1 || num%2 == 1){
                            self.addChild(WallNode(wallRect: CGRect(x: (2*i-size-2)*len/2, y: (size-2*j+3)*len/2-1, width: len+1, height: 3)).node)
                            if(j == 1 && num%2 == 0){
                                start = i
                            }
                        }
                        num /= 2
                        //right
                        if(num%2 == 1){
                            self.addChild(WallNode(wallRect: CGRect(x: (2*i-size)*len/2-1, y: (size-2*j+1)*len/2, width: 3, height: len+1)).node)
                        }
                        num/=2
                        //bottom
                        if(j == size || num%2 == 1){
                            self.addChild(WallNode(wallRect: CGRect(x: (2*i-size-2)*len/2, y: (size-2*j+1)*len/2-1, width: len+1, height: 3)).node)
                        }
                        num /= 2
                        //left
                        if(num%2 == 1){
                            self.addChild(WallNode(wallRect: CGRect(x: (2*i-size-2)*len/2-1, y: (size-2*j+1)*len/2, width: 3, height: len+1)).node)
                        }
                    }
                }
                
                for j in 1...2*size {
                    let nums = myStrings[j+1+size].split(separator: " ")
                    for i in 1...2*size {
                        let num = Int(nums[i-1])
                        switch num {
                        case 1:
                            self.addChild(HoleNode(radius: CGFloat(len)/5, pos: CGPoint(x:(2*i-2*size-1)*len/4, y:(2*size-2*j+3)*len/4)).node)
                        default:
                            1
                        }
                    }
                }
            }catch{
                
            }
        }
        
        let nodeWidth = len*2/3
        
        //Setting up the start
        startNode = StartNode(endRect: CGRect(x: (2*start-size-1)*len/2 - nodeWidth/2, y: ((size+1)*len)/2-5-nodeWidth, width: nodeWidth, height: nodeWidth), corRad: CGFloat(50)/CGFloat(size)).node
        self.addChild(startNode)
        
        //Setting up the player's ball
        if !fell {
            playerPos = CGPoint(x:(2*start-size-1)*len/2, y:size*len/2)
        }
        fell = false
        player = PlayerNode(radius: CGFloat(len)/5, pos: playerPos).node
        self.addChild(player)
        
        end = start + (size+1)%2
        //Setting up the end
        endNode = EndNode(endRect: CGRect(x: (2*end-size-1)*len/2 - nodeWidth/2, y: ((-size+1)*len)/2+5, width: nodeWidth, height: nodeWidth), corRad: CGFloat(50)/CGFloat(size)).node
        self.addChild(endNode)
        
        //Setting up the tilting physics
        timeSinceLoad = 0.0
        mapSize = size
        self.run(SKAction.fadeAlpha(to: 1, duration: 0.25), completion: {self.setUpTilting()})
    }
    
    func setUpTilting(){
        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.1
        manager.startAccelerometerUpdates(to: OperationQueue.main, withHandler: {
            (aData, error) in
            
            self.setGravity(data: aData)
        })
        
    }
    
    override func willMove(from view: SKView) {
        resetScene(deleteEveryThing: true)
    }
    
    func setGravity(data: CMAccelerometerData?){
        if data != nil {
            self.physicsWorld.gravity = CGVector(dx:CGFloat(Double(-100)/Double(self.mapSize)*(data?.acceleration.y)!), dy:CGFloat(Double(100)/Double(self.mapSize)*(data?.acceleration.x)!))
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //player.category = 1, start.category = 2, end.category = 3
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        if (bodyA.contactTestBitMask == 1 && bodyB.contactTestBitMask == 2) || (bodyA.contactTestBitMask == 2 && bodyB.contactTestBitMask == 1) {
            self.physicsWorld.speed = 0
            player.physicsBody?.affectedByGravity = false
            player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            fell = true
            if bodyA.contactTestBitMask == 2 {
                playerPos = bodyA.node?.position as! CGPoint
            }else{
                playerPos = bodyB.node?.position as! CGPoint
            }
            self.run(SKAction.fadeAlpha(to: 0, duration: 0.25), completion: {self.setUpLevel(b: self.build, l: self.level-1)})
        }else if (bodyA.contactTestBitMask == 1 && bodyB.contactTestBitMask == 3) || (bodyA.contactTestBitMask == 3 && bodyB.contactTestBitMask == 1) {
            self.physicsWorld.speed = 0
            player.physicsBody?.affectedByGravity = false
            player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            self.run(SKAction.fadeAlpha(to: 0, duration: 0.25), completion: {self.setUpLevel(b: self.build, l: self.level+1)})
        }
    }
    
    var lastTime = 0.0
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        let currAlpha = abs(sin(2*currentTime))
        startNode.strokeColor = startNode.strokeColor.withAlphaComponent(CGFloat(currAlpha))
        endNode.strokeColor = endNode.strokeColor.withAlphaComponent(CGFloat(currAlpha))
        if(lastTime == 0.0){
            lastTime = currentTime
        }else if(currentTime - lastTime >= 0.1){
            timeSinceLoad += currentTime-lastTime
            lastTime = currentTime
        }
        
        if(timeSinceLoad <= 1.25){
            player.position = playerPos
            player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        }else{
            self.physicsWorld.speed = 1
        }
    }
}
