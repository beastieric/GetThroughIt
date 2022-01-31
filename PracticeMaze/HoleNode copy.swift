//
//  HoleNode.swift
//  PracticeMaze
//
//  Created by Jiajun's Computer on 7/22/20.
//  Copyright © 2020 Jiajun Yan. All rights reserved.
//

import UIKit
import SpriteKit

class HoleNode {
    let node : SKShapeNode
    init(radius: CGFloat, pos : CGPoint) {
        node = SKShapeNode(circleOfRadius: radius)
        node.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        node.physicsBody?.categoryBitMask = 1
        node.physicsBody?.collisionBitMask = 2
        node.physicsBody?.fieldBitMask = 1
        node.physicsBody?.contactTestBitMask = 2
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.allowsRotation = false
        node.physicsBody?.isDynamic = false
        node.fillColor = .brown
        node.lineWidth = 0
        node.position = pos
    }
}
