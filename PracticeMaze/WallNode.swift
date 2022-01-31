//
//  WallNode.swift
//  PracticeMaze
//
//  Created by Jiajun's Computer on 7/22/20.
//  Copyright © 2020 Jiajun Yan. All rights reserved.
//

import UIKit
import SpriteKit

class WallNode {
    let node : SKShapeNode
    init(wallRect: CGRect) {
        node = SKShapeNode(rect: wallRect)
        node.fillColor = .brown
        node.lineWidth = 0
        node.physicsBody = SKPhysicsBody(edgeLoopFrom: wallRect)
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.allowsRotation = false
        node.physicsBody?.isDynamic = false
    }
}
