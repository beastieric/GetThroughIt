//
//  PlayerNode.swift
//  PracticeMaze
//
//  Created by Jiajun's Computer on 7/22/20.
//  Copyright © 2020 Jiajun Yan. All rights reserved.
//

import UIKit
import SpriteKit

class PlayerNode {
    let node : SKShapeNode
    init(radius: CGFloat, pos : CGPoint) {
        node = SKShapeNode(circleOfRadius: radius)
        node.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        node.physicsBody?.categoryBitMask = 1
        node.physicsBody?.collisionBitMask = 2
        node.physicsBody?.fieldBitMask = 1
        node.physicsBody?.contactTestBitMask = 1
        node.physicsBody?.linearDamping = 1
        node.fillColor = .white
        node.lineWidth = 0
        node.zPosition = 10
        node.position = pos
    }
}
